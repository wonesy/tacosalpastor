let QuestionTypeEnum = {
    ESSAY: 0,
    MULTIPLE_CHOICE: 1,
    NUMERIC_SCALE: 2,
    properties: {
        0: {
            name: "Essay",
            value: 1,
            code: "Essay",
            addFunction: addEssayQuestion
        },
        1: {
            name: "Multiple Choice",
            value: 1,
            code: "MC",
            addFunction: addMultipleChoiceQuestion
        },
        2: {
            name: "Numeric Scale",
            value: 2,
            code: "NS",
            addFunction: /* addNumericScaleQuestion */ function() { console.log("TEMPORARY, adding numeric scale"); }
        },
        "Essay": {
            value: 0
        },
        "Multiple Choice": {
            value: 1
        },
        "Numeric Scale": {
            value: 2
        }
    }
};

let QuizErrorEnum = {
    SUCCESS: 0,
    NO_TITLE: 1,
    NO_QUESTION_CONTENT: 2,
    NO_OPTION_CONTENT: 3,
    NO_ANSWER: 4,
    EMPTY_FIELD: 5,
    properties: {
        0: {
            message: ""
        },
        1: {
            message: "Quiz must have title"
        },
        2: {
            message: "Question content section must not be empty"
        },
        3: {
            message: "Option content sections must not be empty"
        },
        4: {
            message: "At least one option must be marked as correct"
        },
        5: {
            message: "All fields must be filled out"
        }
    }
};

class MultipleChoiceOption {

    constructor (id, content, isCorrect, domElement) {
        this.id = id;
        this.content = content;
        this.isCorrect = isCorrect;
        this.domElement = domElement;
    }

    captureValues() {
        this.content = this.domElement.querySelector("#id_content").value;
        this.isCorrect = this.domElement.querySelector("#id_is_correct").value;
    }

    toJSON() {
        this.captureValues();

        let error = QuizErrorEnum.SUCCESS;
        let json = {
            content: this.content,
            is_correct: this.isCorrect
        };

        if (this.content === "") {
            error = QuizErrorEnum.NO_OPTION_CONTENT;
        }

        return {
            json: json,
            error: error,
            id: this.id
        }
    }
}

class Question {

    constructor(id, type, content, explanation, domElement) {
        this.id = id;
        this.type = type;
        this.content = content;
        this.explanation = explanation;
        this.domElement = domElement;
    }

    captureValues() {
        this.content = this.domElement.querySelector("#id_content").value;
        this.explanation = this.domElement.querySelector("#id_explanation").value;
    }

    toJSON() {
        this.captureValues();

        let error = QuizErrorEnum.SUCCESS;
        let json = {
            type: this.type,
            content: this.content,
            explanation: this.explanation
        };

        if (this.content === "") {
            error = QuizErrorEnum.NO_QUESTION_CONTENT;
        }

        return {
            json: json,
            error: error,
            id: this.id
        }
    }
}

class EssayQuestion extends Question {
    constructor (id, content, explanation, domElement) {
        super(id, QuestionTypeEnum.ESSAY, content, explanation, domElement);
    }
}

class MultipleChoiceQuestion extends Question {
    constructor (id, content, explanation, randomize, domElement) {
        super(id, QuestionTypeEnum.MULTIPLE_CHOICE, content, explanation, domElement);
        this.randomize = randomize;
        this.options = [];
    }

    addOption(option) {
        if ((option instanceof MultipleChoiceOption) && (this.type === QuestionTypeEnum.MULTIPLE_CHOICE)) {
            this.options.push(option);
        }
    }

    deleteOptionById(id) {
        let index = -1;
        for (let i = 0; i < this.options.length; i++) {
            if (this.options[i].id === id) {
                index = i;
                break;
            }
        }

        if (index >= 0) {
            this.options.remove(index);
        }
    }

    captureValues() {
        super.captureValues();
        this.randomize = this.domElement.querySelector("#id_randomize").checked;
    }

