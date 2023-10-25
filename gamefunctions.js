var documentWidth = document.documentElement.clientWidth;
var documentHeight = document.documentElement.clientHeight;

var cursor = document.getElementById("cursor");
var cursorX = documentWidth / 2;
var cursorY = documentHeight / 2;
var CurrentPage = 0
var CurrentSubPage = 0
var CurrentLevel = 15
/*function UpdateCursorPos() {
    cursor.style.left = cursorX;
    cursor.style.top = cursorY;
}*/

function CheckUnlock(option, ItemLevel) {
    if (ItemLevel > CurrentLevel) {
        Images = option.childNodes
        Images[0].style.filter = "grayscale(1)"
        Images[2].style.display = "block"
        Images[2].innerHTML = `You must be level ${ItemLevel} to select this option!`
    }
}

function RevertToGray(option) {
    Images = option.childNodes
    Images[2].style.display = "none"
}

function MainButtonClicked(nextpage) {
    MainElement = document.getElementById("mainpage")
    pages = document.getElementsByClassName("subpage")
    MainElement.style.display = "none"
    pages[nextpage].style.display = "block"
    CurrentPage = nextpage
}

function SubButtonClicked(nextpage) {
    SubPage = document.getElementsByClassName("subpage")
    OptionPage = document.getElementsByClassName(`optionpage${CurrentPage}`)
    SubPage[CurrentPage].style.display = "none"
    OptionPage[nextpage].style.display = "block"
}

function MainCloseButtonClicked() {
    MainElement = document.getElementById("mainpage")
    MainElement.style.display = "none"
    $.post('http://chaos-armory/escape', JSON.stringify({
    }));
}

function SubMenuBackButtonClicked() {
    MainElement = document.getElementById("mainpage")
    pages = document.getElementsByClassName("subpage")
    for (var i = 0; i < pages.length; i++) {
        pages[i].style.display = "none"
    }
    MainElement.style.display = "block"
    CurrentPage = 0
}

function OptionMenuBackButtonClicked() {
    SubPage = document.getElementsByClassName("subpage")
    OptionPage = document.getElementsByClassName(`optionpage${CurrentPage}`)
    for (var i = 0; i < OptionPage.length; i++) {
        OptionPage[i].style.display = "none"
    }
    SubPage[CurrentPage].style.display = "block"
}

$(function() {
    window.addEventListener('message', function(event) {
        if (event.data.type == "enableui") {
            MainElement = document.getElementById("mainpage")
            MainElement.style.display = "block"
        }
    });

    $("#closeshit").click(function (e) {
        //e.preventDefault(); // Prevent form from submitting

        $.post('http://chaos-leaderboards/escape', JSON.stringify({
        }));
    });
});
