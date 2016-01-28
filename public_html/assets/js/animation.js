/**
 * Created by luca on 12/01/16.
 */
(function () {
    'use strict';
    var btn = document.getElementById("open-menu-btn");
    var menu = document.getElementById("menu");
    var menuOpen = false;
    btn.onclick = function () {
        if (menuOpen) {
            menu.className = "";
        } else {
            menu.className = "open";
        }
        menuOpen = !menuOpen;
    };
})();
