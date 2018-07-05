// Enumeration for attendance statuses
let StatusEnum = {"total":0, "present":1, "absent":2, "excused":3, "toggle":4};
Object.freeze(StatusEnum);

function sendStatusChange(originalStatus) {
    let updatedStatus = $('input[name=options1]:checked').val();

    if (updatedStatus === originalStatus) {
        return;
    }

    let url = window.location.origin + window.location.pathname + "studentstatus";

    $.ajax({
        type: "POST",
        url: url,

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