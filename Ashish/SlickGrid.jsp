<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Zeus-Grid Statistics</title>
<link rel="stylesheet"
	href="http://localhost:8080/rp_zeus_web/css/SlickGrid/slick.grid.css"
	type="text/css" />
<link rel="stylesheet"
	href="http://localhost:8080/rp_zeus_web/css/SlickGrid/jquery-ui-1.8.16.custom.css"
	type="text/css" />
<link rel="stylesheet"
	href="http://localhost:8080/rp_zeus_web/css/SlickGrid/examples.css"
	type="text/css" />

</head>

<body>

		<%@ page import="com.cts.bfs.prism.zeus.analyzer.ZeuswebAnalyzer" %>
		<%@ page import ="java.io.File" %>
		<%
		
		
		ZeuswebAnalyzer tc = new ZeuswebAnalyzer(new File("D:/zeus_2017_09_24_17_14_44.log"));
		String str = tc.returnJSONString();
		System.out.println("Str: "+str);
		
		%>
		

	<table width="100%">
		<tr align>
			<td align="center" width="50%">
				<div id="myGrid" style="width: 1255px; height: 650px;"></div>
			</td>

			<td valign="top"></td>
		</tr>
	</table>

	<script
		src="http://localhost:8080/rp_zeus_web/js/SlickGrid/jquery-1.7.min.js"></script>
	<script
		src="http://localhost:8080/rp_zeus_web/js/SlickGrid/jquery.event.drag-2.2.js"></script>

	<script
		src="http://localhost:8080/rp_zeus_web/js/SlickGrid/slick.core.js"></script>
	<script
		src="http://localhost:8080/rp_zeus_web/js/SlickGrid/slick.grid.js"></script>

	<script>
		var grid;
		var columns = [ {
			id : "s-no",
			name : "S.No.",
			field : "sno"
		}, {
			id : "class-name",
			name : "Class Name",
			field : "className"
		}, {
			id : "method-name",
			name : "Method Name",
			field : "methodName"
		}, {
			id : "num-invocations",
			name : "Num invocations",
			field : "numInvocations"
		}, {
			id : "max-total-time",
			name : "Max Total Time (ms)",
			field : "maxTotalTime"
		}, {
			id : "min-total-time",
			name : "Min Total Time (ms)",
			field : "minTotalTime"
		}, {
			id : "avg-total-time",
			name : "Avg Total Time (ms)",
			field : "avgTotalTime"
		}, {
			id : "max-shelf-time",
			name : "Max Shelf Time (ms)",
			field : "maxShelfTime"
		}, {
			id : "min-shelf-time",
			name : "Min Shelf Time (ms)",
			field : "minShelfTime"
		}, {
			id : "avg-shelf-time",
			name : "Avg Shelf Time (ms)",
			field : "avgShelfTime"
		}

		];

		var options = {
			enableCellNavigation : true,
			enableColumnReorder : false
		};

		// var textarray = [
		//"hi",
		//"hello",
		//"how r u",
		//"where r u"    // No comma after last entry
		//];

		//function RndText() {
		// var rannum= Math.floor(Math.random()*textarray.length);
		// document.getElementById('ShowText').innerHTML=textarray[rannum];
		//}
		//onload = function() { RndText(); }
	
		
		$(function() {

			var JSONObject = <%=str%>;//JSON.parse(eswStr);
			console.log(JSONObject);

			//alert(JSONObject[3]["avgTotalTime"]); // Access Object data

			var noOfRowdata = 7;
			var data = [];
			for (var i = 0; i < noOfRowdata; i++) {
				data[i] = {
					sno : i + 1,
					className : JSONObject[i]["className"],
					methodName : JSONObject[i]["methodName"],
					numInvocations : JSONObject[i]["numInvocations"],
					maxTotalTime : JSONObject[i]["maxTotalExecTime"],
					minTotalTime : JSONObject[i]["minTotalExecTime"],
					avgTotalTime : JSONObject[i]["avgTotalExecTime"],
					maxShelfTime : JSONObject[i]["maxSelfExecTime"],
					minShelfTime : JSONObject[i]["minSelfExecTime"],
					avgShelfTime : JSONObject[i]["avgSelfExecTime"]
				// className: "SpringBootWebApplication",
				// methodName: "<init>",
				// numInvocations: Math.round(Math.random()),
				// maxTotalTime: Math.round(Math.random()*10),
				// minTotalTime: Math.round(Math.random()*10),
				// avgTotalTime: Math.round(Math.random()*10),
				// maxShelfTime: Math.round(Math.random()*10),
				// minShelfTime: Math.round(Math.random()*10),
				// avgShelfTime: Math.round(Math.random()*10)
				};
			}

			grid = new Slick.Grid("#myGrid", data, columns, options);
		})
	</script>

</body>

</html>