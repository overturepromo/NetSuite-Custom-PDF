/*
*Author: Braxton Lancial (RSM)
*Date: 1/4/2016
*Description: Scheduled Script responsible for consolidating invoices, called from suitelet* 
*/

var ScriptBase;
var cu = McGladrey.CommonUtilities;

var ScriptVariables = {
    HTML_Template: 1379,     //production ID
    Folder: 164,             //production ID
    //HTML_Template: 6473,       //Sandbox ID
    //Folder: 181,               //Sandbox ID 
    ParentCI_Name: null,
    Class: {
        Webstore: 2
    }
};

var ModClasses = {
    PrintedInvoice: function () {
        this.ConsolidatedInvoicePeriod = null;
        this.CustomerName = null;
        this.SoldTo = null;
        this.ShipTo = null;
        this.CustomerNumber = null;
        this.CustomerPO_Header = null;
        this.SalesPerson = null;
        this.Via = null;
        this.InvoiceDate = null;
        this.InvoiceNumber = null;
        this.PhoneNumber = null;
        this.SoldToName = null;
        this.SoldToAttention = null;
        this.SoldToStreet = null;
        this.SoldToApartmentNumber = null;
        this.City_State_Zip = null;
        this.Subtotal = parseFloat(0.00);
        this.Insurance = parseFloat(0.00);
        this.ShippingHandling = parseFloat(0.00);
        this.SalesTax = parseFloat(0.00);
        this.Total = parseFloat(0.00);
        this.Terms = null;
        this.ItemDetails = [];
        this.SystemDetails = [];
        this.LogoUrl = null;
    },
    InvoiceItemDetails: function () {
        this.Id = null;
        this.Ordered = parseInt(0);
        //this.Shipped = parseInt(0);
        //this.QuantityBackordered = parseInt(0);
        this.ItemNum = null;
        this.Description = null;
        this.Price = parseFloat(0.00);
        this.Per = null;
        this.Amount = parseFloat(0.00);
    },
    SystemInvoiceDetails: function () {
        this.InvoiceNumber = null;
        this.OrderNumber = null;
        this.ShipToName = null;
        this.ShipToStreet = null;
        this.ShipToApartmentNumber = null;
        this.ShipToAttention = null;
        this.City_State_Zip = null;
        this.Country = null;
        this.Attention = null;
        this.CustomerPO = null;
        this.CustomerProgram = null;
        this.Lines = [];    //array of type 'SystemInvoiceDetailLines'
        this.LastLineTotal_TotalPrice = parseFloat(0.00);
        this.LastLineTotal_Freight = parseFloat(0.00);
        this.LastLineTotal_Tax = parseFloat(0.00);
        this.LastLineTotal_Total = parseFloat(0.00);
    },
    SystemInvoiceDetailLines: function () {
        this.ShipDate = null;
        this.QtyOrd = parseInt(0);
        this.QtyShip = parseInt(0);
        this.ItemNumber = null;
        this.Description = null;
        this.PricePer = parseFloat(0.00);
        this.Per = parseFloat(0.00);
        this.TotalPrice = parseFloat(0.00);
        this.RawTotalPrice = parseFloat(0.00);  //this is for computations only, while the other TotalPrice gets formatted for currency
    }
};

var Events = {

    /*
     * Main entry point
     */
    Main: function () {
        ScriptBase = new McGladrey.Script.Scheduled();

        try {

            var startBench = ScriptBase.Log.StartBenchmark(ScriptBase.EventName);

            //processing logic
            Modules.getParameters();

            //var UNIT_TEST = true;
            //if (UNIT_TEST)
            //{
            //    ScriptBase.Log.Audit("This ran.");
            //    var tempId = ScriptBase.Parameters.custscript_consol_inv_parentid
            //    var subMemo = nlapiSubmitField('customrecord_consolidated_invoice_parent', tempId, 'custrecord_ci_parent_memo', "Test Scheduled Script Running");
            //    return;
            //}

            Modules.createConsolidatedInvoices(ScriptBase.Parameters.custscript_consol_inv_parentid, ScriptBase.Parameters.custscript_consol_inv_emailtoo);

            ScriptBase.Log.EndBenchmark(ScriptBase.EventName, startBench);
        }
        catch (err) {
            if (err instanceof nlobjError) {
                ScriptBase.Log.ErrorObject('Unknown nlobjError', err);
            }
            else {
                ScriptBase.Log.Error('Unknown Error', err.message);
            }

            throw err;
        }
    }
};


