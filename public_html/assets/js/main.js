function check(inputName, value) {
    'use strict';

    var listOfInputToCheck = {

        'artistNick' : /\w+{2,}/i, //'Il nome del cantante deve avere almeno 2 caratteri composti da lettere o numeri'],
        'artistBorn' : /\d+{1,2}\-d+{1,2}\-d+{4}/i, //'Il formato data non è valido'],
        'artistDeath' : /\d+{1,2}\-d+{1,2}\-d+{4}/, //'La morte dell\'artista non è valida'],
        'songTitle' : /\w+/i, //'Il titolo contiene caratteri non validi'],
        'articleAuthor' : /\w+/i, //'L\'autore dell\'articolo non è corretto'],
        'articleData' : /\d+{1,2}\-d+{1,2}\-d+{4}/i, //'La data inserita non è valida'],
        'articleTitle' : /\w+/i, //'Il titolo contiene caratteri non validi'],
        'articleSubtitle' : /\w+/i //'Il sotto-titolo contiene caratteri non validi']
    };

    if ( !listOfInputToCheck[inputName].test(value) ){

        document.getElementById("err-".concat(inputName)).className += " visible";
    }
}

function main() {
    'use strict';

    var inputTag = document.getElementsByTagName("input");

    for (var i = 0; i < inputTag.length; i++ ){

        if ( inputTag[i].getAttribute("type") === "text" ) {

            inputTag[i].blur = check(inputTag[i].getAttribute("name"), inputTag[i].getAttribute("value") );
        }
    }

}

window.onload = main();
