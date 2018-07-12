let date = new Date();
const year = date.getFullYear();
const season = 3;

let globalChartData = {
    'year': year,
    'season': season,
    'program': null,
    'specialization': null,
    'course': null,
    'student': null,
};

function setYearQuery(year) {
    globalChartData['year'] = year;
}

function setSeasonQuery(season) {
    globalChartData['season'] = season;
}

function setProgramQuery(program) {
    globalChartData['program'] = program;
}

function setSpecializationQuery(specialization) {
    globalChartData['specialization'] = specialization;
}

function setCourseQuery(course) {
    globalChartData['course'] = course;
}

function setStudentQuery(student) {
    globalChartData['student'] = student;
}

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
    const seasonBtn = document.getElementById('seasonBtn');
    const yearBtn = document.getElementById('yearBtn');
    const studentBtn = document.getElementById('studentBtn');
    let d = new Date();
    const year = d.getFullYear();
    for (let i = year - 5; i < year; i++) {
        yearBtn.innerHTML += '<a class="dropdown-item" onclick="setYearQuery(i)" href="#">' + i + '</a>';
    }
    seasonBtn.innerHTML += '<a class="dropdown-item" href="#">Spring</a>';
    seasonBtn.innerHTML += '<a class="dropdown-item" href="#">Fall</a>';


    for (let i = 0; i < chart_data['attendance'].length; i++) {
        // Only add programs that have a value for present/absent/excused
        if ((chart_data['attendance'][i]['present'] !== 0)
            || (chart_data['attendance'][i]['absent'] !== 0)
            || (chart_data['attendance'][i]['excused'] !== 0)) {
            program_name = chart_data['attendance'][i]['program'];
            programBtn.innerHTML += '<a class="dropdown-item" href="#">' + program_name + '</a>';
        }
    }

    for (let i = 0; i < programBtn.children.length; i++) {
        aTag = programBtn.children[i].addEventListener('click', function (e) {
            setProgramQuery(e.srcElement.innerHTML);
            feedMeData();
        });
    }

    for (let i = 1; i < chart_data['specialization'].length; i++) {
        specialization_name = chart_data['specialization'][i];
        specializationBtn.innerHTML += '<a class="dropdown-item" href="#">' + specialization_name + '</a>';
    }

    for (let i = 0; i < specializationBtn.children.length; i++) {
        aTag = specializationBtn.children[i].addEventListener('click', function (e) {
            setSpecializationQuery(e.srcElement.innerHTML);
            feedMeData();
        });
    }

    for (let i = 0; i < chart_data['course'].length; i++) {
        course_name = chart_data['course'][i];
        courseBtn.innerHTML += '<a class="dropdown-item" onclick="setCourseQuery(course_name)" href="#">' + course_name + '</a>';
        courseBtn.addEventListener('click', function () {
            setProgramQuery(course_name);
            feedMeData();
        });
    }

    for (let i = 0; i < student_data['names'].length; i++) {
        studentName = student_data['names'][i];
        studentBtn.innerHTML += '<a class="dropdown-item" href="#">' + studentName + '</a>';
    }

    for (let i = 0; i < studentBtn.children.length; i++) {
        aTag = studentBtn.children[i].addEventListener('click', function (e) {
            setStudentQuery(e.srcElement.innerHTML);
            feedMeData();
        });
    }
}

function feedMeData(isTrue) {
    $.ajax({
        type: 'POST',
        url: window.href,
        data: {
            'chartData': JSON.stringify(globalChartData),
            'getNames': isTrue
        },
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        success: function (data) {
            if (isTrue) {
                console.log(data);
                console.log(data["names"]);

                let nameList = JSON.parse(data["names"]);

                for (let i = 0; i < nameList.length; i++) {
                    console.log(nameList[i]);
                }
            }

            // here
            // console.log(data);
        }
    });
}


window.onload = function () {
    feedMeData(true);
    populateDropdowns();
    console.log(student_data);
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


// function getChartData() {
//
// }

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