    toJSON() {
        this.captureValues();

        let json = {
            type: this.type,
            content: this.content,
            explanation: this.explanation,
            randomize: this.randomize,
            options: []
        };

        let returnStmt = {
            json: json,
            error: QuizErrorEnum.SUCCESS,
            id: this.id
        };

        // Error if the question has no content
        if (this.content === "") {
            returnStmt.error = QuizErrorEnum.NO_QUESTION_CONTENT;
            return returnStmt;
        }

        let hasCorrectAnswer = false;

        // Loop through each option and collect its JSON
        for (let i = 0; i < this.options.length; i++) {
            let results = this.options[i].toJSON();

            if (results.error !== QuizErrorEnum.SUCCESS) {
                results.id = this.id;   // we change ID so that the error will show up for the question as a whole, not each individual option
                return results;
            }

            if (results.json.is_correct === "true") {
                hasCorrectAnswer = true;
            }

            json.options.push(results.json);
        }

        // Ensure that at least one option is marked correct
        if (!hasCorrectAnswer) {
            returnStmt.error = QuizErrorEnum.NO_ANSWER;
        }

        returnStmt.json = json;

        return returnStmt;
    }
}

class NumericScaleQuestion extends Question {
    constructor(id, content, min, max, step, answer) {
        super(id, QuestionTypeEnum.NUMERIC_SCALE, content, explanation);
        this.min = min;
        this.max = max;
        this.step = step;
        this.answer = answer;
    }
}

class Quiz {

    constructor(id, title) {
        this.id = id;
        this.title = title;
        this.questions = [];
        this.domElement = null;
    }

    addQuestion(question) {
        if (question instanceof Question){
            this.questions.push(question)
        } else {
            console.log("[Error] Attempted to add question to quiz that is not instanceof Question")
        }
    }

    findQuestionById(id) {
        for (let i = 0; i < this.questions.length; i++) {
            if (this.questions[i].id === id) {
                return this.questions[i];
            }
        }
    }

    deleteQuestionById(id) {
        let index = -1;
        for (let i = 0; i < this.questions.length; i++) {
            if (this.questions[i].id === id) {
                index = i;
                break;
            }
        }

        if (index >= 0) {
            this.questions.remove(index);
        }
    }

    captureValues() {
        this.title = this.domElement.value;
    }

    toJSON() {
        this.captureValues();

        let json = {
            id: this.id,
            title: this.title,
            questions: []
        };

        let returnStmt = {
            json: json,
            error: QuizErrorEnum.SUCCESS,
            id: this.id
        };

        // Error if there is no title for the quiz
        if (this.title === "") {
            returnStmt.id = -1;
            returnStmt.error = QuizErrorEnum.NO_TITLE;
            return returnStmt;
        }

        // Loop through each question and collect its JSON
        for (let i = 0; i < this.questions.length; i++) {
            let results = this.questions[i].toJSON();

            if (results.error !== QuizErrorEnum.SUCCESS) {
                return results;
            }

            json.questions.push(results.json);
        }

        returnStmt.json = json;

        return returnStmt;
    }
}

let GlobalQuizData = {
    'quiz': new Quiz(-1, ""),                           // quiz instance for this page
    'totalQuestions': 0,                                // total questions registered for this quiz
    'totalMCQuestions': 0,                              // total number of multiple choice questions
    'totalEssayQuestions': 0,                           // total number of essay questions
    'totalNSQuestions': 0,                              // total number of numeric scale questions
    'getNextTabIndex': _globalGetNextTabIndex(),        // function to acquire the next tab index
    'nextId': 0,                                        // the next available HTML id
    'questionCanvas': null,                             // the DOM item that houses all questions on the page
    'getNextId': _globalGetNextId(),                    // function to get the next available HTML id
    'lastErrorId': -1,                                  // the id of the DOM item that contains the last error msg
    'existingResults': null                             // Existing results retrieved from the 'Add Question' button
};

function _globalGetNextId() {
    return function() {
        return GlobalQuizData.nextId++;
    }
}

function _globalGetNextTabIndex() {
    return function (id) {
        /*
            Tab index is going to be the same for all elements in a question, so it can be tightly coupled with the id

            We are increasing by 2 each time because tab index starts at 1, and question id's start at 0

            so element 0 must start at tabIndex=2, element 1 @ tabIndex=3, etc
         */
        return id+2;
    }
}


