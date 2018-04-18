/*
* Extend JavaScript String object with printf() like functionality
* "{0} is dead, but {1} is alive!".format("This", "that");
*/
String.prototype.format = function() {
    var formatted = this;
    for(arg in arguments) {
        formatted = formatted.replace("{" + arg + "}", arguments[arg]);
    }
    return formatted;
};

function getQuestionTypeString(num) {
    var string = "None";
    switch (num) {
        case 0:
            string = "Essay";
            break;
        case 1:
            string = "MC";
            break;
        case 2:
            string = "Checkbox";
            break;
        case 3:
            string = "Numeric";
            break;
        default:
            string = "ERROR";
    }

    return string;
}

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

function deleteMCOption(canvas, option) {
    canvas.removeChild(option);
}

function isCorrectToggle(element, checkbox) {
    var checkbox = element.querySelector("#id_is_correct");
    console.log(checkbox);
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

/*
    Function:       refreshBlankQuestionRadio

    Description:    This is executed whenever the "existing questions" canvas is focused and marks the "blank questions"
                    as None/empty
 */
function refreshBlankQuestionRadio() {
    $('input[name=blank-question-opt][value=\'None\']').prop("checked",true);
}


var resultsRowTemplate =
    "<div class='col-sm-1'>{0}</div>" +
    "<div class='col-sm-11'>{1}</div>";

function getExistingQuestionQueryset() {
    var baseUrl = window.location.origin + window.location.pathname + "existingquestion";

    var searchElem = document.getElementById("searchExistingQuestion");         // the search bar
    var resultsCanvas = document.getElementById("existingQuestionsResults");    // where the results will be displayed

    resultsCanvas.innerHTML = "";

    if (searchElem.value == "") {
        return;
    }

    // construct full web API URI
    fullAPIURL = baseUrl + "?content=" + searchElem.value;

    // execute the web API call and handle data accordingly
    $.getJSON(fullAPIURL, null, function(data) {
        for (var i = 0; i < data.length; i++) {
            resultsCanvas.innerHTML += resultsRowTemplate.format(getQuestionTypeString(data[i]['type']), data[i]['content']);
            console.log(data[i]);
        }
    });
}

function addNewQuestion() {

}