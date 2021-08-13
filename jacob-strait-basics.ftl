<?xml version="1.0"?><!DOCTYPE pdf PUBLIC "-//big.faceless.org//report" "report-1.1.dtd">
<pdf>
<head>
	<link name="NotoSans" type="font" subtype="truetype" src="${nsfont.NotoSans_Regular}" src-bold="${nsfont.NotoSans_Bold}" src-italic="${nsfont.NotoSans_Italic}" src-bolditalic="${nsfont.NotoSans_BoldItalic}" bytes="2" />
	<#if .locale == "zh_CN">
		<link name="NotoSansCJKsc" type="font" subtype="opentype" src="${nsfont.NotoSansCJKsc_Regular}" src-bold="${nsfont.NotoSansCJKsc_Bold}" bytes="2" />
	<#elseif .locale == "zh_TW">
		<link name="NotoSansCJKtc" type="font" subtype="opentype" src="${nsfont.NotoSansCJKtc_Regular}" src-bold="${nsfont.NotoSansCJKtc_Bold}" bytes="2" />
	<#elseif .locale == "ja_JP">
		<link name="NotoSansCJKjp" type="font" subtype="opentype" src="${nsfont.NotoSansCJKjp_Regular}" src-bold="${nsfont.NotoSansCJKjp_Bold}" bytes="2" />
	<#elseif .locale == "ko_KR">
		<link name="NotoSansCJKkr" type="font" subtype="opentype" src="${nsfont.NotoSansCJKkr_Regular}" src-bold="${nsfont.NotoSansCJKkr_Bold}" bytes="2" />
	<#elseif .locale == "th_TH">
		<link name="NotoSansThai" type="font" subtype="opentype" src="${nsfont.NotoSansThai_Regular}" src-bold="${nsfont.NotoSansThai_Bold}" bytes="2" />
	</#if>
    <macrolist>
        <macro id="nlheader">
            <table class="header" style="width: 100%;">
                <tr class="logo">
                    <td class="logo-wrap">
                        <#if record.department?string == 'BSP' || record.department?string == 'BSP : Inbound'>
                        <#if record.custbody_bsp_customer_with_contract == false>
                        <img height="22" src="https://system.na1.netsuite.com/core/media/media.nl?id=108109&amp;c=544356&amp;h=53840ea4c890357f8ae6" width="144" />
                        <#else>
                        <img height="17" src="https://system.na1.netsuite.com/core/media/media.nl?id=108112&amp;c=544356&amp;h=184768514beedc40b08a" width="144" /> 
                        </#if>
                        <#else> 
                        <img height="17" src="https://system.na1.netsuite.com/core/media/media.nl?id=108112&amp;c=544356&amp;h=184768514beedc40b08a" width="144" /> 
                        </#if>
                    </td>
                </tr>
	            <tr>
                    <td rowspan="3"><span class="nameandaddress"><#if record.department?string == 'BSP' || record.department?string == 'BSP : Inbound'><#if record.custbody_bsp_customer_with_contract == false>Blue Soda Promo</#if><#else>${companyInformation.companyName}</#if></span><br /><span class="nameandaddress">${companyInformation.returnaddress_text}</span></td>
                    <#if record.department?string == 'BSP' || record.department?string == 'BSP : Inbound'>
                        <#if record.custbody_bsp_customer_with_contract == false>
                            <td rowspan="3"><span class="nameandaddress">Toll Free: 1-888-206-3047</span></td>
                        </#if>
                        <#else> 
                            <td rowspan="3"><span class="nameandaddress">Toll Free: 1-888-456-9564<br />Phone: 1-847-573-6080</span></td>
                    </#if>
                    <td align="right"><span class="title">${record@title}</span></td>
                </tr>
                <tr>
                    <td align="right"><span class="number"># ${record.invoicegroupnumber}</span></td>
                </tr>
                <tr>
                    <td align="right">${record.trandate}</td>
                </tr>
            </table>
        </macro>
        <macro id="nlfooter">
            <table class="footer" style="width: 100%;">
                <tr>
                    <td>I'm a footer</td>
                    <td align="right"><pagenumber/> of <totalpages/></td>
                </tr>
            </table>
        </macro>
    </macrolist>
      <style type="text/css">
	tr.logo {
	  	display: inline;
	  	padding-top:24px;
	  }
	  td.logo-wrap {
	  	padding-left:44px;
	  	padding-bottom:12px;
	  	padding-right:0;
	  	padding-top:0;
	  }
	  td {
	      padding: 4px 6px;
	  }
	  b {
	      font-weight: bold;
	      color: #333333;
	  }
	  table.header td {
	      padding: 0px;
	      font-size: 10pt;
	  }
	  table.footer td {
	      padding: 0px;
	      font-size: 8pt;
	  }
	  table.itemtable th {
	      padding-bottom: 10px;
	      padding-top: 10px;
	  }
	  table.body td {
	      padding-top: 2px;
	  }
	  table.total {
	      page-break-inside: avoid;
	  }
	  td.addressheader {
	      font-size: 8pt;
	      padding-top: 6px;
	      padding-bottom: 2px;
	  }
	  td.address {
	      padding-top: 0px;
	  }
	  span.title {
	      font-size: 28pt;
	  }
	  span.number {
	      font-size: 16pt;
	  }
	  span.itemname {
	      font-weight: bold;
	      line-height: 150%;
	  }
	  hr {
	      width: 100%;
	      color: #d3d3d3;
	      background-color: #d3d3d3;
	      height: 1px;
	  }