/**********************************************************************************************************************/
/*                                                                                                                    */
/*                                         Add/Delete Questions Section                                               */
/*                                                                                                                    */
/**********************************************************************************************************************/

/*
    Function:       addEssayQuestion

    Description:    Adds a new essay question element to the HTML DOM. It can either be a new (blank) question, or
                    an existing question retrieved from the database. We will keep track of this question in the global
                    list of quiz questions. Updates question counts

    Parameters:

        existingQuestion - (Optional) JSON data of an existing question retrieved from the database. This can be left
                           empty when calling it if we wish to create a blank essay question

    Returns:        None
 */
function addEssayQuestion(existingQuestion=null) {
    let essayQuestionTemplate =
        "<div class='question-wrapper essay-question' id='question{0}'>" +
            "<div class='card question'>" +
                "<div class='form-error-msg'></div>" +
                "<span class='question-label'>Question Content</span>" +
                "<input tabindex='{3}' type='text' name='content' class='form-control' maxlength='1024' required='true' id='id_content' value='{1}' placeholder='What do you want to ask?'>" +
                "<span class='question-label'>Explanation to be shown after submission (optional)</span>" +
                "<input tabindex='{3}' type='text' name='explanation' class='form-control' maxlength='1023' id='id_explanation' value='{2}' placeholder='Explanation'>" +
                "<input type='hidden' name='type' value='0' id='id_type'>" +
                "<button class='btn btn-danger question-delete' onclick='deleteQuestion(\"question{0}\");'>Delete Question</button>" +
            "</div>" +
        "</div>";

    let id = GlobalQuizData.getNextId();
    let content = "";
    let explanation = "";

    // If there is already an existing question we're pulling from, grab its data
    if (existingQuestion !== null) {
        content = existingQuestion['content'];
        explanation = existingQuestion['explanation'];
    }

    // Insert new essay question to the HTML DOM
    let tabIndex = GlobalQuizData.getNextTabIndex(id);
    GlobalQuizData.questionCanvas.insertAdjacentHTML("beforeend",
        essayQuestionTemplate.format(
            id,
            content,
            explanation,
            tabIndex
        )
    );

    // Save element
    let domElement = document.getElementById("question{0}".format(id));
    let essayQuestion = new EssayQuestion(id, content, explanation, domElement);


    // Add the essay question to the quiz instance
    GlobalQuizData.quiz.addQuestion(essayQuestion);

    // Bookkeeping
    GlobalQuizData.totalEssayQuestions++;
    GlobalQuizData.totalQuestions++;
}

/*
    Function:       addMultipleChoiceQuestion

    Description:    Adds a new multiple choice question element to the HTML DOM. It can either be a new (blank) question,
                    or an existing question retrieved from the database. We will keep track of this question in the global
                    list of quiz questions. Updates question counts

    Parameters:

        existingQuestion - (Optional) JSON data of an existing question retrieved from the database. This can be left
                           empty when calling it if we wish to create a blank multiple choice question

    Returns:        None
 */
