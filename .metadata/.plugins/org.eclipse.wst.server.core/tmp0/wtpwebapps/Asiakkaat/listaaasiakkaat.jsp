<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
th#th1 {
	text-align: right;
	padding: 6px;
	background-color: #24a850;
}

th {
	text-align: left;
	padding: 6px;
	background-color: #24a850;
}

td {
	text-align: left;
	padding: 6px;
}

tr:nth-child(even) {
  background-color: #d9d9d9;
</style>
<meta charset="ISO-8859-1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<title>Asiakkaat</title>
</head>
<body>
<table id="listaus">
	<thead>
		<tr>
			<th id="th1" colspan="2">Hakusana:</th>
			<th><input type="text" name="haku" id="haettava" size="20"></th>
			<th><input type="submit" value="Hae" id="hakunappi"></th>
		</tr>
  		<tr>
	    	<th>Etunimi</th>
	    	<th>Sukunimi</th>
	    	<th>Puhelin</th>
	   		<th>Sposti</th>
	   	</tr>
	</thead>
	<tbody>
	</tbody>
</table>
<script>
$(document).ready(function() {
	haeAsiakkaat();
	
	$("#hakunappi").click(function() {
		haeAsiakkaat();
		
	});
	$(document.body).on("keydown", function(event) {
		if(event.which == 13) {
			haeAsiakkaat();
		}
	});
});
	
function haeAsiakkaat() {
	$("#listaus tbody").empty();
	$.ajax({url:"asiakkaat/"+$("#haettava").val(), type:"GET", dataType:"json", success:function(result) {
		$.each(result.asiakkaat, function(i, field) {
			var htmlStr;
			htmlStr+="<tr>";
			htmlStr+="<td>"+field.etunimi+"</td>";
			htmlStr+="<td>"+field.sukunimi+"</td>";
			htmlStr+="<td>"+field.puhelin+"</td>";
			htmlStr+="<td>"+field.sposti+"</td>";
			htmlStr+="</tr>";
			$("#listaus tbody").append(htmlStr);
		});
	}});
};

</script>
</body>
</html>