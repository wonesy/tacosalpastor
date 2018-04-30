var QuizData = {};

var questionTypesI2A = {
    0: "Essay",
    1: "M.C.",
    2: "C.B.",
    3: "N.S."
};

var questionTypesA2I = {
    "Essay": 0,
    "M.C.": 1,
    "Checkbox": 2,
    "Numeric": 3
};

function _getNewQuestionMap() {
    return {
        "type": "",
        "content": "",
        "explanation": "",
        "randomize": false,
        "options": []
    };
}

function _getNewOptionMap() {
    return {
        "content": "",
        "is_correct": false
    };
}
var totalQuestions = 0;

function mapAllQuestions() {

    var quizMap = {
        "title": "",
        "questions": []
    };

    quizMap['title'] = document.getElementById('quizTitle').value;

    /* Loop through all question elements */
    var questionElems = document.getElementsByClassName('question');
    for (var i = 0; i < questionElems.length; i++) {

        var curQuestion = questionElems[i];

        /* Collect salient information about each question */
        var questionContent = curQuestion.querySelector("#id_content").value;
        var questionExplanation = curQuestion.querySelector("#id_explanation").value;
        var questionRandomize = curQuestion.querySelector("#id_randomize").checked;
        var questionType = curQuestion.querySelector('#id_type').value;

        /* Assign collected information to the quiz map */
        var question = _getNewQuestionMap();
        question['content'] = questionContent;
        question['explanation'] = questionExplanation;
        question['randomize'] = questionRandomize;
        question['type'] = questionType;

        /* Loop through all possible options for each question */
        // TODO [if type is multiple-choice]
        var optionElems = curQuestion.querySelectorAll(".mc-opt-wrapper");
        for (var j = 0; j < optionElems.length; j++) {
            var curOption = optionElems[j];

            /* Collect salient information about each option */
            var optionContent = curOption.querySelector("#id_content").value;
            var optionIsCorrect = curOption.querySelector("#id_is_correct").value;

            /* Assign collected information to the option section of the quiz map */
            var option = _getNewOptionMap();
            option['content'] = optionContent;
            option['is_correct'] = optionIsCorrect;

            question['options'].push(option);
        }

        quizMap['questions'].push(question);
    }

    return quizMap;
}

function getNewID() {
    var newID = String(totalQuestions);
    totalQuestions++;
    return newID;
}

function deleteMCOption(canvasID, optionID) {
    var option = document.getElementById(optionID);
    var canvas = document.getElementById(canvasID);
    canvas.removeChild(option);
}

function isCorrectToggle(element) {
    var checkbox = element.querySelector("#id_is_correct");
    if (element.classList.contains('active')) {
        element.classList.remove('active');
        checkbox.value = "False";
    } else {
        element.classList.add('active');
        checkbox.value = "True";
    }
}

function buildQuizJSON() {
    document.getElementById('json_quiz').value = JSON.stringify(mapAllQuestions());
}

function addExistingQuestions() {
    var numChecked = 0;
    var checkboxes = document.getElementById('existingQuestionsResults').getElementsByTagName('input');

    for (var i = 0; i < checkboxes.length; i++) {
        if (checkboxes[i].checked === true) {
            numChecked++;

            switch (QuizData.existingResults[i].type) {
                case 0:
                    // TODO
                    break;
                case 1:
                    addMultipleChoiceQuestion(QuizData.existingResults[i]);
                    break;
                default:
                    // TODO
                    break;
            }
        }
    }

    // If there is nothing to add, add the checked blank question
    if (numChecked === 0) {
        // TODO
        console.log("A blank question will be added TODO")
    }
}


/*
    Function:       refreshBlankQuestionRadio

    Description:    This is executed whenever the "existing questions" canvas is focused and marks the "blank questions"
                    as None/empty
 */
function refreshBlankQuestionRadio() {
    $('input[name=blank-question-opt][value=\'None\']').prop("checked",true);
}


var resultsRowTemplate =
    "<div class='q-result row'>" +
        "<div class='col-sm-1 col-md-1 col-lg-1'>" +
            "<input id='existingResult{2}' type='checkbox' value='{2}'>" +
        "</div>" +
        "<a href='#optionsCanvas{2}' data-toggle='collapse' role='button' aria-expanded='true' aria-controls='#optionsCanvas{2}' class='col-sm-11 col-md-11 col-lg-11'>" +
            "<div class=''>" +
                "<div class='q-type'>{0}</div>" +
                "<div class='q-content'>{1}</div>" +
            "</div>" +
        "</a>" +
    "</div>" +
    "<div id='optionsCanvas{2}' class='collapse'></div>";

var optionsResultsRowTemplate =
    "<div class='row q-option {1}'>{0}</div>";

function getExistingQuestionQueryset() {
    return function() {
        var baseUrl = window.location.origin + window.location.pathname + "existingquestion";

        var typeElem = document.getElementById('dropdownMenuButton');               // the question type dropdown
        var searchElem = document.getElementById("searchExistingQuestion");         // the search bar
        var resultsCanvas = document.getElementById("existingQuestionsResults");    // where the results will be displayed
        var typeURL = "";

        resultsCanvas.innerHTML = "";

        if (searchElem.value === "") {
            return;
        }

        if (typeElem.innerHTML !== "Any") {
            var type = questionTypesA2I[typeElem.innerHTML];
            typeURL = "&type={0}".format(type);
        }

        // construct full web API URI
        var fullAPIURL = baseUrl + "?content=" + searchElem.value + typeURL;

        // execute the web API call and handle data accordingly
        $.getJSON(fullAPIURL, null, function (data) {

            // add results to global quiz namespace
            QuizData.existingResults = data;

            // loop through all results, append them to their canvases accordingly
            for (var i = 0; i < data.length; i++) {
                resultsCanvas.innerHTML += resultsRowTemplate.format(questionTypesI2A[data[i]['type']], data[i]['content'], i);

                var canvasId = "optionsCanvas{0}".format(i);
                var optionsCanvas = document.getElementById(canvasId);

                // loop through all of the options (multiple choice and checkbox questions)
                for (var j = 0; j < data[i]['multiplechoiceoption_set'].length; j++) {

                    var isCorrectClass = "";
                    if (data[i]['multiplechoiceoption_set'][j]['is_correct'] === true) {
                        isCorrectClass = "is-correct";
                    }
                    optionsCanvas.innerHTML += optionsResultsRowTemplate.format(data[i]['multiplechoiceoption_set'][j]['content'], isCorrectClass);
                }
            }
        });
    }
}