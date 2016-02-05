var listOfInputToCheck = {
    //'Il nome del cantante deve avere almeno 2 caratteri composti da lettere o numeri'],
    artistNick : /^\w{2,}(\w| )+$/, 
    artistImage : /^(\w+.\w+)?$/,
    artistDescription : /^.+$/,
    albumName : /^\w{2,}(\w| )+$/, 
    albumImage : /^\w+.\w+$/,
    songTitle : /^\w{2,}(\w| )+$/, //'Il titolo contiene caratteri non validi'],
    songLyrics : /^.+$/m,
    songExtra : /^\w+$/,
    articleAuthor : /^\w{2,}(\w| )+$/, //'L\'autore dell\'articolo non è corretto'],
    articleData : /^\d{1,2}-\d{1,2}-\d{4}$/, //'La data inserita non è valida'],
    articleTitle : /^\w{2,}(\w| )+$/, //'Il titolo contiene caratteri non validi'],
    articleSubtitle : /^\w{2,}(\w| )+$/, //'Il sotto-titolo contiene caratteri non validi']
    articleContent : /^.+$/m
};


function check(input) {
    'use strict';

    var inputName = input.getAttribute("name");
    var value = input.value;
        
    console.log("inputName " + inputName);
    console.log("Sono in check");

    var checker = listOfInputToCheck[inputName];
    
    if ( checker != null && !checker.test(value) ){
        console.log("Cambio la voce in visible");
        document.getElementById("err-".concat(inputName)).className = "error visible";
    } else {
	console.log("Cambio la voce in invisibibile");
	document.getElementById("err-".concat(inputName)).className = "error hidden";
    }
}


function checkAll() {
    'use strict';

    //Catturo tutti gli input
    var inputTag = document.querySelectorAll("input,textarea");
    console.log( "Catturati gli input, dimensione: " + inputTag.length );

    var size = inputTag.lenght;
    var check = true;
    var i = 0; //indice input attulmente visitato
    
    //Ottengo il loro nome e prendo la regex assegnatoli. Se esiste e risulta
    //negativo viene visualizzato l'errore, altrimenti viene eseguito il submit.
    while ( i < size ) {
	var input = inputTag[i];

	var name = input.getAttribute( "name" );
	var value = input.value;

	var checker = listOfInputToCheck[inputName];
    console.log( "Controllo di " + name + " regex " + checker );
    console.log( checker != null );

	if ( checker != null && !checker.test(value) ){
            console.log("Cambio la voce in visible");
            document.getElementById("err-".concat(name)).className = "error visible";

	    check = false;
	} 
    }

    return check;
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

    //L'unico form della pagina, impedisci di eseguire il submit finché
    //tutti i campi non sono validati
    document.getElementsByName( "form" )[0].onsubmit = function() {
	return checkAll();
    }
}

window.onload = main();

//window.document.getElementsByTagName("body").onload = main();
