var idList = [];
var totalQuestions = 0;

function getNewID() {
    var newID = String(totalQuestions);
    totalQuestions++;
    console.log("Creating new question with ID: " + newID);
    return newID;
}

function deleteQuestion() {

}