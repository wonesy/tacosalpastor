function showTime() {
    var time = new Date();
    var hr = time.getHours().toString();
    var min = time.getMinutes().toString();
    var sec = time.getSeconds().toString();

    if (hr.length < 2) {
        hr = "0" + hr;
    }

    if (min.length < 2) {
        min = "0" + min;
    }

    if (sec.length < 2) {
        sec = "0" + sec;
    }

    var clock = document.getElementById("clock");
    clock.textContent = hr + " : " + min + " : " + sec;
}

setInterval(showTime, 1000);
