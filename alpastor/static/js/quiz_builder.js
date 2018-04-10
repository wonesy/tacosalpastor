var idList = [];
var totalQuestions = 0;

function getNewID() {
    var newID = String(totalQuestions);
    totalQuestions++;
    console.log("Creating new question with ID: " + newID);
    return newID;
}

function deleteMCOption(canvas, option) {
    canvas.removeChild(option);
}

function isCorrectToggle(element, checkbox) {
    var checkbox = element.querySelector("#id_is_correct")
    console.log(checkbox);
    if (element.classList.contains('active')) {
        element.classList.remove('active');
        checkbox.checked = false;
    } else {
        element.classList.add('active');
        checkbox.checked = true;
    }
}