// Global array that keeps track of all students for this schedule
let allStudents = [];

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
        this.image = image;
    }

    /*
    Based on the current integer status of the student, this will return the corresponding string
     */
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

/*
This function is only called once when the global array of students is recognized as being empty

It will take the returned json student data and allocate new instances of each student in the array

Params:
    data - JSON results from the ajax call representing student attendance data
 */
function populateStudentArray(data) {
    for (let i = 0; i < data.length; i++) {
        console.log("Populate: " + data[i].name);
        student = new StudentAttendance(data[i].student_id, data[i].name, data[i].status, null /* image */);
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

// Template to display a student' information
let studentStatusTemplate =
    "<div id='{0}' class='row student-status'>{1}:{2}</div>";

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

    newContainer.insertAdjacentHTML("beforeend", studentStatusTemplate.format(student.id, student.name, student.getStatusString()));
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
