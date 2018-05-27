// Global array that keeps track of all students for this schedule
let allStudents = [];

// Enumeration for attendance statuses
let StatusEnum = {"present":1, "absent":2, "excused":3};
Object.freeze(StatusEnum);

/*
StudentAttendance

This class is an instance of a student and their associated attendance status for the given schedule
 */
class StudentAttendance {

    /*
    Default constructor

    Params:
        id      - (Int) student id
        name    - (String) student's full name
        status  - (Int) student's attendance status value (e.g. present, absent, excused)
        image   - (String) path to student's image
     */
    constructor(id, name, status, image) {
        this.id = id;
        this.name = name;
        this.status = status;
        this.statusOverride = null;

        if (image === "") {
            image = "/static/image/portraits/generic_avatar.jpg";
        }

        this.image = image;
    }

    /*
    Based on the current integer status of the student, this will return the corresponding string
     */
    getStatusString() {
        switch (this.status) {
            case StatusEnum.present:
                return "Present";
            case StatusEnum.absent:
                return "Absent";
            case StatusEnum.excused:
                return "Excused";
            default:
                return "Unknown Status";
        }
    }

    /*
    Static class function that takes in a status and returns the corresponding DOM element that will house their
    information on the webpage.

    Ex: A student is 'present' and therefore will be organized in the 'present' div. This function returns this 'present'
    div

    Params:
        status - Integer corresponding to an attendance status (e.g. present, absent, excused)
     */
    static getContainer(status) {
        switch (status) {
            case StatusEnum.present:
                return document.getElementsByClassName('present-container')[0];
            case StatusEnum.absent:
                return document.getElementsByClassName('absent-container')[0];
            case StatusEnum.excused:
                return document.getElementsByClassName('excused-container')[0];
            default:
                return null;
        }
    }

    static getHTMLTemplate(status) {
        switch (status) {
            case StatusEnum.present:
                return studentStatusPresentTemplate;
            case StatusEnum.absent:
                return studentStatusAbsentTemplate;
            case StatusEnum.excused:
                return studentStatusExcusedTemplate;
            default:
                return null;
        }
    }
}

function findStudentById(student_id) {
    for (let i = 0; i < allStudents.length; i++) {
        if (allStudents[i].id === student_id) {
            return allStudents[i];
        }
    }

    return null;
}

/*
This function is only called once when the global array of students is recognized as being empty

It will take the returned json student data and allocate new instances of each student in the array

Params:
    data - JSON results from the ajax call representing student attendance data
 */
function populateStudentArray(data) {
    for (let i = 0; i < data.length; i++) {
        student = new StudentAttendance(data[i].student_id, data[i].name, data[i].status, data[i].image);
        allStudents.push(student);
        reorganizeStudent(student, -1);
    }
}

/*
This function is called for each student when the attendance information refreshes in order to determine if changes have
been made. If a change has been observed, another function (reorganizeStudent) will be called to take action.

Params:
    student - StudentAttendance class instance
 */
function processStudentStatus(student) {
    let existingStudent = findStudentById(student['student_id']);

    if (existingStudent === null) {
        console.log("Processing student status, invalid student id {0}".format(student['student_id']));
        return;
    }

    // Determine if any changes need to be made for this student
    if (existingStudent.status !== student['status']) {
        let oldStatus = existingStudent.status;
        existingStudent.status = student['status'];
        reorganizeStudent(existingStudent, oldStatus);
    }
}

// Template to display a student' information
// let studentStatusTemplate =
//     "<div id='{0}' class='row student-status'>{1}:{2}</div>";


let studentStatusPresentTemplate =
    "<div id=\"{0}\" class=\"col-lg-2 col-md-6 col-sm-12 status-card\">" +
        "<div class=\"card text-white mb-3\" >" +
            "<div class=\"card-header bg-success\">{1}</div>" +
            "<div class=\"card-body\">" +
                "<img src='{3}'>" +
                "<p class=\"card-text\">{2}</p>" +
            "</div>" +
            "<div class=\"card-footer\">" +
                "<div class=\"btn-group btn-group-toggle\" data-toggle=\"buttons\">" +
                    "<label class=\"btn btn-present active\">" +
                        "<input type=\"radio\" name=\"options{0}\" id=\"option1\" autocomplete=\"off\"" +
                            " onchange='markForStatusChange({0}, StatusEnum.present);' checked> Present" +
                    "</label>" +
                    "<label class=\"btn btn-absent\">" +
                        "<input type=\"radio\" name=\"options{0}\" id=\"option2\" autocomplete=\"off\"" +
                            " onchange='markForStatusChange({0}, StatusEnum.absent);'> Absent" +
                    "</label>" +
                "</div>" +
            "</div>" +
        "</div>" +
    "</div>";

