const programs = {
    NONE: 0,
    ME: 1,
    MSc: 2,
    FGITM: 3,
    EXCHANGE: 4
};

function getRandomColorHex() {
    var hex = "0123456789ABCDEF",
        color = "#";
    for (var i = 1; i <= 6; i++) {
        color += hex[Math.floor(Math.random() * 16)];
    }
    return color;
}

function getAttendance(present, absent, excused, list, program) {
    list.push(present);
    list.push(absent);
    list.push(excused);
    title = program;
}


window.onload = function () {
    console.log(chart_data);
    defaultChart();
};

function defaultChart() {
    let attendanceList = chart_data['attendance'];
    let labels = ['present', 'absent', 'excused'];
    let titles = [];
    let noneAttendance = [];
    let meAttendance = [];
    let mscAttendance = [];
    let fgitmAttendance = [];
    let exchangeAttendance = [];

    attendanceList.forEach(function (i) {
        titles.push(i['program']);
        if (i['program'] === "None")
            getAttendance(i['present'], i['absent'], i['excused'], noneAttendance);

        if (i['program'] === "Master of Engineering")
            getAttendance(i['present'], i['absent'], i['excused'], meAttendance);

        if (i['program'] === "Master of Science")
            getAttendance(i['present'], i['absent'], i['excused'], mscAttendance);

        if (i['program'] === "Global IT Management (French)")
            getAttendance(i['present'], i['absent'], i['excused'], fgitmAttendance);

        if (i['program'] === "Exchange")
            getAttendance(i['present'], i['absent'], i['excused'], exchangeAttendance);
    });

    colors = [];
    mscAttendance.forEach(function () {
        colors.push(getRandomColorHex());
    });

    // MSC Chart
    let mscChart = document.getElementById('mscChart').getContext('2d');
    createChart(mscChart, 'pie', labels, titles[programs['MSc']], mscAttendance, colors);

    // ME Chart
    let meChart = document.getElementById('meChart').getContext('2d');
    createChart(meChart, 'pie', labels, titles[programs['ME']], meAttendance, colors);

    // Exchange
    let exchangeChart = document.getElementById('exchangeChart').getContext('2d');
    createChart(exchangeChart, 'pie', labels, titles[programs['EXCHANGE']], exchangeAttendance, colors);
}

function emptyDataCheck(data) {
    let noValues = 0;
    for (let i = 0; i < data.length; i++)
        noValues += data[i];
    return (noValues === 0) ? [1, 0, 0] : data;
}

function createChart(location, type, labels, title, data, colors) {
    console.log(data);
    new Chart(location, {
        type: type, // bar, horizontal bar, pie, line, doughnut, radar, polarArea
        data: {
            labels: labels,
            datasets: [{
                // label: 'Insert Label Here',
                data: emptyDataCheck(data),
                backgroundColor: colors,
                borderWidth: 4,
                borderColor: 'grey'
            }]
        },
        options: {
            title: {
                display: true,
                text: title
            },
            legend: {
                position: 'right'
            }
        }
    });
}