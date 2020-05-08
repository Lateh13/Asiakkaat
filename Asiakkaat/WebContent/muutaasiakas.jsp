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
<body>
<form id="tiedot">
	<table>
		<thead>
			<tr>
				<th colspan="5" class="oikealle"><span id="takaisin">Takaisin listaukseen</span></th>
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
				<td><input type="submit" name="tallenna" id="Hyväksy"></td>
			</tr>
		</tbody>
	</table>
	<input type="hidden" name="id" id="id">
</form>
<span id="ilmoitus"></span>
</body>
<script>
$(document).ready(function() {
	$("#takaisin").click(function() {
		document.location="listaaasiakkaat.jsp";
	});
	var id = requestURLParam("asiakasid");
	$.ajax(url:"asiakkaat/haeyksi/"+id, type:"GET", dataType:"json", success:function(result) {
		$("id").val(result.id);
		$("etunimi").val(result.etunimi);
		$("sukunimi").val(result.sukunimi);
		$("puhelin").val(result.puhelin);
		$("sposti").val(result.sposti);
	})
	$("#tiedot").validate( {
		rules: {
			etunimi:	{
				required: true,
				minlength: 2,
				maxlength: 50
			},
			sukunimi:	{
				required: true,
				minlength: 2,
				maxlength: 50
			},
			puhelin:	{
				required: true,
				minlength: 8,
				maxlength: 20
			},
			sposti:	{
				required: true,
				email: true,
				minlength: 8,
				maxlength: 100
			}
		},
		messages: {
			etunimi: {
				required: "Puuttuva tieto",
				minlength: "Liian lyhyt",
				maxlength: "Liian pitkä"
			},
			sukunimi: {
				required: "Puuttuva tieto",
				minlength: "Liian lyhyt",
				maxlength: "Liian pitkä"
			},
			puhelin: {
				required: "Puuttuva tieto",
				minlength: "Liian lyhyt",
				maxlength: "Liian pitkä"
			},
			sposti: {
				required: "Puuttuva tieto",
				email: "Lisää pätevä sähköposti",
				minlength: "Liian lyhyt",
				maxlength: "Liian pitkä"
			}
		},
		submitHandler: function(form) {
			lisaaTiedot();
		}
	});
});

function paivitaTiedot() {
	var formJsonStr = formDataJsonStr($("#tiedot").serializeArray());
	$.ajax({url:"asiakkaat", data:fromJsonStr, type:"PUT", dataType:"json", success:function(result) {
		if(result.response == 0) {
			$("#ilmoitus").html("Asiakkaan päivittäminen epäonnistui");
		} else if (result.response == 1) {
			$("#ilmoitus").html("Asiakkaan päivittäminen onnistui");
			$("#etunimi", "#sukunimi", "#puhelin", "#sposti").val("");
		}
	}});
}
</script>
</html>