var Modules = (function () {


    //retrieves request parameters from client script
    function getParameters() {
        ScriptBase.GetParameters(['custscript_consol_inv_parentid']);
        ScriptBase.GetParameters(['custscript_consol_inv_sender']);
        ScriptBase.GetParameters(['custscript_consol_inv_recips']);
        ScriptBase.GetParameters(['custscript_consol_inv_logourl']);
        ScriptBase.GetParameters(['custscript_bluesodapromologo']);
        ScriptBase.GetParameters(['custscript_overturelogo']);
        ScriptBase.GetParameters(['custscript_bsp_department']);
    };



    /*
    * @author Braxton Lancial
    * @param ID of Parent Record ci_Parent 
    * @returns null
    * @description 
    * Usage: 0 points
    */
    function createConsolidatedInvoices(ci_Parent, emailToo) {
        var systemInvoiceIds = getSystemInvoiceIds(ci_Parent);

        var built_PrintedInvoiceObject = buildConsolidatedInvPDF(systemInvoiceIds, ci_Parent, emailToo);

    }

    return {
        createConsolidatedInvoices: createConsolidatedInvoices,
        getParameters: getParameters
    };

})();


/*
    * @author Braxton Lancial
    * @param  ID of Parent Record ci_Parent
    * @returns Array of System Invoice id's of that parent
    * @description Searches and retrieves System Invoice id's related to Parent CI
    * Usage: 10 points
    */
function getSystemInvoiceIds(ci_Parent) {
    var toReturn = [];
    var f = [];
    var c = [];

    f.push(new nlobjSearchFilter('custrecord_consolidated_invoice_parent', null, 'anyof', ci_Parent));
    f.push(new nlobjSearchFilter('isinactive', null, 'is', 'F'));
    c.push(new nlobjSearchColumn('custrecord_ci_child_systeminvoice'));

    //var res = nlapiSearchRecord('customrecord_consolidated_invoice_child', null, f, c);
    var res = McGladrey.ScriptUtilities.Search.GetAllResults(nlapiCreateSearch('customrecord_consolidated_invoice_child', f, c));

    if (!cu.IsNullOrEmpty(res) && res.length > 0) {
        for (var i = 0; i < res.length; i++) {
            toReturn.push(res[i].getValue('custrecord_ci_child_systeminvoice'));
        }
    }

    return toReturn;
}


/*
    * @author Braxton Lancial
    * @param  array System Invoice IDs, CI Parent record id
    * @returns PrintedInvoice object
    * @description Builds PrintedInvoice object based on Invoice data
    * Usage: 72 + (10 * systemInvIds.length) points
    */