</style>
</head>
<body header="nlheader" header-height="10%" footer="nlfooter" footer-height="20pt" padding="0.5in 0.5in 0.5in 0.5in" size="Letter">
&nbsp;

<#-- Primary Billing table -->
<table style="width: 677px;"><tr>
	<td colspan="5" style="width: 196px;">
        <table>
            <tr>
                <td style="font-size: 15pt; font-weight: bold;">${record.billaddress@label}</td>
            </tr>
            <tr>
                <td>${record.billaddress}</td>
            </tr>
        </table>
	</td>
	<td align="right" colspan="7" style="width: 471px;">
        <table style="break-inside: avoid; margin-top: 10px; width: 347px;">
            <tr style="">
                <td align="left" style="background-color: #d3d3d3; font-weight: bold; color: rgb(51, 51, 51); border-width: 1px; border-style: solid; border-color: initial; width: 152px;">${record.amountpaid@label}</td>
                <td align="right" style="border-top: 1px solid; border-bottom: 1px solid; border-right: 1px solid; width: 161px;">${record.amountpaid}</td>
            </tr>
            <tr style="">
                <td align="left" style="background-color: #d3d3d3; font-weight: bold; color: rgb(51, 51, 51); border-left: 1px solid; border-bottom: 1px solid; border-right: 1px solid; width: 152px;">${record.amountdue@label}</td>
                <td align="right" style="border-bottom: 1px solid; border-right: 1px solid; width: 161px;">${record.amountdue}</td>
            </tr>
            <tr style=" ">
                <td align="left" style="background-color: #d3d3d3; font-weight: bold; color: rgb(51, 51, 51); border-left: 1px solid; border-bottom: 1px solid; border-right: 1px solid; width: 152px;">${record.total@label}</td>
                <td align="right" style="border-bottom: 1px solid; border-right: 1px solid; width: 161px;">${record.total}</td>
            </tr>
        </table>
	</td>
	</tr>
</table>
&nbsp;

<#-- Primary Information -->
<table style="break-inside: avoid; margin-top: 10px; width: 677px;">
    <tr style="">
	    <td align="left"><strong style="font-size: 15pt; font-weight: bold;">Primary Information</strong></td>
	</tr>
</table>
<table class="body" style="width: 100%; margin-top: 10px;">
    <tr style="background-color: #d3d3d3; ">
        <th align="center" style="font-weight: bold; border-left: 1px solid; border-top: 1px solid;border-bottom: 1px solid; border-right: 1px solid" width="150pt">${record.customer@label}</th>
        <th align="center" style="font-weight: bold; border-top: 1px solid;border-bottom: 1px solid; border-right: 1px solid" width="150pt">${record.trandate@label}</th>
        <th align="center" style="font-weight: bold; border-top: 1px solid;border-bottom: 1px solid; border-right: 1px solid" width="150pt">${record.terms@label}</th>
        <th align="center" style="font-weight: bold; border-top: 1px solid;border-bottom: 1px solid; border-right: 1px solid" width="150pt">${record.duedate@label}</th>
        <th align="center" style="font-weight: bold; border-top: 1px solid;border-bottom: 1px solid; border-right: 1px solid" width="200pt">${record.subsidiary@label}</th>
        <th align="center" style="font-weight: bold; border-top: 1px solid;border-bottom: 1px solid; border-right: 1px solid" width="150pt">${record.currency@label}</th>
	</tr>
	<tr>
        <td align="center" style="border-left: 1px solid;border-bottom: 1px solid; border-right: 1px solid">${record.customername}</td>
        <td align="center" style="border-bottom: 1px solid; border-right: 1px solid">${record.trandate}</td>
        <td align="center" style="border-bottom: 1px solid; border-right: 1px solid">${record.terms}</td>
        <td align="center" style="border-bottom: 1px solid; border-right: 1px solid">${record.duedate}</td>
        <td align="center" style="border-bottom: 1px solid; border-right: 1px solid">${record.subsidiary}</td>
        <td align="center" style="border-bottom: 1px solid; border-right: 1px solid">${record.currency}</td>
	</tr>
