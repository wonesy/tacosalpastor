const programs = {
    NONE: 0,
    ME: 1,
    MSc: 2,
    FGITM: 3,
    EXCHANGE: 4
};

function getRandomColorHex() {
    const hex = "0123456789ABCDEF";
    let color = "#";
    for (let i = 1; i <= 6; i++) {
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

function populateDropdowns() {
    const programBtn = document.getElementById('programBtn');
    const specializationBtn = document.getElementById('specializationBtn');
    const courseBtn = document.getElementById('courseBtn');
    for (let i = 0; i < chart_data['attendance'].length; i++) {

        // Only add programs that have a value for present/absent/excused
        if ((chart_data['attendance'][i]['present'] !== 0)
            || (chart_data['attendance'][i]['absent'] !== 0)
            || (chart_data['attendance'][i]['excused'] !== 0)) {
            programBtn.innerHTML += '<a class="dropdown-item" href="#">' + chart_data['attendance'][i]['program'] + '</a>';
        }
    }
    for (let i = 1; i < chart_data['specialization'].length; i++) {
        specializationBtn.innerHTML += '<a class="dropdown-item" href="#">' + chart_data['specialization'][i] + '</a>';

    }
    for (let i = 0; i < chart_data['course'].length; i++)
        courseBtn.innerHTML += '<a class="dropdown-item" href="#">' + chart_data['course'][i] + '</a>';
}

window.onload = function () {
    populateDropdowns();
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

function createChart(location, type, labels, title, data, colors) {
    console.log(data);
    new Chart(location, {
        type: type, // bar, horizontal bar, pie, line, doughnut, radar, polarArea
        data: {
            labels: labels,
            datasets: [{
                // label: 'Insert Label Here',
                data: data,
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