function buildConsolidatedInvPDF(systemInvIds, ci_ParentId, emailToo) {
    //Instantiate master object
    var INV_OBJECT = new ModClasses.PrintedInvoice();

    //Caching data
    var rec_ParentCI = nlapiLoadRecord('customrecord_consolidated_invoice_parent', ci_ParentId);    //2 points
    var customerInfo = getCustomerInfo(rec_ParentCI.getFieldValue('custrecord_ci_parent_invoicecustomer')); //10 points
    var customerInfo_Text = getCustomerInfo_Text(rec_ParentCI.getFieldValue('custrecord_ci_parent_invoicecustomer'));   //10 points
    var systemInvoicesSearchResults = getSystemInvoiceSearchResults(systemInvIds);  //10 points
    var invoiceInfo = getInvoiceInfo(systemInvoicesSearchResults);
    var details = build_Details(systemInvIds);  //(10 * systemInvIds.length) points
    var current_EmailSub = rec_ParentCI.getFieldValue('custrecord_ci_parent_emailsub');
    var current_EmailMess = rec_ParentCI.getFieldValue('custrecord_ci_parent_emailmess');
    ScriptVariables.ParentCI_Name = rec_ParentCI.getFieldValue('name');

    //Setting Invoice Object properties    
    INV_OBJECT.ConsolidatedInvoicePeriod = rec_ParentCI.getFieldValue('custrecord_ci_parent_period');
    INV_OBJECT.CustomerName = customerInfo.companyname;
    INV_OBJECT.ShipTo = "CONSOLIDATED INVOICE";
    INV_OBJECT.CustomerNumber = customerInfo.entityid;
    INV_OBJECT.CustomerPO_Header = rec_ParentCI.getFieldValue('custrecord_ci_parent_customerpo');
    INV_OBJECT.SalesPerson = customerInfo_Text.salesrep;
    INV_OBJECT.InvoiceDate = getDateFormatted(rec_ParentCI.getFieldValue('custrecord_ci_parent_invoicedate'));
    INV_OBJECT.InvoiceNumber = rec_ParentCI.getFieldValue('name');
    INV_OBJECT.PhoneNumber = customerInfo.phone;
    INV_OBJECT.SoldToName = customerInfo.companyname;
    var tempAttn = rec_ParentCI.getFieldValue('custrecord_ci_parent_attn');
    if (cu.IsNullOrEmpty(tempAttn))
        tempAttn = " ";
    INV_OBJECT.SoldToAttention = "ATTN: " + tempAttn;
    INV_OBJECT.SoldToStreet = rec_ParentCI.getFieldValue('custrecord_ci_parent_street');
    INV_OBJECT.City_State_Zip = getCityStateZip(rec_ParentCI.getFieldValue('custrecord_ci_parent_city'), rec_ParentCI.getFieldValue('custrecord_ci_parent_state'), rec_ParentCI.getFieldValue('custrecord_ci_parent_zip'));
    INV_OBJECT.SoldTo = formatAddress(customerInfo.entityid, rec_ParentCI.getFieldValue('custrecord_ci_parent_attn'), rec_ParentCI.getFieldValue('custrecord_ci_parent_street'), rec_ParentCI.getFieldValue('custrecord_ci_parent_attn'), INV_OBJECT.City_State_Zip);
    INV_OBJECT.Insurance = formatCurrency(invoiceInfo.TotalInsurance);
    INV_OBJECT.ShippingHandling = formatCurrency(details.ShipHandleForBody);
    INV_OBJECT.SalesTax = formatCurrency(invoiceInfo.TotalSalesTax);
    INV_OBJECT.Total = formatCurrency(invoiceInfo.TotalAmount);
    INV_OBJECT.Terms = customerInfo_Text.terms;
    INV_OBJECT.LogoUrl = getWhichLogo(systemInvoicesSearchResults);
    INV_OBJECT.ItemDetails = details.Details;
    INV_OBJECT.SystemDetails = details.SystemInvoiceDetails;
    INV_OBJECT.Subtotal = formatCurrency(parseFloat(parseFloat(invoiceInfo.TotalAmount) - parseFloat(invoiceInfo.TotalSalesTax) - parseFloat(details.ShipHandleForBody) - parseFloat(invoiceInfo.TotalInsurance)));

    ScriptBase.CheckUsage(10);
    var printedInvoicePDF = nlapiXMLToPDF(getHtmlOutput(INV_OBJECT, ScriptVariables.HTML_Template));    //10 points

    //Save to file cabinet
    ScriptBase.CheckUsage(20);
    var existAlready = fileHandler((INV_OBJECT.CustomerNumber.toString() + "_" + todayDateFormatted_ForFileName() + '.pdf'));
    printedInvoicePDF.setName(INV_OBJECT.CustomerNumber.toString() + "_" + todayDateFormatted_ForFileName() + '.pdf');
    printedInvoicePDF.setFolder(ScriptVariables.Folder);
    var submittedFile = nlapiSubmitFile(printedInvoicePDF); //20 points

    //Attach to CI record
    nlapiAttachRecord('file', submittedFile, 'customrecord_consolidated_invoice_parent', ci_ParentId);  //10 points
    //get attachments to send via email
    var tempAttachments = [];
    tempAttachments.push(printedInvoicePDF);

    //Email out invoices
    if (cu.IsNullOrEmpty(emailToo))
        emailToo = rec_ParentCI.getFieldValue('custrecord_ci_parent_emailtoo');
    if (!cu.IsNullOrEmpty(emailToo) && (emailToo == 'T' || emailToo == true)) {
        ScriptBase.CheckUsage(10);
        var sender; //HERE -- MUST GET SENDER
        var recips; //HERE -- MUST GET RECIPIENTS
        var emailsSent = emailInvoices(null, null, tempAttachments, INV_OBJECT.InvoiceNumber, current_EmailSub, current_EmailMess);   //10 points    
    }
}


