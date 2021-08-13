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
            <table class="header" style="width: 100%;"><tr>
	<td rowspan="3"><#if companyInformation.logoUrl?length != 0><img src="${companyInformation.logoUrl}" style="float: left; margin: 7px" /> </#if> <span class="nameandaddress">${companyInformation.companyName}</span><br /><span class="nameandaddress">${companyInformation.addressText}</span></td>
	<td align="right"><span class="title">${record@title} </span><span class="number">${record.invoicegroupnumber} </span></td>
	</tr>
	<tr>
	<td align="right">${record.trandate}</td>
	</tr></table>
        </macro>
        <macro id="nlfooter">
            <table class="footer" style="width: 100%;"><tr>
            <td>I'm a footer</td>
            <td align="right"><pagenumber/> of <totalpages/></td>
            </tr></table>
        </macro>
    </macrolist>
      <style type="text/css">
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
<table style="width: 677px;"><tr>
	<td colspan="5" style="width: 196px;">
	<table><tr>
		<td style="font-size: 13pt; font-weight: bold;">${record.billaddress@label}</td>
		</tr>
		<tr>
		<td>${record.billaddress}</td>
		</tr></table>
	</td>
	<td align="right" colspan="7" style="width: 471px;">
	<table style="break-inside: avoid; margin-top: 10px; width: 347px;"><tr style="">
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
		</tr></table>
	</td>
	</tr></table>
&nbsp;

<table style="break-inside: avoid; margin-top: 10px; width: 677px;"><tr style="">
	<td align="left"><strong>Primary Information</strong></td>
	</tr></table>

<table class="body" style="width: 100%; margin-top: 10px;"><tr style="background-color: #d3d3d3; ">
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
	</tr></table>
<#if groupedinvoices_summary?has_content>

<table style="break-inside: avoid; margin-top: 10px; width: 677px;"><tr style="">
	<td align="left"><strong>Invoice Group Summary</strong></td>
	</tr></table>

<table style="width: 100%; margin-top: 10px;"><#list groupedinvoices_summary as invoice_summary><#if invoice_summary_index==0>
<thead>
	<tr style="background-color: #d3d3d3;">
	<td align="center" colspan="4" style="font-weight: bold;border-left: 1px solid; border-top: 1px solid; border-bottom: 1px solid; border-right: 1px solid ">${invoice_summary.invoicenum@label}</td>
	<td align="center" colspan="3" style="font-weight: bold;border-top: 1px solid; border-bottom: 1px solid; border-right: 1px solid">${invoice_summary.trandate@label}</td>
	<td align="center" colspan="3" style="font-weight: bold;border-top: 1px solid; border-bottom: 1px solid; border-right: 1px solid ">${invoice_summary.fxamount@label}</td>
	</tr>
</thead>
</#if><tr>
	<td align="left" colspan="4" style="color: #333333;border-left: 1px solid; border-bottom: 1px solid; border-right: 1px solid">${invoice_summary.invoicenum}</td>
	<td align="center" colspan="3" style="border-bottom: 1px solid; border-right: 1px solid">${invoice_summary.trandate}</td>
	<td align="right" colspan="3" style="border-bottom: 1px solid; border-right: 1px solid">${invoice_summary.fxamount}</td>
	</tr>
	</#list></table>
</#if> <#if groupedinvoices_detailed?has_content>

<table style="break-inside: avoid; margin-top: 10px; width: 647px;"><tr style="">
	<td align="left"><strong>Invoice Group Detail</strong></td>
	</tr></table>

<table style="width=100%; margin-top: 10px;margin-bottom: 0px; "><#list groupedinvoices_detailed as invoice_details><#if invoice_details_index==0>
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
</#if><#if invoice_details.linesequencenumber!=0><#assign istax = (invoice_details.itemtype=="TaxItem")||(invoice_details.itemtype=="TaxGroup")><#assign ispercent = (invoice_details.itemtype=="Discount")||istax><#assign noquantity = (invoice_details.itemtype=="ShipItem")||istax><#assign notsubdesc = (invoice_details.itemtype!="ShipItem")&&(invoice_details.itemtype!="Description")&&(invoice_details.itemtype!="Subtotal")><tr>
	<td align="left" style="border-left: 1px solid; border-bottom: 1px solid; border-right: 1px solid">${invoice_details.invoicenum}</td>
	<td align="center" style="border-bottom: 1px solid; border-right: 1px solid">${invoice_details.linesequencenumber}</td>
	<td align="left" style="border-bottom: 1px solid; border-right: 1px solid">${invoice_details.item}</td>
	<td align="right" style="border-bottom: 1px solid; border-right: 1px solid;">${invoice_details.fxrate}</td>
	<td align="center" style="border-bottom: 1px solid; border-right: 1px solid; "><#if !noquantity>${invoice_details.quantity}</#if></td>
	<td align="right" style="border-bottom: 1px solid; border-right: 1px solid">${invoice_details.fxgrossamount}</td>
	</tr>
	</#if></#list>
	<tr style=" ">
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<td style="border-right: 1px solid;">&nbsp;</td>
	<td align="left" style="background-color: #d3d3d3; font-weight: bold; color: rgb(51, 51, 51);border-bottom: 1px solid; border-right: 1px solid;  width: 140px;">${record.taxtotal@label}</td>
	<td align="right" style="border-bottom: 1px solid; border-right: 1px solid;width: 100px ">${record.taxtotal}</td>
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
	</#if><#if record.handlingcost?has_content>
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
	</tr></table>
</#if>
</body>
</pdf>