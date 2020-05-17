function requestURLParam(sParam){
    var sPageURL = window.location.search.substring(1);
    var sURLVariables = sPageURL.split("&");
    for (var i = 0; i < sURLVariables.length; i++){
        var sParameterName = sURLVariables[i].split("=");
        if(sParameterName[0] == sParam){
            return sParameterName[1];
        }
    }
}

function formDataToJSON(data){
	var returnStr="{";
	for(var i=0; i<data.length; i++){		
		returnStr+="\"" +data[i].name + "\":\"" + data[i].value + "\",";
	}	
	returnStr = returnStr.substring(0, returnStr.length - 1); //poistetaan viimeinen pilkku
	returnStr+="}";
	return returnStr;
}

function siivoa(teksti){
	teksti=teksti.replace("<","");
	teksti=teksti.replace(";","");
	teksti=teksti.replace("'","''");
	return teksti;
}

function validate() {
	resetBorderColor();
	var ilmoitus = "";
	var laskuri = 0;
	var etunimi = document.getElementById("etunimi").value;
	var sukunimi = document.getElementById("sukunimi").value;
	var puhelin = document.getElementById("puhelin").value;
	var sposti = document.getElementById("sposti").value;
	
	var etunimiREGX = /^[A-Z]{1}[a-z]{2,40}$/;
	var sukunimiREGX = /^[A-Z]{1}[a-z]{2,40}$/;
	var puhelinREGX = /^[0-9]{8,20}$/;
	var spostiREGX = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
	
	var etunimiTulos = etunimiREGX.test(etunimi);
	var sukunimiTulos = sukunimiREGX.test(sukunimi);
	var puhelinTulos = puhelinREGX.test(puhelin);
	var spostiTulos = spostiREGX.test(sposti);
	
	if (etunimiTulos == false) {
		ilmoitus = "Etunimi ei kelpaa!";
		laskuri++;
		document.getElementById("etunimi").style.borderBottomColor = "red";
	}
	if (sukunimiTulos == false) {
		ilmoitus = "Sukunimi ei kelpaa!";
		laskuri++;
		document.getElementById("sukunimi").style.borderBottomColor = "red";
	}
	if (puhelinTulos == false ) {
		ilmoitus = "Puhelinnumero ei kelpaa!";
		laskuri++;
		document.getElementById("puhelin").style.borderBottomColor = "red";
	}
	if (spostiTulos == false) {
		ilmoitus = "Sähköpostiosoite ei kelpaa!";
		laskuri++;
		document.getElementById("sposti").style.borderBottomColor = "red";
	}
	if (laskuri == 1) {
		document.getElementById("ilmoitus").innerHTML = ilmoitus;
		return false;
	} else if (laskuri > 1) {
		document.getElementById("ilmoitus").innerHTML = "Tarkista antamasi tiedot!";
		return false;
	}
	return true;
}

function resetBorderColor() {
	document.getElementById("etunimi").style.borderBottomColor = "transparent";
	document.getElementById("sukunimi").style.borderBottomColor = "transparent";
	document.getElementById("puhelin").style.borderBottomColor = "transparent";
	document.getElementById("sposti").style.borderBottomColor = "transparent";
}