function addMultipleChoiceQuestion(existingQuestion=null) {

    let multipleChoiceTemplate =
        "<div class='question-wrapper' id='question{0}'>" +
            "<div class='card question'>" +
                "<span class='question-label'>Question Content</span>" +
                "<div class='form-error-msg'></div>" +
                "<input tabindex='{4}' type='text' name='content' class='form-control' maxlength='1024' required='true' id='id_content' value='{1}' placeholder='What do you want to ask?'>" +
                "<span class='question-label'>Explanation to be shown after submission (optional)</span>" +
                "<input tabindex='{4}' type='text' name='explanation' class='form-control' maxlength='1023' id='id_explanation' value='{2}' placeholder='Explanation'>" +
                "<span class='question-label'>Randomize Options</span>" +
                "<input type='checkbox' name='randomize' id='id_randomize' '{3}'>" +
                "<input type='hidden' name='type' value='1' id='id_type'>" +
                "<div class='card-body opt-canvas' id={0}></div>" +
                    "<div class='opt-error-msg'></div>" +
                    "<button class='new-question-btn btn fa fa-plus' type='button' onclick='addMultipleChoiceOption({0});'></button>" +
                    "<button class='btn btn-danger question-delete' onclick='deleteQuestion(\"question{0}\");'>Delete Question</button>" +
                "</div>" +
            "</div>" +
        "</div>";

    let id = GlobalQuizData.getNextId();
    let content = "";
    let explanation = "";
    let randomize = "";
    let numOptions = 0;

    // If there is already an existing question we're pulling from, grab its data
    if (existingQuestion !== null) {
        content = existingQuestion['content'];
        explanation = existingQuestion['explanation'];
        randomize = existingQuestion['randomize'];
        numOptions = existingQuestion['multiplechoiceoption_set'].length;
    }

    // Insert new essay question to the HTML DOM
    let tabIndex = GlobalQuizData.getNextTabIndex(id);
    GlobalQuizData.questionCanvas.insertAdjacentHTML("beforeend",
        multipleChoiceTemplate.format(
            id,
            content,
            explanation,
            randomize,
            tabIndex
        )
    );

    // Save question
    let domElement = document.getElementById("question{0}".format(id));
    let mcQuestion = new MultipleChoiceQuestion(id, content, explanation, randomize, domElement);

    // Add the essay question to the quiz instance
    GlobalQuizData.quiz.addQuestion(mcQuestion);

    // Add all possible options as well
    for (let i = 0; i < numOptions; i++) {
        addMultipleChoiceOption(id, existingQuestion['multiplechoiceoption_set'][i]);
    }

    // Bookkeeping
    GlobalQuizData.totalMCQuestions++;
    GlobalQuizData.totalQuestions++;
}

/*
    Function:       addMultipleChoiceOption

    Description:    Adds a new multiple choice option element to the HTML DOM for a specific MC Question. It can either
                    be a new (blank) option, or an existing option retrieved from the database. It will only ever be an
                    existing option if the parent MCQuestion was also taken from the database. We will keep track of
                    this option in the question's list of options. Updates question counts

    Parameters:

        optCanvasId      - (Required) HTML/Question ID (they're the same here) that we will add the new option to
        existingQuestion - (Optional) JSON data of an existing question retrieved from the database. This can be left
                           empty when calling it if we wish to create a blank multiple choice question

    Returns:        None
 */
function addMultipleChoiceOption(optCanvasId, existingOption=null) {
    let multipleChoiceOptionTemplate =
        "<div class='row mc-opt-wrapper' id='mcOption{0}'>" +
            "<div class='col col-sm mc-opt-delete-sidebar'>" +
                "<button class='btn btn-block h-100 w-100' type='button' onclick='deleteMCOption({1}, {0});'>" +
                    "<i class='fa fa-lg fa-trash-alt'></i>" +
                "</button>" +
            "</div>" +
            "<div class='mc-opt-content col'>" +
                "<input  tabindex='{5}' type='text' name='content' class='form-control' maxlength='1024' required='true' id='id_content' value='{2}'>" +
            "</div>" +
            "<div class='col col-sm mc-opt-correct-sidebar'>" +
                "<button class='btn btn-block h-100 w-100 {3}' type='button' onclick='isCorrectToggle(this);'>" +
                    "<input type='hidden' name='is_correct' value={4} id='id_is_correct'>" +
                    "<i class='fa fa-lg fa-check-circle'></i>" +
                "</button>" +
            "</div>" +
        "</div>";

    let optCanvas = document.getElementById(optCanvasId);

    let id = GlobalQuizData.getNextId();
    let content = "";
    let isCorrect = "false";
    let activeClass = "";

    // If there is already an existing question we're pulling from, grab its data
    if (existingOption !== null) {
        content = existingOption['content'];
        isCorrect = existingOption['is_correct'];

        if (isCorrect === true) {
            activeClass = "active";
        }
    }

    // Insert new essay question to the HTML DOM
    let tabIndex = GlobalQuizData.getNextTabIndex(optCanvasId);
    optCanvas.insertAdjacentHTML("beforeend",
        multipleChoiceOptionTemplate.format(
            id,
            optCanvasId,
            content,
            activeClass,
            isCorrect,
            tabIndex
        )
    );

    // Save option
    let domElement = document.getElementById("mcOption{0}".format(id));
    let mcOption = new MultipleChoiceOption(id, content, isCorrect, domElement);

    // Add the essay question to the quiz instance
    GlobalQuizData.quiz.findQuestionById(optCanvasId).addOption(mcOption);
}