let studentStatusAbsentTemplate =
    "<div id=\"{0}\" class=\"col-lg-2 col-md-6 col-sm-12 status-card\">" +
        "<div class=\"card text-white mb-3\" >" +
            "<div class=\"card-header bg-danger\">{1}</div>" +
            "<div class=\"card-body\">" +
                "<img src='{3}'>" +
                "<p class=\"card-text\">{2}</p>" +
            "</div>" +
            "<div class=\"card-footer\">" +
                "<div class=\"btn-group btn-group-toggle\" data-toggle=\"buttons\">" +
                    "<label class=\"btn btn-present\">" +
                        "<input type=\"radio\" name=\"options{0}\" id=\"option1\" autocomplete=\"off\"" +
                            " onchange='markForStatusChange({0}, StatusEnum.present);'> Present" +
                    "</label>" +
                    "<label class=\"btn btn-absent active\">" +
                        "<input type=\"radio\" name=\"options{0}\" id=\"option2\" autocomplete=\"off\"" +
                            " onchange='markForStatusChange({0}, StatusEnum.absent);' checked> Absent" +
                    "</label>" +
                "</div>" +
            "</div>" +
        "</div>" +
    "</div>";

let studentStatusExcusedTemplate =
    "<div id=\"{0}\" class=\"col-lg-2 col-md-6 col-sm-12 status-card\">" +
        "<div class=\"card text-white mb-3\" >" +
            "<div class=\"card-header bg-warning\">{1}</div>" +
            "<div class=\"card-body\">" +
                "<img src='{3}'>" +
                "<p class=\"card-text\">{2}</p>" +
            "</div>" +
            "<div class=\"card-footer\">" +
                "<div class=\"btn-group btn-group-toggle\" data-toggle=\"buttons\">" +
                    "<label class=\"btn btn-present\">" +
                        "<input type=\"radio\" name=\"options{0}\" id=\"option1\" autocomplete=\"off\"" +
                            " onchange='markForStatusChange({0}, StatusEnum.present);'> Present" +
                    "</label>" +
                    "<label class=\"btn btn-absent\">" +
                        "<input type=\"radio\" name=\"options{0}\" id=\"option2\" autocomplete=\"off\"" +
                            " onchange='markForStatusChange({0}, StatusEnum.absent);'> Absent" +
                    "</label>" +
                "</div>" +
            "</div>" +
        "</div>" +
    "</div>";

/*
This function will mark the statusOverride field for the student, indicating that the professor has manually
changed the status of their attendance

Params:
    student_id  - Integer of the student ID
    status      - Integer of the status that the professor has manually changed to
 */
function markForStatusChange(student_id, status) {
    student = findStudentById(student_id);
    if (student === null) {
        console.log("Could not find student with id {0}, will not mark for change".format(student_id));
        return;
    }

    console.log("Marking change on student[" + student_id + "]: " + student.status + "--> " + status);

    student.statusOverride = status;
}

function dispatchStatusChangesToDatabase() {
    changedStudents = [];

    allStudents.forEach(function(student) {
        if (student.statusOverride === null) {
            return;
        }

        if (student.status !== student.statusOverride) {
            tmp = new StudentAttendance(student.id, student.name, student.status, student.image);
            tmp.status = student.statusOverride;
            tmp.statusOverride = null;
            changedStudents.push(tmp);
        }
    });

    // Return early if the array of changed students is empty
    if (changedStudents.length === 0) {
        return;
    }

    let baseUrl = window.location.origin + window.location.pathname + "manualoverride";

    $.ajax({
        type: "POST",
        url: baseUrl,

        data: {
            schedule_id: parseGET()['schedule_id'],
            students: JSON.stringify(changedStudents)
        },

        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function(data) {
            console.log("success");
            for (let i = 0; i < data.length; i++) {
                    processStudentStatus(data[i]);
            }
        },
        failure: function(errMsg) {
            console.log(errMsg);
        }
    });
}

/*
This will only be called in the event that a change is detected in the student's status

Actions taken:
    1) delete student information from the previous DOM element
    2) add updated student information to the new, appropriate DOM element

Params:
    student     - StudentAttendance class instance for a student
    oldStatus   - Integer value of their previous, out-of-date status
 */
function reorganizeStudent(student, oldStatus) {
    let oldContainer = StudentAttendance.getContainer(oldStatus);
    let newContainer = StudentAttendance.getContainer(student.status);

    if (oldContainer !== null) {
        oldContainer.removeChild(document.getElementById(student.id));
    }

    let template = StudentAttendance.getHTMLTemplate(student.status);

    newContainer.insertAdjacentHTML("beforeend", template.format(
        student.id,
        student.name,
        student.getStatusString(),
        student.image)
    );
}

/*
Function called regularly in order to keep attendance information up-to-date.

Talks with the backend in order to receive latest JSON-formatted attendance data and pushes it forward for processing
 */
function getAttendanceData() {
    return function() {
        let baseUrl = window.location.origin + window.location.pathname + "update";

        let _GET = parseGET();

        // construct full web API URI
        let fullAPIURL = baseUrl + "?schedule_id=" + _GET['schedule_id'];

        console.log(fullAPIURL);

        // execute the web API call and handle data accordingly
        $.getJSON(fullAPIURL, null, function (data) {
            // Fill up entire array first, if length is zero
            if (allStudents.length === 0) {
                populateStudentArray(data);
            } else {
                for (let i = 0; i < data.length; i++) {
                    processStudentStatus(data[i]);
                }
            }
        });
    };
}