/*
* @author Braxton Lancial
* @param string fileName
* @returns bool doesExist already
* @description See if a file already exists with that name. Deletes if it does
* Usage: 20 points
*/
function fileHandler(fileName) {
    var doesExist = false;

    var f = [];
    var c = [];

    f.push(new nlobjSearchFilter('name', null, 'is', fileName));

    var res = nlapiSearchRecord('file', null, f, null);

    if (!cu.IsNullOrEmpty(res) && res.length > 0)
        doesExist = true;

    if (doesExist) {
        nlapiDeleteFile(res[0].id);
    }

    return doesExist;
}


/*
* @author Braxton Lancial
* @param nlobjSearchResult[]
* @returns string logoUrl
* @description Gets appropriate logo based on business rules. "If all invoices are Department BSG and custom checkbox NOT checked, use BSG logo"
* Usage: 0 points
*/
function getWhichLogo(invResults) {
    for (var i = 0; i < invResults.length; i++) {
        if ((invResults[i].getValue('custbody_bsp_customer_with_contract') == 'F') && invResults[i].getValue('department') == ScriptBase.Parameters.custscript_bsp_department) {
            continue;
        }
        else {
            return ScriptBase.Parameters.custscript_overturelogo;
        }
    }

    return ScriptBase.Parameters.custscript_bluesodapromologo;
}



/*
* @author Braxton Lancial
* @param string customerName, string attn, string street, string apt, string cityStateZip
* @returns string address format
* @description Formats address appropriately
* Usage: 0 points
*/
function formatAddress(customerName, attn, street, apt, cityStateZip) {
    var str = '';

    str += customerName + '< br/>';
    str += attn + '< br/>';
    str += street + '< br/>';
    if (!cu.IsNullOrEmpty(apt))
        str += apt + '< br/>';
    str += cityStateZip;

    return str;
}



/*
* @author Braxton Lancial
* @param float number, 
* @returns currency formatted string
* @description Formats a number as US currency
* Usage: 0 points
*/
function formatCurrency(number) {
    if (cu.IsNullOrEmpty(number)) {
        number = parseFloat(0.00);
    }
    var temp = parseFloat(parseFloat(Math.round(parseFloat(number) * 100)) / 100).toFixed(2);
    var currencied = ScriptBase.CU.Formatting.Number.Currency(temp, 2).toString();

    return currencied;
}


/*
    * @author Braxton Lancial
    * @param  
    * @returns 
    * @description 
    * Usage 0 points
    */
function todayDateFormatted_ForFileName() {
    var today = new Date();
    var dd = today.getDate();
    var mm = today.getMonth() + 1;
    var yyyy = today.getFullYear();
    var todayFormatted = mm + '_' + dd + '_' + yyyy;

    return todayFormatted;
}



/*
    * @author Braxton Lancial
    * @param  int sender, string recips, File[] attachments
    * @returns bool completed, depending on whether successful send or not
    * @description Sends invoices via email
    * Usage 10 points
    */
function emailInvoices(sender, recips, attachments, invNum, sub, mess) {
    var success = true;

    var subToUse = "";
    if (cu.IsNullOrEmpty(sub) || sub == "Invoice #")
        subToUse = 'Invoice # ' + invNum.toString();
    else
        subToUse = sub;

    var body = "";
    if (cu.IsNullOrEmpty(mess))
        body = 'Thank you for your business!';
    else
        body = mess;

    try {
        nlapiSendEmail(sender, recips, subToUse, body, attachments);
    }
    catch (e) {
        success = false;
    }

    return success;
}




