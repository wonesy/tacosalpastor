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