/*
    Function:       deleteQuestion

    Description:    Deletes any type of question from the HTML DOM, and the global bookkeeping arrays. Will also update
                    question counts

    Parameters:

        questionID       - (Required) HTML/Question ID (they're the same here) that we will delete

    Returns:        None
 */
function deleteQuestion(questionID) {
    // Find the question
    let question = document.getElementById(questionID);

    // Remove question from HTML
    GlobalQuizData.questionCanvas.removeChild(question);

    // Remove question from our records
    GlobalQuizData.quiz.deleteQuestionById(questionID);
}

/*
    Function:       deleteMCOption

    Description:    Deletes an option from a multiple choice question

    Parameters:

        canvasID    - (Required) HTML ID of the containing div where all options live
        optionID    - (Required) HTML/Option ID (they're the same here) that we will delete

    Returns:        None
 */
function deleteMCOption(canvasID, optionID) {
    // Find the option
    let option = document.getElementById("mcOption{0}".format(optionID));
    let canvas = document.getElementById(canvasID);

    // Remove option from HTML
    canvas.removeChild(option);

    // Remove option from bookkeeping
    question = GlobalQuizData.quiz.findQuestionById(canvasID);
    question.deleteOptionById(optionID);
}

/*
    Function:       isCorrectToggle

    Description:    Toggles the css and input value for the is_correct field on an MC option

    Parameters:

        element - This is the button element that will be changed

    Returns:        None
 */
function isCorrectToggle(element) {
    let checkbox = element.querySelector("#id_is_correct");
    if (element.classList.contains('active')) {
        element.classList.remove('active');
        checkbox.value = "false";
    } else {
        element.classList.add('active');
        checkbox.value = "true";
    }
}

/**********************************************************************************************************************/
/*                                                                                                                    */
/*                                             Submit Quiz Section                                                    */
/*                                                                                                                    */
/**********************************************************************************************************************/

/*
    Function:       insertError

    Description:    Inserts an error message into the HTML when processing quiz submit

    Parameters:

        id      - (Required) The ID that owns the error message (like a quiz, question, or option)
        code    - (Required) The error code
        clean   - (Required) Boolean indicating whether or not we should wipe the element prior to adding the msg

    Returns:        None
 */

function insertError(id, code) {
    let item = "<p class='form-error-msg'>" + QuizErrorEnum.properties[code].message + "</p>";

    let element = null;

    switch (code) {
        case QuizErrorEnum.NO_TITLE:
            element = document.getElementById('titleErrorCanvas');
            break;
        default:
            element = document.getElementById('question{0}'.format(id)).querySelector(".form-error-msg");
            break;
    }

    element.insertAdjacentHTML("beforeend", item);
}

/*
    Function:       clearErrors

    Description:    Clears the last (and only) error message displayed on the page

    Returns:        None
 */
function clearErrors() {
    document.getElementById('titleErrorCanvas').innerHTML = "";

    if (GlobalQuizData.lastErrorId >= 0) {
        document.getElementById('question{0}'.format(GlobalQuizData.lastErrorId)).querySelector(".form-error-msg").innerHTML = "";
    }
}

function buildQuizJSON() {

    clearErrors();

    let results = GlobalQuizData.quiz.toJSON();

    if (results.error !== QuizErrorEnum.SUCCESS) {
        GlobalQuizData.lastErrorId = results.id;
        insertError(results.id, results.error);
        return false
    }

    document.getElementById('json_quiz').value = JSON.stringify(results.json);

    return true;
}


/**********************************************************************************************************************/
/*                                                                                                                    */
/*                                               Modal Section                                                        */
/*                                                                                                                    */
/**********************************************************************************************************************/
function initialize() {
    GlobalQuizData.questionCanvas = document.getElementById('question-canvas');
    GlobalQuizData.quiz.domElement = document.getElementById('quizTitle');

    getvars = parseGET();

    quizId = getvars['quiz_id'];

    if (quizId) {
        getExistingQuiz(quizId);
    }
}