</table>


<#-- Invoice Group Summary -->
<#if groupedinvoices_summary?has_content>
    <table style="break-inside: avoid; margin-top: 10px; width: 677px;">
        <tr style="">
            <td align="left"><strong style="font-size: 15pt; font-weight: bold;">Invoice Group Summary</strong></td>
        </tr>
    </table>

    <table style="width: 100%; margin-top: 10px;">
        <#list groupedinvoices_summary as invoice_summary>
            <#if invoice_summary_index==0>
                <thead>
                    <tr style="background-color: #d3d3d3;">
                    <td align="center" colspan="4" style="font-weight: bold;border-left: 1px solid; border-top: 1px solid; border-bottom: 1px solid; border-right: 1px solid ">${invoice_summary.invoicenum@label}</td>
                    <td align="center" colspan="3" style="font-weight: bold;border-top: 1px solid; border-bottom: 1px solid; border-right: 1px solid">${invoice_summary.trandate@label}</td>
                    <td align="center" colspan="3" style="font-weight: bold;border-top: 1px solid; border-bottom: 1px solid; border-right: 1px solid ">${invoice_summary.fxamount@label}</td>
                    </tr>
                </thead>
            </#if>
            <tr>
                <td align="left" colspan="4" style="color: #333333;border-left: 1px solid; border-bottom: 1px solid; border-right: 1px solid">${invoice_summary.invoicenum}</td>
                <td align="center" colspan="3" style="border-bottom: 1px solid; border-right: 1px solid">${invoice_summary.trandate}</td>
                <td align="right" colspan="3" style="border-bottom: 1px solid; border-right: 1px solid">${invoice_summary.fxamount}</td>
            </tr>
        </#list>
    </table>
</#if> 



