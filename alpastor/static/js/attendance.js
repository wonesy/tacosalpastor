let allStudents = [];

class StudentAttendance {
    constructor(id, name, status, image) {
        console.log("Created new obj");
        this.id = id;
        this.name = name;
        this.status = status;
        this.image = image;
    }

    getStatusString() {
        switch (this.status) {
            case 1:
                return "Present";
            case 2:
                return "Absent";
            case 3:
                return "Excused";
            default:
                return "Unknown Status";
        }
    }

    static getContainer(status) {
        switch (status) {
            case 1:
                return document.getElementsByClassName('present-container')[0];
            case 2:
                return document.getElementsByClassName('absent-container')[0];
            case 3:
                return document.getElementsByClassName('excused-container')[0];
            default:
                return null;
        }
    }
}

function populateStudentArray(data) {
    for (let i = 0; i < data.length; i++) {
        console.log("Populate: " + data[i].name);
        student = new StudentAttendance(data[i].student_id, data[i].name, data[i].status, null /* image */);
        allStudents.push(student);
        reorganizeStudent(student, -1);
    }
}

function processStudentStatus(student) {
    let existingStudent = null;

    // Find the matching student in the global array
    for (let i = 0; i < allStudents.length; i++) {
        if (allStudents[i].id === student['student_id']) {
            existingStudent = allStudents[i];
            break;
        }
    }

    // Determine if any changes need to be made for this student
    if (existingStudent.status !== student['status']) {
        let oldStatus = existingStudent.status;
        existingStudent.status = student['status'];
        reorganizeStudent(existingStudent, oldStatus);
    }
}

let studentStatusTemplate =
    "<div id='{0}' class='row student-status'>{1}:{2}</div>";

function reorganizeStudent(student, oldStatus) {
    console.log("Reorganizing " + student.name);
    let oldContainer = StudentAttendance.getContainer(oldStatus);
    let newContainer = StudentAttendance.getContainer(student.status);

    if (oldContainer !== null) {
        oldContainer.removeChild(document.getElementById(student.id));
    }

    newContainer.insertAdjacentHTML("beforeend", studentStatusTemplate.format(student.id, student.name, student.getStatusString()));
}

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
