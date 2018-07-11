let GlobalPotentialUsers = [];

class User {
    constructor(firstName, lastName, emailLogin, isProfessor) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.emailLogin = emailLogin;
        this.isProfessor = isProfessor;
        this.externalEmail = "";
        this.phone = "";
        this.photo = "";
    }
}

class Professor extends User {
    constructor(firstName, lastName, emailLogin) {
        super(firstName, lastName, emailLogin, true);
    }

    toDict() {
        let _dict = {};

        _dict['firstName'] = this.firstName;
        _dict['lastName'] = this.lastName;
        _dict['emailLogin'] = this.emailLogin;
        _dict['isProfessor'] = this.isProfessor;
        _dict['externalEmail'] = this.externalEmail;
        _dict['phone'] = this.phone;

        return _dict;
    }
}

class Student extends User {
    constructor(firstName, lastName, emailLogin) {
        super(firstName, lastName, emailLogin, false);
        this.program = "";
        this.specialization = "";
        this.intakeSeason = "";
        this.intakeYear = "";
        this.country = "";
    }

    toDict() {
        let _dict = {};

        _dict['firstName'] = this.firstName;
        _dict['lastName'] = this.lastName;
        _dict['emailLogin'] = this.emailLogin;
        _dict['isProfessor'] = this.isProfessor;
        _dict['externalEmail'] = this.externalEmail;
        _dict['phone'] = this.phone;
        _dict['program'] = this.program;
        _dict['specialization'] = this.specialization;
        _dict['intakeSeason'] = this.intakeSeason;
        _dict['intakeYear'] = this.intakeYear;
        _dict['country'] = this.country;

        return _dict;
    }
}

function writeActions(actions) {
    console.log(actions);
    msgTemplate = "<p>{0}</p>";
    actionsElem = document.getElementById('actions-messages');
    actionsElem.innerText = "";
    for (let i = 0; i < actions.length; i++) {
        console.log(actions[i]);
        actionsElem.insertAdjacentHTML("beforeend", msgTemplate.format(actions[i]));
    }
}

function savePotentialCourse() {

    $.ajax({
        type: "POST",
        url: window.location.origin + window.location.pathname + "savenewcourse/",
        data: $('#add-course-form').serialize(),
        contentType: "application/json; charset=utf-8",
        cache: false,
        timeout: 600000,
        success: function (data) {
            console.log("SUCCESS");
            writeActions([data.message]);
        },
        error: function (e, data) {
            console.log("ERROR : ", e);
            writeActions([e.responseJSON.message]);
        }
    });

    // Show the actions display
    $("#actions-card-body").addClass("show");
}

function savePotentialUsers() {

    let data = new FormData();

    data.append('length', GlobalPotentialUsers.length);

    for (let i = 0; i < GlobalPotentialUsers.length; i++) {
        console.log(i);
        console.log(GlobalPotentialUsers[i]);
        console.log(GlobalPotentialUsers[i].toDict());
        data.append('{0}'.format(i), JSON.stringify(GlobalPotentialUsers[i].toDict()));
        data.append('photo{0}'.format(i), GlobalPotentialUsers[i].photo)
    }

    for (let pair of data.entries()) {
        console.log(pair[0]);
        console.log(pair[1]);
    }

    $.ajax({
        type: "POST",
        url: window.location.origin + window.location.pathname + "savenewusers/",
        data: data,
        enctype: 'multipart/form-data',
        processData: false,
        contentType: false,
        cache: false,
        timeout: 600000,
        success: function (data) {
            console.log("SUCCESS");
            writeActions(data.messages);
        },
        error: function (e, data) {
            console.log("ERROR : ", e);
            writeActions(e.responseJSON.messages);
        }
    });

    // Show the actions display
    $("#actions-card-body").addClass("show");

    // Remove csv file
    $('#csv-file').val("");
}

function populateModalUserPreview() {
    let tableHeading =
        "<tr>" +
        "<th>First Name</th>" +
        "<th>Last Name</th>" +
        "<th>Email</th>" +
        "<th>External Email</th>" +
        "<th>Type</th>" +
        "<th>Phone</th>" +
        "<th>Picture</th>" +
        "<th>Program</th>" +
        "<th>Specialization</th>" +
        "<th>Intake Season</th>" +
        "<th>Intake Year</th>" +
        "<th>Country</th>" +
        "</tr>";

    let tableRowTemplate =
        "<tr>" +
        "<td>{0}</td>" +
        "<td>{1}</td>" +
        "<td>{2}</td>" +
        "<td>{3}</td>" +
        "<td>{4}</td>" +
        "<td>{5}</td>" +
        "<td>{6}</td>" +
        "<td>{7}</td>" +
        "<td>{8}</td>" +
        "<td>{9}</td>" +
        "<td>{10}</td>" +
        "<td>{11}</td>" +
        "</tr>";

    let modalPreviewElem = document.getElementById('modal-preview-table');

    modalPreviewElem.innerHTML = "";

    // Insert the table header;
    modalPreviewElem.insertAdjacentHTML("beforeend", tableHeading);

    for (let i = 0; i < GlobalPotentialUsers.length; i++) {
        let u = GlobalPotentialUsers[i];
        modalPreviewElem.insertAdjacentHTML("beforeend", tableRowTemplate.format(
            u.firstName,
            u.lastName,
            u.emailLogin,
            u.externalEmail,
            (u.isProfessor) ? "Professor" : "Student",
            u.phone,
            u.photo,
            (u.isProfessor) ? "n/a" : u.program,
            (u.isProfessor) ? "n/a" : u.specialization,
            (u.isProfessor) ? "n/a" : u.intakeSeason,
            (u.isProfessor) ? "n/a" : u.intakeYear,
            (u.isProfessor) ? "n/a" : u.country
        ));
    }

    $("#verify-modal").modal();
}

