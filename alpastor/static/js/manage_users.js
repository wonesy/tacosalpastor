let GlobalPotentialUsers = [];

class User {
    constructor(firstName, lastName, emailLogin, isProfessor) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.emailLogin = emailLogin;
        this.isProfessor = isProfessor;
        this.externalEmail = "";
        this.phone = "";
        this.pic = "";
    }
}

class Professor extends User {
    constructor(firstName, lastName, emailLogin) {
        super(firstName, lastName, emailLogin, true);
    }
}

class Student extends User {
    constructor(firstName, lastName, emailLogin) {
        super(firstName, lastName, emailLogin, false);
        this.program = "";
        this.specialization = "";
        this.intakeSemester = "";
        this.country = "";
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

function savePotentialUsers() {
    $.ajax({
        type: "POST",
        url: window.location.origin + window.location.pathname + "savenewusers/",
        data: {
            users: JSON.stringify(GlobalPotentialUsers),
        },
        contentType: "application/json; charset=utf-8",
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
    $("#actions-card-body").toggleClass("show");

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
        "<th>Intake Semester</th>" +
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
            u.pic,
            (u.isProfessor) ? "n/a" : u.program,
            (u.isProfessor) ? "n/a" : u.specialization,
            (u.isProfessor) ? "n/a" : u.intakeSemester,
            (u.isProfessor) ? "n/a" : u.country
        ));
    }

    $("#verify-modal").modal();
}

function processUserCSVFile(csvFileElem) {

    let data = new FormData();
    data.append('file', csvFileElem.files[0]);

    // Collect override information

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
    let pic = document.getElementById('pic');

    // Validate form
    if (!firstName.checkValidity()) {
        errorElem.innerHTML = "Fill out first name";
        return false;
    }

    if (!emailLogin.checkValidity()) {
        errorElem.innerHTML = "Fill out last name";
        return false;
    }

    if (!firstName.checkValidity()) {
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
        newUser.pic = pic.files;
        newUser.externalEmail = externalEmail.value;
    } else {
        // Save a potential student
        newUser = new Student(firstName.value, lastName.value, emailLogin.value);
        newUser.phone = phone.value;
        newUser.pic = pic.files;
        newUser.externalEmail = externalEmail.value;

        let programElem = document.getElementById("program");
        let specializationElem = document.getElementById("specialization");
        let country = document.getElementById("country");
        let intakeSemester = document.getElementById('intake-semester');

        // Validate additional student data
        if (!programElem.checkValidity()) {
            errorElem.innerHTML = "Fill out student program";
            return false;
        }

        if (!specializationElem.checkValidity()) {
            errorElem.innerHTML = "Fill out student specialization";
            return false;
        }

        if (!intakeSemester.checkValidity()) {
            errorElem.innerHTML = "Intake semester must have the form Season Year (Fall 2016, Spring 2017)";
            return false;
        }

        let program = programElem.options[programElem.selectedIndex].value;
        let specialization = specializationElem.options[specializationElem.selectedIndex].value;

        newUser.program = program;
        newUser.specialization = specialization;
        newUser.country = country.value;
    }

    GlobalPotentialUsers.push(newUser);

    populateModalUserPreview();

    return true;
}