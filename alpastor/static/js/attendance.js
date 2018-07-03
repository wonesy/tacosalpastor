// Global array that keeps track of all students for this schedule
let allStudents = [];

// Enumeration for attendance statuses
let StatusEnum = {"total":0, "present":1, "absent":2, "excused":3, "toggle":4};
Object.freeze(StatusEnum);

let ViewEnum = {"portraits": 0, "names": 1};
Object.freeze(ViewEnum);

let GlobalView = ViewEnum.portraits;

function clearAttendanceContainers() {
    document.getElementsByClassName('present-container')[0].innerHTML = "";
    document.getElementsByClassName('absent-container')[0].innerHTML = "";
    document.getElementsByClassName('excused-container')[0].innerHTML = "";
}

function changeView(newView) {
    // Do nothing if the view change is the same... should never arrive here
    if (GlobalView === newView) {
        return;
    }

    GlobalView = newView;
    clearAttendanceContainers();

    getAttendanceData()();

    for (let i = 0; i < allStudents.length; i++) {
        reorganizeStudent(allStudents[i], -1);
    }
}

/*
Keep track of counts

counts[0] = total
counts[1] = present
counts[2] = absent
counts[3] = excused

 */

let counts = [0, 0, 0, 0];

function updateCount(oldStatus, newStatus) {
    // If there was no oldStatus, then that means we're adding a brand new item to the list
    if (oldStatus === null) {
        counts[StatusEnum.total]++;
    } else {
        counts[oldStatus]--;
    }

    counts[newStatus]++;

    redrawProgressBar();
}

let statisticsTemplate =
    "<p class='attendance-stats {0}'>{1}: {2}</p>";

function redrawProgressBar() {

    presentPct = (counts[StatusEnum.present] / counts[StatusEnum.total])*100;
    excusedPct = (counts[StatusEnum.excused] / counts[StatusEnum.total])*100;
    absentPct = (counts[StatusEnum.absent] / counts[StatusEnum.total])*100;

    difference = (100 - presentPct - excusedPct - absentPct);

    // Add the difference to the largest percentage to keep everything happy
    if (presentPct > absentPct) {
        presentPct += difference;
    } else {
        absentPct += difference;
    }

    // Update "present" progress bar and stats
    $("#progress-present")
        .attr('aria-valuenow', counts[StatusEnum.present])
        .attr('aria-valuemax', counts[StatusEnum.total])
        .css('width', presentPct+'%');

    $("#stats-present").html(statisticsTemplate.format("present-stats", "Present", counts[StatusEnum.present]));

    // Update "excused" progress bar and stats
    $("#progress-excused")
        .attr('aria-valuenow', counts[StatusEnum.excused])
        .attr('aria-valuemax', counts[StatusEnum.total])
        .css('width', excusedPct+'%');

    $("#stats-excused").html(statisticsTemplate.format("excused-stats", "Excused", counts[StatusEnum.excused]));

    // Update "absent" progress bar and stats
    $("#progress-absent")
        .attr('aria-valuenow', counts[StatusEnum.absent])
        .attr('aria-valuemax', counts[StatusEnum.total])
        .css('width', absentPct+'%');

    $("#stats-absent").html(statisticsTemplate.format("absent-stats", "Absent", counts[StatusEnum.absent]));

    // Update total stats
    $("#stats-total").html(statisticsTemplate.format("total-stats", "Total", counts[StatusEnum.total]));
}

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

        if (image === "" || image === null) {
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
                return (GlobalView === ViewEnum.portraits) ? studentStatusPresentTemplateCard : studentStatusPresentTemplateThumbnail;
            case StatusEnum.absent:
                return (GlobalView === ViewEnum.portraits) ? studentStatusAbsentTemplateCard : studentStatusAbsentTemplateThumbnail;
            case StatusEnum.excused:
                return (GlobalView === ViewEnum.portraits) ? studentStatusExcusedTemplateCard : studentStatusExcusedTemplateThumbnail;
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
        updateCount(null, student.status);
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
        updateCount(oldStatus, existingStudent.status);
        reorganizeStudent(existingStudent, oldStatus);
    }
}

/*
    The card/portrait view templates for the students
 */
let studentStatusPresentTemplateCard =
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

let studentStatusAbsentTemplateCard =
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

let studentStatusExcusedTemplateCard =
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
    The thumbnail view for the templates
 */

let studentStatusPresentTemplateThumbnail =
    "<div id='{0}' class=\"col-1 button-thumbnail btn-group-toggle\" data-toggle=\"buttons\">" +
        "<label class=\"btn btn-success name-present-thumbnail\">" +
            "<input type=\"checkbox\" checked autocomplete=\"off\" onchange='markForStatusChange({0}, StatusEnum.toggle);'> {1}" +
        "</label>" +
        "<label class='status-thumbnail white-text'>{2}</label>" +
    "</div>";

let studentStatusExcusedTemplateThumbnail =
    "<div id='{0}' class=\"col-1 button-thumbnail btn-group-toggle\" data-toggle=\"buttons\">" +
        "<label class=\"btn btn-warning name-excused-thumbnail\">" +
            "<input type=\"checkbox\" checked autocomplete=\"off\" onchange='markForStatusChange({0}, StatusEnum.toggle);'> {1}" +
        "</label>" +
        "<label class='status-thumbnail white-text'>{2}</label>" +
    "</div>";

let studentStatusAbsentTemplateThumbnail =
    "<div id='{0}' class=\"col-1 button-thumbnail btn-group-toggle\" data-toggle=\"buttons\">" +
        "<label class=\"btn btn-danger name-absent-thumbnail\">" +
            "<input type=\"checkbox\" checked autocomplete=\"off\" onchange='markForStatusChange({0}, StatusEnum.toggle);'> {1}" +
        "</label>" +
        "<label class='status-thumbnail white-text'>{2}</label>" +
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

    // Toggle the status between present/absent
    if (status === StatusEnum.toggle) {

        // Fixing a bug unforeseen before toggle feature where override isn't established before getting here
        if (student.statusOverride === null) {
            student.statusOverride = student.status;
        }

        if (student.statusOverride === StatusEnum.present) {
            student.statusOverride = StatusEnum.absent;
        } else if (student.statusOverride === StatusEnum.absent) {
            student.statusOverride = StatusEnum.present;
        }
    } else {
        student.statusOverride = status;
    }

    console.log("Changing status on student[" + student_id + "]: " + student.status + "--> " + student.statusOverride);
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

    /*
        Fixes a cosmetic bug where changing views with a pending status override would keep the pending change, but
        it wouldn't be accounted for visually in the view switch.

        This will remove the pending change, so a "Submit all changes" will not affect that student any longer
     */
    if (oldStatus === -1) {
        student.statusOverride = student.status;
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
