function check(input) {
    'use strict';

    var inputName = input.getAttribute("name");
    var value = input.value;
        
    console.log("inputName " + inputName);
    console.log("Sono in check");

    var listOfInputToCheck = {
	//'Il nome del cantante deve avere almeno 2 caratteri composti da lettere o numeri'],
	artistNick : /^.{2,}$/, 
	artistImage : /^(\w+.\w+)?$/,
	artistDescription : /^.+$/,
	albumName : /^.+$/, 
	albumImage : /^\w+.\w+$/,
        songTitle : /^.+$/, //'Il titolo contiene caratteri non validi'],
	songLyrics : /^.+$/m,
	songExtra : /^\w+$/,
        articleAuthor : /^.+$/, //'L\'autore dell\'articolo non è corretto'],
        articleData : /^\d{1,2}-\d{1,2}-\d{4}$/, //'La data inserita non è valida'],
        articleTitle : /^.+$/, //'Il titolo contiene caratteri non validi'],
        articleSubtitle : /^.+$/, //'Il sotto-titolo contiene caratteri non validi']
	articleContent : /^.+$/m
    };

    if ( !listOfInputToCheck[inputName].test(value) ){
        console.log("Cambio la voce in visible");
        document.getElementById("err-".concat(inputName)).className = "error visible";
    } else {

	console.log("Cambio la voce in invisibibile");
	document.getElementById("err-".concat(inputName)).className = "error hidden";
    }
}

function main() {
    'use strict';

    console.log("Main chiamato");

    var inputTag = document.querySelectorAll("input,textarea");
    
    //Javascript attivo
    document.getElementsByName("javascript")[0].value = 1;
    
    console.log(inputTag.length);

    for (var i = 0; i < inputTag.length; i++ ){

        console.log("Sono nel for");

        console.log("Stampa: " + inputTag[i].getAttribute("type"));

        console.log(inputTag[i].getAttribute("name"));
        inputTag[i].addEventListener("blur", check.bind(null, inputTag[i]));
    }

}

window.onload = main();

//window.document.getElementsByTagName("body").onload = main();
