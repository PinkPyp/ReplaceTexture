

function MainButtonClicked() {
    var TextureDict = document.getElementById("TextureDict").value
    var TextureName = document.getElementById("TextureName").value
    var IsRuntime = document.getElementById("IsRuntime").checked
    var NewTextureDict = document.getElementById("NewTextureDict").value
    var NewTextureName = document.getElementById("NewTextureName").value
    var Width = document.getElementById("Width").value
    var Height = document.getElementById("Height").value
    if (IsRuntime === true) {
        $.post('http://TextureReplaces/SendClientSelectedRuntime', JSON.stringify({
            TextureDict: `${TextureDict}`,
            TextureName: `${TextureName}`,
            NewTextureDict: `runtime`,
            NewTextureName: `${NewTextureName}`,
            Width: `${Width}`,
            Height: `${Height}`
        }));
    } else {
        $.post('http://TextureReplaces/SendClientSelectedTexture', JSON.stringify({
            TextureDict: `${TextureDict}`,
            TextureName: `${TextureName}`,
            NewTextureDict: `${NewTextureDict}`,
            NewTextureName: `${NewTextureName}`
        }));
    }
    MainElement = document.getElementById("mainpage")
    MainElement.style.display = "block"
}

function MainButtonClicked2() {
    var TextureDict = document.getElementById("TextureDict").value
    var TextureName = document.getElementById("TextureName").value

    $.post('http://TextureReplaces/SendClientRemoveTexture', JSON.stringify({
        TextureDict: `${TextureDict}`,
        TextureName: `${TextureName}`
    }));
}

function SaveCurrentInput() {
    var TextureDict = document.getElementById("TextureDict").value
    var TextureName = document.getElementById("TextureName").value
    var IsRuntime = document.getElementById("IsRuntime").checked
    var NewTextureDict = document.getElementById("NewTextureDict").value
    var NewTextureName = document.getElementById("NewTextureName").value
    var Width = document.getElementById("Width").value
    var Height = document.getElementById("Height").value
    if (IsRuntime === true) {
        $.post('http://TextureReplaces/SaveSelectedRuntime', JSON.stringify({
            TextureDict: `${TextureDict}`,
            TextureName: `${TextureName}`,
            NewTextureDict: `runtime`,
            NewTextureName: `${NewTextureName}`,
            Width: `${Width}`,
            Height: `${Height}`
        }));
    } else {
        $.post('http://TextureReplaces/SaveSelectedTexture', JSON.stringify({
            TextureDict: `${TextureDict}`,
            TextureName: `${TextureName}`,
            NewTextureDict: `${NewTextureDict}`,
            NewTextureName: `${NewTextureName}`
        }));
    }
    MainElement = document.getElementById("mainpage")
    MainElement.style.display = "block"
}

function LoadAllSavedTextures() {
    $.post('http://TextureReplaces/LoadAllTextures', JSON.stringify({
    }));
}

function ClearAllSavedTextures() {
    $.post('http://TextureReplaces/ClearAllTextures', JSON.stringify({
    }));
}

function SaveAllCurrentTextures() {
    $.post('http://TextureReplaces/SaveAllTextures', JSON.stringify({
    }));
}

function MainButtonClicked2() {
    var TextureDict = document.getElementById("TextureDict").value
    var TextureName = document.getElementById("TextureName").value

    $.post('http://TextureReplaces/SendClientRemoveTexture', JSON.stringify({
        TextureDict: `${TextureDict}`,
        TextureName: `${TextureName}`
    }));
}

function MainCloseButtonClicked() {
    MainElement = document.getElementById("mainpage")
    MainElement.style.display = "none"
    $.post('http://TextureReplaces/escape', JSON.stringify({
    }));
}

$(function() {
    window.addEventListener('message', function(event) {
        if (event.data.type == "enableui") {
            MainElement = document.getElementById("mainpage")
            MainElement.style.display = "block"
        }
    });
});
