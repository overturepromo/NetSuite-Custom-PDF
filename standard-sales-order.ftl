<?xml version="1.0"?><!DOCTYPE pdf PUBLIC "-//big.faceless.org//report" "report-1.1.dtd">
<pdf>
<head>
<#if .locale == "ru_RU">
    <link name="verdana" type="font" subtype="opentype" src="${nsfont.verdana}" src-bold="${nsfont.verdana_bold}" bytes="2" />
</#if>
    <macrolist>
        <macro id="nlheader">
            <table class="header" style="width: 100%;"><tr class="logo">
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
	<td align="right"><span class="number">#${record.tranid}</span></td>
	</tr>
	<tr>
	<td align="right">${record.trandate}</td>
	</tr></table>
        </macro>
        <macro id="nlfooter">
            <table class="footer" style="width: 100%;"><tr>
	<td><barcode codetype="code128" showtext="true" value="${record.tranid}"/></td>
	<td align="right"><pagenumber/> of <totalpages/></td>
	</tr></table>
        </macro>
    </macrolist>
    <style type="text/css">table {
	  <#if .locale == "zh_CN">
	      font-family: stsong, sans-serif;
	  <#elseif .locale == "zh_TW">
	      font-family: msung, sans-serif;
	  <#elseif .locale == "ja_JP">
	      font-family: heiseimin, sans-serif;
	  <#elseif .locale == "ko_KR">
	      font-family: hygothic, sans-serif;
	  <#elseif .locale == "ru_RU">
	      font-family: verdana;
	  <#else>
	      font-family: sans-serif;
	  </#if>
	      font-size: 9pt;
	      table-layout: fixed;
	  }
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
	  th {
	      font-weight: bold;
	      font-size: 8pt;
	      vertical-align: middle;
	      padding: 5px 6px 3px;
	      background-color: #f7f7f9;
	      color: #333333;
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
	  tr.totalrow {
	      background-color: #f7f7f9;
	      line-height: 200%;
	  }
	  td.totalboxtop {
	      font-size: 12pt;
	      background-color: #f7f7f9;
	  }
	  td.addressheader {
	      font-size: 8pt;
	      padding-top: 6px;
	      padding-bottom: 2px;
	  }
	  td.address {
	      padding-top: 0px;
	  }
	  td.totalboxmid {
	      font-size: 20pt;
	      padding-top: 20px;
	      background-color: #f7f7f9;
	  }
	  td.totalboxbot {
	      background-color: #f7f7f9;
	      font-weight: bold;
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
    <table style="width: 100%; margin-top: 10px;"><tr>
	<td class="addressheader" colspan="6"><b>${record.billaddress@label}</b></td>
	<td class="addressheader" colspan="6"><b>${record.shipaddress@label}</b></td>
	<#-- <td class="totalboxtop" colspan="8"><b>${record.total@label?upper_case}</b></td> -->
	</tr>
	<tr>
	<#if record.custbody_setbilltoaddress_toshiptoaddr == false>
		<td class="address" colspan="6" rowspan="2">${record.billaddress}</td>
	<#else>
		<td class="address" colspan="6" rowspan="2">${record.shipaddress}</td>
	</#if>
	<td class="address" colspan="6" rowspan="2">${record.shipaddress}</td>
	<#-- <td align="right" class="totalboxmid" colspan="8">${record.total}</td> -->
	</tr>
	<#-- <tr>
	<td class="totalboxbot" colspan="8">${record.terms@label}: ${record.terms}</td>
	</tr> -->
	</table>

<table class="body" style="width: 100%; margin-top: 10px;"><tr>
	<th>${record.otherrefnum@label}</th>
	<th>Ship Date</th>
	<th>In hands Date</th>
	<th>Sales Rep</th>
	<#if record.department?string == 'BSP' || record.department?string == 'BSP : Inbound'>
	<#if record.custbody_bsp_customer_with_contract == false>
	<th>Sales Rep Email</th>
	</#if>
	</#if></tr>
	<tr>
	<td>${record.otherrefnum}</td>
	<td>${record.shipdate}</td>
	<td>${record.enddate}</td>
	<td>${record.custbody_sales_rep_entered_by}</td>
	<#if record.department?string == 'BSP' || record.department?string == 'BSP : Inbound'>
	<#if record.custbody_bsp_customer_with_contract == false>
	<td>${record.custbody_entered_by_email}</td>
	</#if>
	</#if></tr></table>


	<table class="body" style="width: 100%; margin-top: 10px;">
		<tr>
			<#if record.custbody_ordercustomfield1?has_content>
				<#if record.custbody18 == false>
					<th>${record.custbody_ordercustomfield1@label}</th>
				</#if>
			</#if>
			<#if record.custbody_ordercustomfield2?has_content>
				<#if record.custbody19 == false>
					<th>${record.custbody_ordercustomfield2@label}</th>
				</#if>
			</#if>
			<#if record.custbody_ordercustomfield3?has_content>
				<#if record.custbody20 == false>
					<th>${record.custbody_ordercustomfield3@label}</th>
				</#if>
			</#if>
			<#if record.custbody_ordercustomfield4?has_content>
				<#if record.custbody21 == false>
					<th>${record.custbody_ordercustomfield4@label}</th>
				</#if>
			</#if>
		</tr>
		<tr>
			<#if record.custbody_ordercustomfield1?has_content>
				<#if record.custbody18 == false>
					<td>${record.custbody_ordercustomfield1}</td>
				</#if>
			</#if>
			<#if record.custbody_ordercustomfield2?has_content>
				<#if record.custbody19 == false>
					<td>${record.custbody_ordercustomfield2}</td>
				</#if>
			</#if>
			<#if record.custbody_ordercustomfield3?has_content>
				<#if record.custbody20 == false>
					<td>${record.custbody_ordercustomfield3}</td>
				</#if>
			</#if>
			<#if record.custbody_ordercustomfield4?has_content>
				<#if record.custbody21 == false>
					<td>${record.custbody_ordercustomfield4}</td>
				</#if>
			</#if>
		</tr>
	</table>

<#if record.item?has_content>

<table class="itemtable" style="width: 100%; margin-top: 10px;">
	<!-- start items -->
	<#list record.item as item>
		<#if item_index==0>
			<thead>
				<tr>
					<th align="center" colspan="3">${item.quantity@label}</th>
					<#if record.class?string =='Webstore'>
						<th colspan="6">Item</th>
						<th colspan="6">Description</th>
					<#else>
						<th colspan="12">Item</th>
					</#if>
					<th align="right" colspan="4">${item.rate@label}</th>
					<th align="right" colspan="4">Amount</th>
				</tr>
			</thead>
		</#if>
		<#if item.custcol_extend_hidefromprinting == false>
			<tr>
				<td align="center" colspan="3" line-height="150%">${item.quantity}</td>
				<#if record.class?string =='Webstore'>
					<td colspan="6">${item.item}</td>
					<td colspan="6">${item.description}<#if item.custcolitemcolor?has_content><br /><b><em>Item Color: </em></b>${item.custcolitemcolor}</#if><#if item.custcolitemsize?has_content><br /><b><em>Item Size: </em></b>${item.custcolitemsize}</#if></td>
				<#else>
				<td colspan="12">${item.description}<#if item.custcolitemcolor?has_content><br /><b><em>Item Color: </em></b>${item.custcolitemcolor}</#if><#if item.custcolitemsize?has_content><br /><b><em>Item Size: </em></b>${item.custcolitemsize}</#if></td>
				</#if>
				<td align="right" colspan="4">${item.rate?string('$,##0.000')}</td>
				<#-- ${item.rate?string('$,##0.000')} -->
				<td align="right" colspan="4">${item.amount}</td>
			</tr>
		</#if>
	</#list>
	<!-- end items -->
</table>

<hr /></#if>
<table class="total" style="width: 100%; margin-top: 10px;">
	<#if record.custbody_est_so_customer_pdf_message?has_content>
		<#if record.class?string != 'Webstore' && record.class?string != 'Webstore - Cust Own'>
			<tr>
				<td colspan="3" align="left"><strong>Customer Message:</strong><br />${record.custbody_est_so_customer_pdf_message}</td>
			</tr>
		</#if>
	</#if>
	<tr>
	<td colspan="4">&nbsp;</td>
	<td align="right"><b>${record.subtotal@label}</b></td>
	<td align="right">${record.subtotal}</td>
	</tr>
	<#if record.discounttotal?string != ''>
      <tr>
          <td colspan="4">&nbsp;</td>
          <td align="right"><b>${record.discounttotal@label}</b></td>
          <td align="right">${record.discounttotal}</td>
      </tr>
	</#if>
	<tr>
	<td colspan="4">&nbsp;</td>
	<td align="right"><b>Est. Shipping</b></td>
	<td align="right">${record.shippingcost}</td>
	</tr>

	<#if record.taxtotal != 0.00>
		<tr>
		<td colspan="4">&nbsp;</td>
		<td align="right"><b>${record.taxtotal@label} (${record.taxrate}%)</b></td>
		<td align="right">${record.taxtotal}</td>
		</tr>
	</#if>	
	
	<tr class="totalrow">
	<td background-color="#ffffff" colspan="4">&nbsp;</td>
	<td align="right"><b>${record.total@label}</b></td>
	<td align="right">${record.total}</td>
	</tr>
	<#if record.amountremaining?has_content>
		<#if record.amountremaining != record.total>
			<tr class="totalrow">
				<td background-color="#ffffff" colspan="4">&nbsp;</td>
				<td align="right"><b>Less Deposit</b></td>
				<td align="right">(${record.amountpaid})</td>
			</tr>
			<tr class="totalrow">
				<td background-color="#ffffff" colspan="4">&nbsp;</td>
				<td align="right"><b>${record.amountremaining@label}</b></td>
				<td align="right">${record.amountremaining}</td>
			</tr>
		</#if>
	</#if>
  <tr>
				<td colspan="4">&nbsp;</td>
				<td align="right"><b>${record.currency@label}</b></td>
				<td align="right">${record.currency}</td>
			</tr>
	</table>
<#-- <table style="width: 100%; margin-top: 10px;"><tr>
	<th colspan="4" style="color:#ffffff ; background-color:#2060AB; font-size:1em ;font-weight: bold;text-align:right;">Do you acknowledge this order?</th>
	<th style="background-color: rgb(51, 204, 0);border:4px solid #4b8f29;margin-left:5px;padding-left:45px;" width="20%"><a href="${record.custbody_extend_web_approval_url + record.entity}" name="Approval" style="color:#FFFFFF;text-decoration:none;cursor:pointer;font-weight:600;">Yes</a></th>
	<th style="background-color: rgb(255, 51, 51);border:4px solid #942911;margin-left:5px;padding-left:50px;" width="20%"><a href="${record.custbody_extend_web_approval_rej_url + record.entity}" name="Rejection" style="color:#FFFFFF;text-decoration:none;cursor:pointer;font-weight:600;">No</a></th>
	</tr></table> -->
  <#--  <table>
  <tr>
    <td align="left" colspan="12"><span style="text-decoration:underline; font-weight:bold;">Bank Payment Instructions</span><br />
      <span>Account Name: Overture Promotions, Inc.</span><br />
      <span>Bank Name: TCF National Bank</span><br />
      <span>Account #: 5404552022</span><br />
      <span>Routing #: 291070001</span>
    </td>
  </tr>
  </table>  -->
</body>
</pdf>