<#-- Invoice Group Details -->
<#if groupedinvoices_detailed?has_content>
    <table style="break-inside: avoid; margin-top: 10px; width: 647px;">
        <tr style="">
            <td align="left"><strong style="font-size: 15pt; font-weight: bold;">Invoice Group Detail</strong></td>
        </tr>
    </table>

    <table style="width=100%; margin-top: 10px;margin-bottom: 0px; ">
        <#-- maybe right here create a loop var like <#list xs as x>...</#list> to somemanage what invoice we are on. Multiple way this could probalby be done. -->
        <#list groupedinvoices_detailed as invoice_details>
            <#if invoice_details_index==0>
                <thead>
                    <tr style="background-color: #d3d3d3; ">
                    <th align="center" style="font-weight: bold; border-left: 1px solid; border-top: 1px solid; border-bottom: 1px solid; border-right: 1px solid" width="150pt">${invoice_details.invoicenum@label}</th>
                    <th align="center" style=" font-weight: bold; border-top: 1px solid; border-bottom: 1px solid; border-right: 1px solid" width="80pt">Seq Num</th>
                    <th align="center" style=" font-weight: bold; border-top: 1px solid; border-bottom: 1px solid; border-right: 1px solid" width="130pt">${invoice_details.item@label}</th>
                    <th align="center" style="font-weight: bold; border-top: 1px solid; border-bottom: 1px solid; border-right: 1px solid; " width="100pt">${invoice_details.fxrate@label}</th>
                    <th align="center" style="font-weight: bold; border-top: 1px solid; border-bottom: 1px solid; border-right: 1px solid; " width="70pt">${invoice_details.quantity@label}</th>
                    <th align="center" style=" font-weight: bold;border-top: 1px solid;  border-bottom: 1px solid; border-right: 1px solid" width="150pt">${invoice_details.fxgrossamount@label}</th>
                    </tr>
                </thead>
            </#if>
            <#if invoice_details.linesequencenumber!=0>
                <#assign istax = (invoice_details.itemtype=="TaxItem")||(invoice_details.itemtype=="TaxGroup")>
                <#assign ispercent = (invoice_details.itemtype=="Discount")||istax>
                <#assign noquantity = (invoice_details.itemtype=="ShipItem")||istax>
                <#assign notsubdesc = (invoice_details.itemtype!="ShipItem")&&(invoice_details.itemtype!="Description")&&(invoice_details.itemtype!="Subtotal")>
                <#assign gross_quantity = 69>
                <#assign gross_amount = 0>
                <#assign reference_sku = 'DDK500'>
                <#-- The more I think about it, the more i realize that there should be an if statement here saying if its the same invoice
                and same sku then we should just be adding the qualites and quanties, and then once we collected all that data we could create
                a row with that.. But is that even possilbe? -->
            <tr>
                <#-- So we want to make something right here like if (${invoice_details.invoicenum} && ${invoice_details.item}) are the same, 
                then we want up the quantity are gross amount. But, we don't want the list ot make a new table row but store that info in a varabile.
                until the iteration finishes up with that specific invoice number Then when it hits a new invoice number we can reset the variables and
                make a new table row... -->
                <td align="left" style="border-left: 1px solid; border-bottom: 1px solid; border-right: 1px solid">${invoice_details.invoicenum}</td>
                <td align="center" style="border-bottom: 1px solid; border-right: 1px solid">${invoice_details.linesequencenumber}</td>
                <td align="left" style="border-bottom: 1px solid; border-right: 1px solid">${invoice_details.item}</td> 
                <td align="right" style="border-bottom: 1px solid; border-right: 1px solid;">${invoice_details.fxrate}</td>
                <td align="center" style="border-bottom: 1px solid; border-right: 1px solid; ">
                    <#if !noquantity>
                            ${invoice_details.quantity} <#-- updated quanity goes here -->
                    </#if> 
                </td>
                <td align="right" style="border-bottom: 1px solid; border-right: 1px solid">${invoice_details.fxgrossamount}</td> <#-- updated gross goes here. -->
                </tr>
            </#if>
        </#list>

            <#-- JACOB"S INNER MONOLOGUE NOTES So the big thing is we are already in a loop as it seems so we don't want to effect any of the other sku's 
            that don't have muliples per order... So maybe create another loop like saying while in the same invoice number check to see if the 
            sku comes up again. And if it does just add to the quantity and and gross ammount. I'm not sure about the seq number is and how that will be 
            effected, and how to prevent it from adding more rows. -->

        <tr style="margin-top:25px;">
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td style="border-right: 1px solid;">&nbsp;</td>
            <td align="left" style="background-color: #d3d3d3; font-weight: bold; color: rgb(51, 51, 51);border-bottom: 1px solid; border-right: 1px solid; border-top: 1px solid;  width: 140px;">${record.taxtotal@label}</td>
            <td align="right" style="border-bottom: 1px solid; border-right: 1px solid; border-top: 1px solid; width: 100px ">${record.taxtotal}</td>
        </tr>
        <#if record.shippingcost?has_content>
            <tr style=" ">
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td style="border-right: 1px solid;">&nbsp;</td>
                <td align="left" style="background-color: #d3d3d3; font-weight: bold; color: rgb(51, 51, 51);border-bottom: 1px solid; border-right: 1px solid; width: 140px;">${record.shippingcost@label}</td>
                <td align="right" style="border-bottom: 1px solid; border-right: 1px solid;width: 100px ">${record.shippingcost}</td>
            </tr>
        </#if>
        <#if record.handlingcost?has_content>
            <tr style=" ">
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td style="border-right: 1px solid;">&nbsp;</td>
                <td align="left" style="background-color: #d3d3d3; font-weight: bold; color: rgb(51, 51, 51);border-bottom: 1px solid; border-right: 1px solid; width: 140px;">${record.handlingcost@label}</td>
                <td align="right" style="border-bottom: 1px solid; border-right: 1px solid;width: 100px ">${record.handlingcost}</td>
            </tr>
        </#if>
        <tr style=" ">
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td style="border-right: 1px solid;">&nbsp;</td>
            <td align="left" style="background-color: #d3d3d3; font-weight: bold; color: rgb(51, 51, 51);border-bottom: 1px solid; border-right: 1px solid; width: 140px;">${record.total@label}</td>
            <td align="right" style="border-bottom: 1px solid; border-right: 1px solid;width: 100px ">${record.total}</td>
        </tr>
    </table>
</#if>
</body>
</pdf>