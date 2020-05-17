<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/main.css">
<script src="scripts/main.js"></script>
<title>Asiakkaan lis�ys</title>
</head>
<body onkeydown = "enter(event)">
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
				<th></th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><input type="text" name="etunimi" id="etunimi"></td>
				<td><input type="text" name="sukunimi" id="sukunimi"></td>
				<td><input type="text" name="puhelin" id="puhelin"></td>
				<td><input type="text" name="sposti" id="sposti"></td>
				<td><input type="button" name="tallenna" id="tallenna" value="Lis��" onclick="lisaaAsiakas()"></td>
			</tr>
		</tbody>
	</table>
</form>
<span id="ilmoitus"></span>
</body>
<script>
function enter(event) {
	if(event.keyCode == 13) {
		lisaaAsiakas();
	}
}

function lisaaAsiakas() {
	var tarkistus = validate();
	if (tarkistus == true) {
		document.getElementById("etunimi").value=siivoa(document.getElementById("etunimi").value);
		document.getElementById("sukunimi").value=siivoa(document.getElementById("sukunimi").value);
		document.getElementById("puhelin").value=siivoa(document.getElementById("puhelin").value);
		document.getElementById("sposti").value=siivoa(document.getElementById("sposti").value);
		
		var formJsonStr = formDataToJSON(document.getElementById("tiedot"));
		fetch("asiakkaat", {method: 'POST', body: formJsonStr})
		.then(function (response) {
			return response.json()
		})
		.then(function (responseJson) {
			var vastaus = responseJson.response;
		if (vastaus == 0) {
			document.getElementById("ilmoitus").innerHTML = "Asiakkaan lis��minen ep�onnistui!";
		} else if (vastaus == 1) {
			document.getElementById("ilmoitus").innerHTML = "Asiakkaan lis��minen onnistui!"
		}
		SetTimeout(function(){ document.getElementById("ilmoitus").innerHTML=""; }, 5000);
		});
		document.getElementById("tiedot").reset();
	}
}
</script>
</html>