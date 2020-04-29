<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/main.css">
<title>Asiakkaat</title>
</head>
<body>
<table id="listaus">
	<thead>
		<tr>
			<th colspan="6" class="oikealle"><span id="uusiAsiakas">Lisää uusi asiakas</span></th>
		</tr>
		<tr>
			<th class="oikealle" colspan="2">Hakusana:</th>
			<th colspan="3"><input type="text" name="haku" id="haettava" size="20"></th>
			<th ><input type="submit" value="Hae" id="hakunappi"></th>
		</tr>
  		<tr>
  			<th>ID</th>
	    	<th>Etunimi</th>
	    	<th>Sukunimi</th>
	    	<th>Puhelin</th>
	   		<th>S-posti</th>
	   		<th></th>
	   	</tr>
	</thead>
	<tbody>
	<span id="ilmoitus"></span>
	</tbody>
</table>
<span id="ilmoitus"></span>
<script>
$(document).ready(function() {
	haeAsiakkaat();
	
	$("#uusiAsiakas").click(function() {
		document.location="lisaaasiakas.jsp";
	});
	
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
			htmlStr+="<tr id='rivi_"+field.id+"'>";
			htmlStr+="<td>"+field.id+"</td>";
			htmlStr+="<td>"+field.etunimi+"</td>";
			htmlStr+="<td>"+field.sukunimi+"</td>";
			htmlStr+="<td>"+field.puhelin+"</td>";
			htmlStr+="<td>"+field.sposti+"</td>";
			htmlStr+="<td><span class='poista' onclick=poista('"+field.id+"')>Poista</span></td>";
			htmlStr+="</tr>";
			$("#listaus tbody").append(htmlStr);
		});
	}});
}

function poista(id) {
	if (confirm("Poista asiakas, jonka id on " + id +"?")) {
		$.ajax({url:"asiakkaat/"+id, type:"DELETE", dataType:"json", success:function(result) {
			if (result.response == 0) {
				$("#ilmoitus").html("Asiakkaan poisto epäonnistui.");
			} else if (result.response == 1) {
	        	alert("Asiakas " + id +" poisto onnistui.");
				haeAsiakkaat();
			}
		}});
	}
}
</script>
</body>
</html>