function addNewOrExistingQuestions() {
    let numChecked = 0;
    let checkboxes = document.getElementById('existingQuestionsResults').getElementsByTagName('input');

    for (let i = 0; i < checkboxes.length; i++) {
        if (checkboxes[i].checked === true) {

            checkboxes[i].checked = false;  // cleanup, set it false for next time around

            numChecked++;

            let addQuestionFunc = QuestionTypeEnum.properties[GlobalQuizData.existingResults[i].type].addFunction;

            addQuestionFunc(GlobalQuizData.existingResults[i]);
        }
    }

    // If numChecked is non-zero, it means question have already been added and we can return
    if (numChecked !== 0) {
        return numChecked;
    }

    // If we're here, we have no existing questions to add and look through the blank questions radio buttons
    let blankOption = $('input[name=blank-question-opt]:checked', '#blank-question-form').val();

    QuestionTypeEnum.properties[blankOption].addFunction();
}

/*
This is executed whenever the "existing questions" canvas is focused and marks the "blank questions" as None/empty
 */
function refreshBlankQuestionRadio() {
    $('input[name=blank-question-opt][value=\'None\']').prop("checked",true);
}

// HTML template for a dynamically-added "existing question" result
let resultsRowTemplate =
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
let optionsResultsRowTemplate =
    "<div class='row q-option {1}'>{0}</div>";

/*
Calls the webAPI to access the database, searching for existing questions. Takes information from a search bar
and from a question-type dropdown menu

Returns: a function that does everything described
 */

function getExistingQuiz(quizId) {
    let baseUrl = window.location.origin + window.location.pathname + "getquiz?quiz_id=" + quizId;

    $.getJSON(baseUrl, null, function (data) {
        // It always returns an array, even though we know there will only be one quiz returned
        quiz = data[0];

        // Add the title
        document.getElementById('quizTitle').value = quiz['title'];

        // Add each question
        for (let i = 0; i < quiz['question_set'].length; i++) {
            let question = quiz['question_set'][i];

            let addQuestionFunc = QuestionTypeEnum.properties[question.type].addFunction;
            addQuestionFunc(question);
        }

        GlobalQuizData.quiz.id = quizId;
    });
}

function getExistingQuestionQueryset() {
    return function () {
        let baseUrl = window.location.origin + window.location.pathname + "getquiz";
        let typeElem = document.getElementById('dropdownMenuButton');               // the question type dropdown
        let searchElem = document.getElementById("searchExistingQuestion");         // the search bar
        let resultsCanvas = document.getElementById("existingQuestionsResults");    // where the results will be displayed
        let typeURL = "";

        resultsCanvas.innerHTML = "";

        if (searchElem.value === "") {
            return;
        }

        if (typeElem.innerHTML !== "Any") {
            let type = QuestionTypeEnum.properties[typeElem.innerHTML].value;
            typeURL = "&type={0}".format(type);
        }

        // construct full web API URI
         baseUrl += "?content=" + searchElem.value + typeURL;

        // execute the web API call and handle data accordingly
        $.getJSON(baseUrl, null, function (data) {

            // add results to global quiz namespace
            GlobalQuizData.existingResults = data;

            // loop through all results, append them to their canvases accordingly
            for (let i = 0; i < data.length; i++) {
                resultsCanvas.insertAdjacentHTML("beforeend", resultsRowTemplate.format(
                    QuestionTypeEnum.properties[data[i]['type']].code,
                    data[i]['content'],
                    i
                ));

                let canvasId = "optionsCanvas{0}".format(i);
                let optionsCanvas = document.getElementById(canvasId);

                // loop through all of the options (multiple choice questions)
                for (let j = 0; j < data[i]['multiplechoiceoption_set'].length; j++) {

                    let isCorrectClass = "";
                    if (data[i]['multiplechoiceoption_set'][j]['is_correct'] === true) {
                        isCorrectClass = "is-correct";
                    }

                    optionsCanvas.insertAdjacentHTML("beforeend", optionsResultsRowTemplate.format(
                        data[i]['multiplechoiceoption_set'][j]['content'],
                        isCorrectClass
                    ));
                }
            }
        });
    };
}