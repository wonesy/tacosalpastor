let date = new Date();
const year = date.getFullYear()-1;
const season = 'Fall';

let SeasonEnum = {
    'Winter': 0,
    'Spring': 1,
    'Summer': 2,
    'Fall': 3
};

let globalChartData = {
    'year': year,
    'season': 'Fall',
    'program': null,
    'specialization': null,
    'course': null,
    'student': null,
};

function setYearQuery(year) {
    globalChartData['year'] = year;
    updateCurrentQuery();
}

function setSeasonQuery(season) {
    globalChartData['season'] = season;
    updateCurrentQuery();
}

function setProgramQuery(program) {
    globalChartData['program'] = program;
    updateCurrentQuery();
}

function setSpecializationQuery(specialization) {
    globalChartData['specialization'] = specialization;
    updateCurrentQuery();
}

function setCourseQuery(course) {
    globalChartData['course'] = course;
    updateCurrentQuery();
}

function setStudentQuery(student) {
    globalChartData['student'] = student;
    updateCurrentQuery();
}

function updateCurrentQuery() {
    let elem = document.getElementById('currentQuery');
    let string =
        "Season:<br><p>{0}</p>" +
        "Year:<br><p>{1}</p>" +
        "Program:<br><p>{2}</p>" +
        "Specialization:<br><p>{3}</p>" +
        "Course:<br><p>{4}</p>" +
        "Student:<br><p>{5}</p>";

    let x = string.format(
        globalChartData.season,
        globalChartData.year,
        globalChartData.program,
        globalChartData.specialization,
        globalChartData.course,
        globalChartData.student
    );

    elem.innerHTML = x;
}

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

function populateDropdowns(chart_data) {
    const programBtn = document.getElementById('programBtn');
    const specializationBtn = document.getElementById('specializationBtn');
    const courseBtn = document.getElementById('courseBtn');
    const seasonBtn = document.getElementById('seasonBtn');
    const yearBtn = document.getElementById('yearBtn');

    //
    // Year
    //
    for (let i = year - 5; i <= year+1; i++) {
        yearBtn.innerHTML += '<a class="dropdown-item" href="#">' + i + '</a>';
    }

    for (let i = 0; i < yearBtn.children.length; i++) {
        aTag = yearBtn.children[i].addEventListener('click', function (e) {
            setYearQuery(e.target.innerHTML);
            feedMeData(false);
        });
    }

    //
    // Season
    //
    seasonBtn.innerHTML += '<a class="dropdown-item" href="#">Winter</a>';
    seasonBtn.innerHTML += '<a class="dropdown-item" href="#">Spring</a>';
    seasonBtn.innerHTML += '<a class="dropdown-item" href="#">Summer</a>';
    seasonBtn.innerHTML += '<a class="dropdown-item" href="#">Fall</a>';

    for (let i = 0; i < seasonBtn.children.length; i++) {
        aTag = seasonBtn.children[i].addEventListener('click', function (e) {
            setSeasonQuery(e.target.innerHTML);
            feedMeData(false);
        });
    }

    //
    // Program
    //
    programBtn.innerHTML += '<a class="dropdown-item" href="#">Any</a>';
    for (let i = 0; i < chart_data['attendance'].length; i++) {
        program_name = chart_data['attendance'][i]['program'];
        programBtn.innerHTML += '<a class="dropdown-item" href="#">' + program_name + '</a>';
    }

    for (let i = 0; i < programBtn.children.length; i++) {
        aTag = programBtn.children[i].addEventListener('click', function (e) {
            setProgramQuery(e.target.innerHTML);
            feedMeData(false);
        });
    }

    //
    // Specialization
    //
    specializationBtn.innerHTML += '<a class="dropdown-item" href="#">Any</a>';
    for (let i = 1; i < chart_data['specialization'].length; i++) {
        specialization_name = chart_data['specialization'][i];
        specializationBtn.innerHTML += '<a class="dropdown-item" href="#">' + specialization_name + '</a>';
    }

    for (let i = 0; i < specializationBtn.children.length; i++) {
        aTag = specializationBtn.children[i].addEventListener('click', function (e) {
            setSpecializationQuery(e.target.innerHTML);
            feedMeData(false);
        });
    }

    //
    // Course
    //
    courseBtn.innerHTML += '<a class="dropdown-item" href="#">Any</a>';
    for (let i = 0; i < chart_data['course'].length; i++) {
        course_name = chart_data['course'][i];
        courseBtn.innerHTML += '<a class="dropdown-item" onclick="setCourseQuery(course_name)" href="#">' + course_name + '</a>';
    }

    for (let i = 0; i < courseBtn.children.length; i++) {
        aTag = courseBtn.children[i].addEventListener('click', function (e) {
            setCourseQuery(e.target.innerHTML);
            feedMeData(false);
        });
    }
}

function populateNameDropdown(student_data) {
    const studentBtn = document.getElementById('studentBtn');

    studentBtn.innerHTML += '<a class="dropdown-item" href="#">Any</a>';

    //
    // Student
    //
    for (let i = 0; i < student_data.length; i++) {
        let studentName = student_data[i];
        studentBtn.innerHTML += '<a class="dropdown-item" href="#">' + studentName + '</a>';
    }

    for (let i = 0; i < studentBtn.children.length; i++) {
        aTag = studentBtn.children[i].addEventListener('click', function (e) {
            setStudentQuery(e.target.innerHTML);
            feedMeData(false);
        });
    }
}

function feedMeData(initStudentNames) {
    $.ajax({
        type: 'POST',
        url: window.href,
        data: {
            'chartData': JSON.stringify(globalChartData),
            'initNames': initStudentNames
        },
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        success: function (data) {
            if (initStudentNames) {
                let nameList = JSON.parse(data["names"]);

                populateNameDropdown(nameList);
            }
            console.log(JSON.parse(data['data']));
            chooseChart(JSON.parse(data['data']));
        }
    });
}

function isSelected(value) {
    if ((value === null) || (value === 'Any')) {
        return false;
    }

    return true;
}
function chooseChart(data) {

    // Nothing was selected
    if ((!isSelected(globalChartData.program)) ||
        (!isSelected(globalChartData.specialization)) ||
        (!isSelected(globalChartData.course)) ||
        (!isSelected(globalChartData.student))) {
        defaultChart(data);
    }
}

function defaultChart(data) {
    let allChartsDiv = document.getElementById('allChartsDiv');

    // Clear what's currently in there
    allChartsDiv.innerHTML = "";

    let attendanceList = data['attendance'];
    let labels = ['present', 'absent', 'excused'];

    let chartData = {};
    let chartList = [];

    attendanceList.forEach(function (i) {
        chartData = {};
        chartData['data'] = [];

        if (i['present'] + i['absent'] + i['excused'] === 0) {
            return;
        }

        getAttendance(i['present'], i['absent'], i['excused'], chartData['data']);

        chartData['program'] = i['program'];
        chartList.push(chartData);
    });

    let colors = [];
    labels.forEach(function () {
        colors.push(getRandomColorHex());
    });

    chartList.forEach(function(elem) {
        let newChartDiv = document.createElement('div');
        newChartDiv.classList.add('col-6');
        newChartDiv.classList.add('charts');

        let newChartCanvas = document.createElement('canvas');
        newChartDiv.appendChild(newChartCanvas);
        allChartsDiv.appendChild(newChartDiv);

        createChart(newChartCanvas, 'pie', labels, elem.program, elem.data, colors);
    });
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