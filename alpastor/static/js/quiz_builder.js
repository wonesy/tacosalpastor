/*
This will be the namespace defined for keeping track of global quiz data
 */
var QuizData = {};

/*
Translates integer question-type data into a compact string form
 */
var questionTypesI2A = {
    0: "Essay",
    1: "M.C.",
    2: "C.B.",
    3: "N.S."
};

/*
Translates string form type into the corresponding integer type
 */
var questionTypesA2I = {
    "Essay": 0,
    "M.C.": 1,
    "Checkbox": 2,
    "Numeric": 3
};

/*
Translates an integer type to it's corresponding addTypeQuestion() function
 */
var questionTypesI2Function = {
    0: addEssayQuestion,
    1: addMultipleChoiceQuestion,
    2: addCheckboxQuestion,
    3: addNumericScaleQuestion
};

/*
Generic JSON template for a question
 */
function _getNewQuestionMap() {
    return {
        "type": "",
        "content": "",
        "explanation": "",
        "randomize": false,
        "options": []
    };
}

/*
Generic JSON template for an option of a MC or CB question
 */
function _getNewOptionMap() {
    return {
        "content": "",
        "is_correct": false
    };
}

// Total questions added to the entire quiz
QuizData.totalQuestions = 0;

/*
This function loops through the entire quiz as it exists and collects the relevant information, sending to server as JSON

General algorithm:

    1) get quiz title
    2) forall questions:
    3) .... fill out _getNewQuestionMap()
    4) .... if multiple choice or checkbox:
    5) .... .... forall options:
    6) .... .... .... fill out _getNewOptionMap()
    7) ssubmit all acquired data as stringified JSON
 */
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

/*
Wrapper function that assigns the submission form input value as the stringified JSON
 */
function buildQuizJSON() {
    document.getElementById('json_quiz').value = JSON.stringify(mapAllQuestions());
}

/*
Returns a new ID based on number of ID objects already created
 */
function getNewID() {
    var newID = String(QuizData.totalQuestions);
    QuizData.totalQuestions++;
    return newID;
}

/*
Deletes a multiple choice option

Parameters:
    canvasID: the dom ID to which optionCanvas this option belongs
    optionID: the dom ID of the specific option that will be removed
 */
function deleteMCOption(canvasID, optionID) {
    var option = document.getElementById(optionID);
    var canvas = document.getElementById(canvasID);
    canvas.removeChild(option);
}

/*
Toggles the 'is_correct' aspect of a MC option. This updates the field value and toggles visual green checkbox effect

Parameters:
    element: this is the specific button element that was clicked
 */
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

/*
This will add a new question to the DOM, depending on what the user chose.

It prioritizes existing questions that are chosen, and in the case where both existing AND blank questions were chosen,
the blank question is ignored.

In order to get a blank question added to the Quiz, the user must select only from the blank radio buttons.
 */
function addNewOrExistingQuestions() {
    var numChecked = 0;
    var checkboxes = document.getElementById('existingQuestionsResults').getElementsByTagName('input');

    for (var i = 0; i < checkboxes.length; i++) {
        if (checkboxes[i].checked === true) {
            numChecked++;

            var addQuestionFunc = questionTypesI2Function[QuizData.existingResults[i].type];

            addQuestionFunc(QuizData.existingResults[i]);
        }
    }

    // If numChecked is non-zero, it means question have already been added and we can return
    if (numChecked !== 0) {
        return numChecked;
    }

    // If we're here, we have no existing questions to add and look through the blank questions radio buttons
    var blankOption = $('input[name=blank-question-opt]:checked', '#blank-question-form').val();

    questionTypesI2Function[blankOption]();
}


/*
This is executed whenever the "existing questions" canvas is focused and marks the "blank questions" as None/empty
 */
function refreshBlankQuestionRadio() {
    $('input[name=blank-question-opt][value=\'None\']').prop("checked",true);
}


// HTML template for a dyanmically-added "existing question" result
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

// HTML template for a dynamically-added "existing option" result
var optionsResultsRowTemplate =
    "<div class='row q-option {1}'>{0}</div>";

/*
Calls the webAPI to access the database, searching for existing questions. Takes information from a search bar
and from a question-type dropdown menu

Returns: a function that does everything described
 */
