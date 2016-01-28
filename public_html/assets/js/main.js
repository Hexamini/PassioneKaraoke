function check(inputName, value) {
    'use strict';

    console.log("inputName " + inputName);
    console.log("Sono in check");

    var listOfInputToCheck = {
        artistNick : /(\w+){2,}/, //'Il nome del cantante deve avere almeno 2 caratteri composti da lettere o numeri'],
        artistBorn : /(\d+){1,2}\-(d+){1,2}\-(d+){4}/, //'Il formato data non è valido'],
        artistDeath : /(\d+){1,2}\-(d+){1,2}\-(d+){4}/, //'La morte dell\'artista non è valida'],
        songTitle : /(\w+)/, //'Il titolo contiene caratteri non validi'],
        articleAuthor : /(\w+)/, //'L\'autore dell\'articolo non è corretto'],
        articleData : /(\d+){1,2}\-(d+){1,2}\-(d+){4}/, //'La data inserita non è valida'],
        articleTitle : /(\w+)/, //'Il titolo contiene caratteri non validi'],
        articleSubtitle : /(\w+)/ //'Il sotto-titolo contiene caratteri non validi']
    };


    console.log("test2 " + inputName.toString());

    var tmpVar = "\"" + inputName + "\"";

    console.log(tmpVar);

    if ( !listOfInputToCheck["artistNick"].test(value) ){

        console.log("Cambio la voce in visible");

        document.getElementById("err-".concat(inputName)).className += " visible";
    }
}

function main() {
    'use strict';

    console.log("Main chiamato");

    var inputTag = document.getElementsByTagName("input");

    console.log(inputTag.length);

    for (var i = 0; i < inputTag.length; i++ ){

        console.log("Sono nel for");

        if ( inputTag[i].getAttribute("type") === "text" ) {

            console.log("Stampa: " + inputTag[i].getAttribute("type"));

            console.log(inputTag[i].getAttribute("name"));

            //inputTag[i].onblur = check(inputTag[i].getAttribute("name"), inputTag[i].getAttribute("value") );
            inputTag[i].addEventListener("blur", check.bind(null, inputTag[i].getAttribute("name"), inputTag[i].getAttribute("value")))

        }
    }

}

window.onload = main();

//window.document.getElementsByTagName("body").onload = main();