/*
    * @author Braxton Lancial
    * @param  PrintedInvoiceObject objectToRender, internal id of HTML template file templateFile
    * @returns string htmlOutput
    * @description Gets the HTML output using Mustache to do rendering of object data to HTML file
    * Usage 10 points
    */
function getHtmlOutput(objectToRender, templateFile) {
    var loadedFile = nlapiLoadFile(templateFile);
    loadedFile = loadedFile.getValue();

    var htmlOutput = '<?xml version=\"1.0\"?>\n<!DOCTYPE pdf PUBLIC \"-//big.faceless.org//report\" \"report-1.1.dtd\">';
    htmlOutput += '<pdf>';
    htmlOutput += Mustache.render(loadedFile, objectToRender);
    htmlOutput += '</pdf>';

    return htmlOutput;
}



/*
    * @author Braxton Lancial
    * @param  Customer internal id
    * @returns Customer data in object form
    * @description nlapiLookup of customer info
    * Usage 10 points
    */
function getCustomerProgram(id) {
    var program = nlapiLookupField('customer', id, ['custentity_customer_program'], true); //10 points

    return program.custentity_customer_program;
}



/*
    * @author Braxton Lancial
    * @param  Array Invoice idds
    * @returns Array with Array properties, returning InvoiceItemDetails objects and SystemInvoiceDetails objects
    * @description Builds out Array with Array properties, returning InvoiceItemDetails objects and SystemInvoiceDetails objects based on system invoices
    * Usage (20 * systemInvoiceIds.length) points
    */
