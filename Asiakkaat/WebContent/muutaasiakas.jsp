<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="scripts/main.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.15.0/jquery.validate.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/main.css">
<title>Muutos</title>
</head>
<body onkeydown="enter(event)">
<form id="tiedot">
	<table>
		<thead>
			<tr>
				<th colspan="3" id="ilmoitus">
				<th colspan="2" class="oikealle"><a href="listaaasiakkaat.jsp" id="takaisin">Takaisin listaukseen</a></th>
			</tr>
			<tr>
				<th>Etunimi</th>
				<th>Sukunimi</th>
				<th>Puhelin</th>
				<th>S-posti</th>
				<th>Hallinta</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><input type="text" name="etunimi" id="etunimi"></td>
				<td><input type="text" name="sukunimi" id="sukunimi"></td>
				<td><input type="text" name="puhelin" id="puhelin"></td>
				<td><input type="text" name="sposti" id="sposti"></td>
				<td><input type="button" id="Tallenna" value="Hyv�ksy" onclick="muutaTiedot()"></td>
			</tr>
		</tbody>
	</table>
	<input type="hidden" name="asiakas_id" id="asiakas_id">
</form>
<span id="ilmoitus"></span>
</body>
<script>
function enter(event) {
	if(event.keyCode == 13) {
		muutaTiedot();
	}
}

var asiakas_id = requestURLParam("asiakas_id");
fetch("asiakkaat/haeyksi/" + asiakas_id, {method: 'GET'})
.then(function (response) {
	return response.json()
})
.then(function (responseJson) {
	document.getElementById("asiakas_id").value = responseJson.asiakas_id;
	document.getElementById("etunimi").value = responseJson.etunimi;
	document.getElementById("sukunimi").value = responseJson.sukunimi;
	document.getElementById("puhelin").value = responseJson.puhelin;
	document.getElementById("sposti").value = responseJson.sposti;
})

function muutaTiedot() {
	var tarkistus = validate();
	if (tarkistus == true) {
		document.getElementById("etunimi").value=siivoa(document.getElementById("etunimi").value);
		document.getElementById("sukunimi").value=siivoa(document.getElementById("sukunimi").value);
		document.getElementById("puhelin").value=siivoa(document.getElementById("puhelin").value);
		document.getElementById("sposti").value=siivoa(document.getElementById("sposti").value);
		
		var formJsonStr = formDataToJSON(document.getElementById("tiedot"));
		fetch("asiakkaat", {method:'PUT', body:formJsonStr})
		.then(function (response) {
			return response.json();
		})
		.then(function (responseJson) {
			var vastaus = responseJson.response;
			if (vastaus == 0) {
				document.getElementById("ilmoitus").innerHTML = "Tietojen p�ivitys ep�onnistui!";
			} else if (vastaus == 1) {
				document.getElementById("ilmoitus").innerHTML = "Tietojen p�ivitys onnistui!";
			}
			SetTimeout(function(){ document.getElementById("ilmoitus").innerHTML=""; }, 5000);
		});
		document.getElementById("tiedot").reset();
	}
}
</script>
</html>