function processUserCSVFile(csvFileElem) {

    let data = new FormData();
    data.append('file', csvFileElem.files[0]);

    // Collect override information
    data.append('overrideProgram', $('#override-program').val());
    data.append('overrideSpecialization', $('#override-specialization').val());
    data.append('overrideIntakeSeason', $('#override-intake-season').val());
    data.append('overrideIntakeYear', $('#override-intake-year').val());
    data.append('overrideCountry', $('#override-country').val());

    $.ajax({
        type: "POST",
        enctype: 'multipart/form-data',
        url: window.location.origin + window.location.pathname + "processusercsv/",
        data: data,
        processData: false,
        contentType: false,
        cache: false,
        timeout: 600000,
        success: function (data) {
            for (let i = 0; i < data.length; i++) {
                let student = new Student(data[i].first_name, data[i].last_name, data[i].email);
                student.program = data[i].program;
                student.country = data[i].country;
                student.specialization = data[i].specialization;
                student.intakeSeason = data[i].intakeSeason;
                student.intakeYear = data[i].intakeYear;
                GlobalPotentialUsers.push(student);
            }
            populateModalUserPreview();

        },
        error: function (e) {
            console.log("ERROR : ", e);
        }
    });
}

function collectNewUserInfo() {
    let csvFile = document.getElementById('csv-file');
    if (csvFile.files.length !== 0) {
        processUserCSVFile(csvFile);
        return;
    }

    let errorElem = document.getElementById('form-errors');
    errorElem.innerHTML = "";

    // Relevant for all new users
    let firstName = document.getElementById('first_name');
    let lastName = document.getElementById('last_name');
    let emailLogin = document.getElementById('email');
    let externalEmail = document.getElementById('external_email');
    let phone = document.getElementById('phone');
    let photo = document.getElementById('photo');

    // Validate form
    if (!firstName.checkValidity()) {
        errorElem.innerHTML = "Fill out first name";
        return false;
    }

    if (!lastName.checkValidity()) {
        errorElem.innerHTML = "Fill out last name";
        return false;
    }

    if (!emailLogin.checkValidity()) {
        errorElem.innerHTML = "Fill out login email field";
        return false;
    }

    // Type
    let type = document.getElementsByName('staff');
    let isProfessor = type[0].checked;

    let newUser = null;
    if (isProfessor) {
        // Save a potential professor
        newUser = new Professor(firstName.value, lastName.value, emailLogin.value);
        newUser.phone = phone.value;
        newUser.photo = photo.files[0];
        newUser.externalEmail = externalEmail.value;
    } else {
        // Save a potential student
        newUser = new Student(firstName.value, lastName.value, emailLogin.value);
        newUser.phone = phone.value;
        newUser.photo = photo.files[0];
        newUser.externalEmail = externalEmail.value;

        let programElem = document.getElementById("program");
        let specializationElem = document.getElementById("specialization");
        let country = document.getElementById("country");
        let intakeSeason = document.getElementById('intake-season');
        let intakeYear = document.getElementById('intake-year');

        // Validate additional student data
        if (!programElem.checkValidity()) {
            errorElem.innerHTML = "Fill out student program";
            return false;
        }

        if (!specializationElem.checkValidity()) {
            errorElem.innerHTML = "Fill out student specialization";
            return false;
        }

        if (!intakeSeason.checkValidity()) {
            errorElem.innerHTML = "Fill out intake semester season";
            return false;
        }

        if (!intakeYear.checkValidity()) {
            errorElem.innerHTML = "Fill out intake semester year";
            return false;
        }

        let program = programElem.options[programElem.selectedIndex].value;
        let specialization = specializationElem.options[specializationElem.selectedIndex].value;
        let season = intakeSeason.options[intakeSeason.selectedIndex].value;
        let year = intakeYear.value;

        newUser.program = program;
        newUser.specialization = specialization;
        newUser.country = country.value;
        newUser.intakeSeason = season;
        newUser.intakeYear = year;
    }

    GlobalPotentialUsers.push(newUser);

    populateModalUserPreview();

    return true;
}

function linkStudentCourse(url) {
    let formElements = document.getElementById("link-course-form").elements;

    let data = {};

    // Course
    data['course_id'] = formElements[0].value;

    // Program
    data['program'] = formElements[1].value;

    // Specialization
    data['specialization'] = formElements[2].value;

    // Intake season
    data['intake_season'] = formElements[3].value;

    // Intake year
    data['intake_year'] = formElements[4].value;

    console.log("here");
    $.ajax({
        type: "POST",
        url: window.location.origin + window.location.pathname + url,
        data: data,
        contentType: "application/json; charset=utf-8",
        cache: false,
        timeout: 600000,
        success: function (data) {
            console.log("SUCCESS");
            writeActions([data.messages]);
        },
        error: function (e, data) {
            console.log("ERROR : ", e);
            writeActions([e.responseJSON.messages]);
        }
    });

    // Show the actions display
    $("#actions-card-body").addClass("show");
}