function build_Details(systemInvoiceIds) {
    var obj = {
        Details: [],
        SystemInvoiceDetails: [],
        ShipHandleForBody: parseFloat(0.00)
    };

    var detailsToBuild = [];
    var arrSummaryItems = [];

    for (var i = 0; i < systemInvoiceIds.length; i++) {
        ScriptBase.CheckUsage(10);
        var rec_CurrentInv = null;
        rec_CurrentInv = nlapiLoadRecord('invoice', systemInvoiceIds[i]);   //10 points

        ScriptBase.CheckUsage(10);
        //SystemInvoiceDetails
        var currentSystemInvoiceDetail = new ModClasses.SystemInvoiceDetails();
        currentSystemInvoiceDetail.Attention = rec_CurrentInv.getFieldValue('shipattention');
        currentSystemInvoiceDetail.City_State_Zip = cu.IsNullOrEmpty(getCityStateZip(rec_CurrentInv.getFieldValue('shipcity'), rec_CurrentInv.getFieldValue('shipstate'), rec_CurrentInv.getFieldValue('shipzip'))) == true ? '' : getCityStateZip(rec_CurrentInv.getFieldValue('shipcity'), rec_CurrentInv.getFieldValue('shipstate'), rec_CurrentInv.getFieldValue('shipzip'));
        currentSystemInvoiceDetail.Country = cu.IsNullOrEmpty(rec_CurrentInv.getFieldValue('shipcountry')) == true ? '' : rec_CurrentInv.getFieldValue('shipcountry');
        currentSystemInvoiceDetail.CustomerPO = cu.IsNullOrEmpty(rec_CurrentInv.getFieldValue('otherrefnum')) == true ? '' : rec_CurrentInv.getFieldValue('otherrefnum');
        currentSystemInvoiceDetail.CustomerProgram = getCustomerProgram(rec_CurrentInv.getFieldValue('entity'));
        currentSystemInvoiceDetail.OrderNumber = rec_CurrentInv.getFieldValue('tranid');
        currentSystemInvoiceDetail.ShipToApartmentNumber = null;    //HERE??
        currentSystemInvoiceDetail.ShipToName = rec_CurrentInv.getFieldValue('shipaddressee');
        currentSystemInvoiceDetail.ShipToStreet = cu.IsNullOrEmpty(rec_CurrentInv.getFieldValue('shipaddr1')) == true ? '' : rec_CurrentInv.getFieldValue('shipaddr1');
        currentSystemInvoiceDetail.InvoiceNumber = ScriptVariables.ParentCI_Name;


        var lineItems = rec_CurrentInv.getLineItemCount('item');
        for (var j = 1; j <= lineItems; j++) {

            if (rec_CurrentInv.getLineItemValue('item', 'custcol_extend_hidefromprinting', j) == 'T') //if checkbox checked, don't create row
                continue;

            //InvoiceItemDetails
            var itemId = rec_CurrentInv.getLineItemValue('item', 'item', j);
            var rate = rec_CurrentInv.getLineItemValue('item', 'rate', j);
            var itemDetails = getItemDetails(arrSummaryItems, rate, itemId);

            if (cu.IsNullOrEmpty(itemDetails)) {
                var currentDetail = new ModClasses.InvoiceItemDetails();
                currentDetail.Id = itemId;
                currentDetail.Amount = rec_CurrentInv.getLineItemValue('item', 'amount', j);
                currentDetail.Description = rec_CurrentInv.getLineItemValue('item', 'description', j);
                var currentClass = rec_CurrentInv.getFieldValue('class');
                if (currentClass == ScriptVariables.Class.Webstore) {
                    currentDetail.ItemNum = rec_CurrentInv.getLineItemText('item', 'item', j);
                }
                else
                    currentDetail.ItemNum = "";
                currentDetail.Ordered = rec_CurrentInv.getLineItemValue('item', 'quantity', j);
                currentDetail.Price = rate;
                arrSummaryItems.push(currentDetail);
                //currentDetail.QuantityBackordered = cu.IsNullOrEmpty(rec_CurrentInv.getLineItemValue('item', 'quantityremaining', j)) == true ? parseFloat(0.00) : rec_CurrentInv.getLineItemValue('item', 'quantityremaining', j);
                //currentDetail.Shipped = parseFloat(parseFloat(currentDetail.Ordered) - parseFloat(currentDetail.QuantityBackordered));
                //obj.Details.push(currentDetail);
            }
            else {
                itemDetails.Amount = parseFloat(itemDetails.Amount) + parseFloat(rec_CurrentInv.getLineItemValue('item', 'amount', j));
                itemDetails.Ordered = parseInt(itemDetails.Ordered) + parseInt(rec_CurrentInv.getLineItemValue('item', 'quantity', j));
            }

            //SystemInvoiceDetailLines
            var currentLineDetail = new ModClasses.SystemInvoiceDetailLines();
            var backordered = cu.IsNullOrEmpty(rec_CurrentInv.getLineItemValue('item', 'quantityremaining', j)) == true ? parseFloat(0.00) : rec_CurrentInv.getLineItemValue('item', 'quantityremaining', j);
            currentLineDetail.Description = rec_CurrentInv.getLineItemValue('item', 'description', j);
            if (currentClass == ScriptVariables.Class.Webstore) {
                currentLineDetail.ItemNumber = rec_CurrentInv.getLineItemText('item', 'item', j);
            }
            else
                currentLineDetail.ItemNumber = "";
            currentLineDetail.Per = rec_CurrentInv.getLineItemValue('item', 'EA', j);   //HERE??
            currentLineDetail.PricePer = rec_CurrentInv.getLineItemValue('item', 'rate', j);
            currentLineDetail.QtyOrd = rec_CurrentInv.getLineItemValue('item', 'quantity', j);
            currentLineDetail.QtyShip = parseFloat(parseFloat(currentLineDetail.QtyOrd) - parseFloat(backordered));
            currentLineDetail.ShipDate = rec_CurrentInv.getFieldValue('custbody_invoice_sales_order_ship_date');
            currentLineDetail.TotalPrice = formatCurrency(rec_CurrentInv.getLineItemValue('item', 'amount', j));
            currentLineDetail.RawTotalPrice = rec_CurrentInv.getLineItemValue('item', 'amount', j);
            currentSystemInvoiceDetail.Lines.push(currentLineDetail);
        }

        var shipCost = cu.IsNullOrEmpty(rec_CurrentInv.getFieldValue('altshippingcost')) == true ? parseFloat(0.00) : rec_CurrentInv.getFieldValue('altshippingcost');
        var handCost = cu.IsNullOrEmpty(rec_CurrentInv.getFieldValue('althandlingcost')) == true ? parseFloat(0.00) : rec_CurrentInv.getFieldValue('althandlingcost');
        var temp_TotalPrice = getTotalPrice(currentSystemInvoiceDetail.Lines);
        var temp_Freight = parseFloat(parseFloat(shipCost) + parseFloat(handCost));
        var temp_TotalTax = cu.IsNullOrEmpty(rec_CurrentInv.getFieldValue('taxtotal')) == true ? parseFloat(0.00) : rec_CurrentInv.getFieldValue('taxtotal');
        currentSystemInvoiceDetail.LastLineTotal_TotalPrice = formatCurrency(temp_TotalPrice);
        currentSystemInvoiceDetail.LastLineTotal_Freight = formatCurrency(temp_Freight);    //HERE???
        currentSystemInvoiceDetail.LastLineTotal_Tax = formatCurrency(temp_TotalTax);
        currentSystemInvoiceDetail.LastLineTotal_Total = formatCurrency(parseFloat(parseFloat(temp_TotalPrice) + parseFloat(temp_Freight) + parseFloat(temp_TotalTax)));
        obj.SystemInvoiceDetails.push(currentSystemInvoiceDetail);
        obj.ShipHandleForBody = parseFloat(parseFloat(obj.ShipHandleForBody) + parseFloat(shipCost) + parseFloat(handCost));
    }

    //Format Amount
    for (var j = 0; j < arrSummaryItems.length; j++) {
        arrSummaryItems[j].Amount = ScriptBase.CU.Formatting.Number.AddCommas(arrSummaryItems[j].Amount, 2);
        //arrSummaryItems[j].Ordered = ScriptBase.CU.Formatting.Number.AddCommas(arrSummaryItems[j].Ordered, 0);
    }
    obj.Details = arrSummaryItems;
    // Sort invoices by document number
    obj.SystemInvoiceDetails = Enumerable.From(obj.SystemInvoiceDetails)
                .OrderBy(function (x) { return x.OrderNumber })
                .ToArray();
    return obj;
}


