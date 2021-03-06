function regByName( name ) {
    var listOfInputToCheck = {
	//'Il nome del cantante deve avere almeno 2 caratteri composti da lettere o numeri'],
	artistNick : /^\w{2,}(\w| )+$/, 
	artistImage : /^(\w+\.\w+)?$/,
	artistDescription : /^.+$/,
	albumName : /^\w{2,}(\w| )+$/, 
	albumImage : /^\w+\.\w+$/,
	songTitle : /^\w{2,}(\w| )+$/, //'Il titolo contiene caratteri non validi'],
	songLyrics : /^.+$/m,
	songExtra : /^\w+$/,
	articleAuthor : /^\w{2,}(\w| )+$/, //'L\'autore dell\'articolo non è corretto'],
	articleData : /^\d{1,2}-\d{1,2}-\d{4}$/, //'La data inserita non è valida'],
	articleTitle : /^\w{2,}(\w| )+$/, //'Il titolo contiene caratteri non validi'],
	articleSubtitle : /^\w{2,}(\w| )+$/, //'Il sotto-titolo contiene caratteri non validi']
	articleContent : /^.+$/m
    };

    return listOfInputToCheck[ name ];
}

function check(input) {
    'use strict';

    var inputName = input.getAttribute("name");
    var value = input.value;
        
    console.log("inputName " + inputName);
    console.log("Sono in check");

    var checker = regByName( inputName ); 
    
    if ( checker !== undefined && !checker.test(value) ){
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

    var size = inputTag.length;
    var check = true;

    console.log( "Size= " + size );
    
    //Ottengo il loro nome e prendo la regex assegnatoli. Se esiste e risulta
    //negativo viene visualizzato l'errore, altrimenti viene eseguito il submit.
    for ( var i = 0; i < size; i++ ) {
	console.log( "Dentro al while" );

	var input = inputTag[i];

	var name = input.getAttribute( "name" );
	var value = input.value;

	console.log( "Controllo di " + name + " regex " + checker );
	console.log( checker != null );

	var checker = regByName( name );
	if ( checker !== undefined && !checker.test(value) ){
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
    var jsFlag = document.getElementsByName("javascript")[0];

    if ( jsFlag !== undefined ) {
	jsFlag.value = 1;
    }
    
    console.log(inputTag.length);

    for (var i = 0; i < inputTag.length; i++ ){

        console.log("Sono nel for");

        console.log("Stampa: " + inputTag[i].getAttribute("type"));

        console.log(inputTag[i].getAttribute("name"));
        inputTag[i].addEventListener("blur", check.bind(null, inputTag[i]));
    }

    var form = document.getElementsByTagName( "form" )[0];

    if ( form !== undefined ) {
	//L'unico form della pagina, impedisci di eseguire il submit finché
	//tutti i campi non sono validati
	form.onsubmit = function() { return checkAll(); }
    }
}

window.onload = main();




