let StatusEnum = {"total":0, "present":1, "absent":2, "excused":3, "toggle":4};

function markForStatusChange(status) {
    console.log(status);
    createHTML(status);
}

function createHTML(status) {
    console.log(document.createElement('input'));
    // document.getElementById('option1').innerText
}