/*
    * @author Braxton Lancial
    * @param  array of SystemInvoiceDetailLines objects
    * @returns float totalPrice
    * @description Gets summed values and returns them
    * Usage: 0 points
    */
function getTotalPrice(lineData) {
    var totalPrice = parseFloat(0.00);

    for (var i = 0; i < lineData.length; i++) {
        totalPrice = parseFloat(parseFloat(totalPrice) + parseFloat(lineData[i].RawTotalPrice));
    }

    return totalPrice;
}




/*
    * @author Braxton Lancial
    * @param  Customer internal id
    * @returns Object of Customer information 
    * @description Retrieves data from Customer record in an object so can easily add to this function if needed
    * Usage: 10 points
    */
function getInvoiceInfo(results) {
    var obj = {
        TotalSalesTax: parseFloat(0.00),
        TotalAmount: parseFloat(0.00),
        TotalInsurance: parseFloat(0.00)
    };

    for (var i = 0; i < results.length; i++) {
        var taxHere = cu.IsNullOrEmpty(results[i].getValue('taxtotal')) == true ? parseFloat(0.00) : results[i].getValue('taxtotal');
        var totalHere = cu.IsNullOrEmpty(results[i].getValue('total')) == true ? parseFloat(0.00) : results[i].getValue('total');
        var insuranceHere = parseFloat(0.00);       //HERE!                

        obj.TotalSalesTax = parseFloat(parseFloat(obj.TotalSalesTax) + parseFloat(taxHere));
        obj.TotalAmount = parseFloat(parseFloat(obj.TotalAmount) + parseFloat(totalHere));
        obj.TotalInsurance = parseFloat(parseFloat(obj.TotalInsurance) + parseFloat(insuranceHere));
    }

    return obj;

}


/*
    * @author Braxton Lancial
    * @param  Customer internal id
    * @returns Object of Customer information 
    * @description Retrieves data from Customer record in an object so can easily add to this function if needed
    * Usage: 10 points
    */