function getExistingQuestionQueryset() {
    return function () {
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
    };
}

/*
Simple function to update the value of the dropdown menu
 */
function updateDropdownValue(val) {
    btn = document.getElementById('dropdownMenuButton');
    btn.innerHTML = val;
    getExistingQuestionQueryset()();
}

// this is the element template for every new multiple-choice question that gets added to the DOM
var multipleChoiceTemplate =
    "<div class='question-wrapper'>" +
        "<div class='card question'>" +
            "<span class='question-label'>Question Content</span>" +
            "<input type='text' name='content' class='form-control' maxlength='1024' required='true' id='id_content' value='{1}'>" +
            "<span class='question-label'>Explanation</span>" +
            "<input type='text' name='explanation' class='form-control' maxlength='1023' id='id_explanation' value='{2}'>" +
            "<span class='question-label'>Randomize Options</span>" +
            "<input type='checkbox' name='randomize' id='id_randomize' '{3}'>" +
            "<input type='hidden' name='type' value='1' id='id_type'>" +
        "<div class='card-body opt-canvas' id={0}></div>" +
            "<button class='new-question-btn btn fa fa-plus' type='button' onclick='addMultipleChoiceOption({0});'>" +
            "</button>" +
        "</div>" +
    "</div>";

// Every time this is called, a new MC template will be added to the DOM and filled out accordingly
function addMultipleChoiceQuestion(existingQuestion) {
    var questionCanvas = document.getElementById('question-canvas');

    var content = "";
    var explanation = "";
    var randomize = "";
    var optionLength = 0;

    if (existingQuestion !== undefined) {
        content = existingQuestion['content'];
        explanation = existingQuestion['explanation'];

        if (existingQuestion['randomize'] === true) {
            randomize = "checked='true'";
        }

        optionLength = existingQuestion['multiplechoiceoption_set'].length;
    }

    var canvasID = getNewID();
    questionCanvas.innerHTML += multipleChoiceTemplate.format(canvasID, content, explanation, randomize);

    // loop through and all all options
    for (var i = 0; i < optionLength; i++) {
        console.log(existingQuestion['multiplechoiceoption_set'][i]);
        addMultipleChoiceOption(canvasID, existingQuestion['multiplechoiceoption_set'][i]);
    }
}

var multipleChoiceOptionTemplate =
    "<div class='row mc-opt-wrapper' id='mcOption{0}'>" +
        "<div class='col col-sm mc-opt-delete-sidebar'>" +
            "<button class='btn btn-block h-100 w-100' type='button' onclick='deleteMCOption({1}, \"mcOption{0}\");'>" +
                "<i class='fa fa-lg fa-trash-alt'></i>" +
            "</button>" +
        "</div>" +
        "<div class='mc-opt-content col'>" +
            "<input type='text' name='content' class='form-control' maxlength='1024' required='true' id='id_content' value='{2}'>" +
        "</div>" +
        "<div class='col col-sm mc-opt-correct-sidebar'>" +
            "<button class='btn btn-block h-100 w-100 {3}' type='button' onclick='isCorrectToggle(this);'>" +
                "<input type='hidden' name='is_correct' value={4} id='id_is_correct'>" +
                "<i class='fa fa-lg fa-check-circle'></i>" +
            "</button>" +
        "</div>" +
    "</div>";

function addMultipleChoiceOption(optCanvasId, existingOption) {
    var optCanvas = document.getElementById(optCanvasId);

    var content = "";
    var isCorrect = false;
    var activeClass = "";

    if (existingOption !== undefined) {
        content = existingOption['content'];
        isCorrect = existingOption['is_correct'];

        if (isCorrect === true) {
            activeClass = "active";
        }
    }

    console.log(multipleChoiceOptionTemplate.format(getNewID(), optCanvasId, content));
    optCanvas.innerHTML += multipleChoiceOptionTemplate.format(getNewID(), optCanvasId, content, activeClass, isCorrect);
}

function addEssayQuestion() {
    console.log("Adding essay question");
}

function addCheckboxQuestion() {
    console.log("Adding checkbox question");
}

function addNumericScaleQuestion() {
    console.log("Adding numeric scale question");
}