function getCustomerInfo(id) {
    var info = nlapiLookupField('customer', id, ['entityid', 'salesrep', 'city', 'state', 'address1', 'zipcode', 'country', 'attention', 'phone', 'companyname', 'terms']);


    return info;
}



/*
    * @author Braxton Lancial
    * @param  Customer internal id
    * @returns Object of Customer information 
    * @description Retrieves TEXT data from Customer record in an object so can easily add to this function if needed
    * Usage: 10 points
    */
function getCustomerInfo_Text(id) {
    var info = nlapiLookupField('customer', id, ['salesrep', 'terms'], true);


    return info;
}




/*
    * @author Braxton Lancial
    * @param Array invoice ids
    * @returns Array Invoice search results
    * @description Gets invoice search results based on Invoice Internal Ids so can get column info on invoices
    * Usage: 10 points
    */
function getSystemInvoiceSearchResults(ids) {
    var f = [];
    var c = [];

    f.push(new nlobjSearchFilter('internalid', null, 'anyof', ids));
    f.push(new nlobjSearchFilter('mainline', null, 'is', 'T'));
    c.push(new nlobjSearchColumn('trandate'));
    c.push(new nlobjSearchColumn('tranid'));
    c.push(new nlobjSearchColumn('amountremaining'));
    c.push(new nlobjSearchColumn('total'));
    c.push(new nlobjSearchColumn('taxtotal'));
    c.push(new nlobjSearchColumn('total'));
    c.push(new nlobjSearchColumn('custbody_bsp_customer_with_contract'));
    c.push(new nlobjSearchColumn('department'));

    //var results = nlapiSearchRecord('invoice', null, f, c);
    var search = nlapiCreateSearch('invoice', f, c);
    search = search.runSearch();
    var results = retrieveResults(search, [], 2000, 0, 1000); // Usage:20

    return results;

}

/*
     * @author Karla Gomez
     * @param parent customer
     * @returns array of invoices
     * @description Gets invoice search results 
     * Usage: 20 points
     */
function retrieveResults(resultSet, results, limit, start, end) {
    if (start < limit) {
        // Usage:10
        var page = resultSet.getResults(start, end);

        for (var i = 0; i < page.length; i++) {
            results.push(page[i]);
        }

        if (page.length == 1000)
            retrieveResults(resultSet, results, limit, (start + 1000), (end + 1000));
    }

    return results;
}


/*
    * @author Braxton Lancial
    * @param string date
    * @returns string formatted for mm/dd/yyyy
    * @description Function returns date, in proper format
    * Usage: 0 points
    */
function getDateFormatted(date) {
    var today = new Date(date);
    var dd = today.getDate();
    var mm = today.getMonth() + 1;
    var yyyy = today.getFullYear();
    var todayFormatted = mm + '/' + dd + '/' + yyyy;

    return todayFormatted;
}


/*
    * @author Braxton Lancial
    * @param  string city, string state, string zip
    * @returns string concatenation of city, state zip
    * @description Formats a city, state, and zip into appropriate format
    * Usage: 0 points
    */
function getCityStateZip(city, state, zip) {
    var str = '';

    if (cu.IsNullOrEmpty(city) && cu.IsNullOrEmpty(state) && cu.IsNullOrEmpty(zip))
        return str;

    str = city + ", " + state + " " + zip;
    return str;
}

/*
    * @author Karla Gomez
    * @description Gets item object based on internal id and rate
    * Usage: 0 points
    */
function getItemDetails(arrItems, rate, id) {
    var objItem = null;

    for (i = 0; i < arrItems.length; i++) {
        if (arrItems[i].Id == id && arrItems[i].Price == rate) {
            objItem = arrItems[i];
            break;
        }
    }
    return objItem;
}

function pause(waitTime) { //seconds
    try {
        var endTime = new Date().getTime() + waitTime * 1000;
        var now = null;
        do {
            //throw in an API call to eat time
            now = new Date().getTime(); //
        } while (now < endTime);
    } catch (e) {
        nlapiLogExecution("ERROR", "not enough sleep");
    }
}