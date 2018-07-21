let date = new Date();
const year = date.getFullYear()-1;

let globalChartData = {
    'year': year,
    'season': 'Fall',
    'program': null,
    'specialization': null,
    'course': null,
    'student': -1,
    'student_name': null
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
    globalChartData['student'] = student.dataset['value'];
    globalChartData['student_name'] = student.innerText;
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
        globalChartData.student_name
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
        program_name = chart_data['attendance'][i]['title'];

        if (program_name === 'None') {
            continue;
        }

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

    // Clear what's already there
    studentBtn.innerHTML = "";

    studentBtn.innerHTML += '<a class="dropdown-item" data-value="-1" href="#">Any</a>';

    //
    // Student
    //
    for (let key in student_data) {
        studentBtn.innerHTML += "<a class='dropdown-item' data-value='{0}' href='#'>{1}</a>".format(key, student_data[key]);
    }

    for (let i = 0; i < studentBtn.children.length; i++) {
        aTag = studentBtn.children[i].addEventListener('click', function (e) {
            setStudentQuery(e.target);
            feedMeData(false);
        });
    }
}

function populateCourseDropdown(course_titles) {
    const courseBtn = document.getElementById('courseBtn');

    // Clear what's already there
    courseBtn.innerHTML = "";

    courseBtn.innerHTML += '<a class="dropdown-item" href="#">Any</a>';

    //
    // Student
    //
    course_titles.forEach(function(e) {
        courseBtn.innerHTML += "<a class='dropdown-item' href='#'>{0}</a>".format(e);
    });

    for (let i = 0; i < courseBtn.children.length; i++) {
        aTag = courseBtn.children[i].addEventListener('click', function (e) {
            setCourseQuery(e.target.innerHTML);
            feedMeData(false);
        });
    }
}

function feedMeData(initDropdown) {
    $.ajax({
        type: 'POST',
        url: window.href,
        data: {
            'chartData': JSON.stringify(globalChartData),
        },
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        success: function (data) {
            if (initDropdown) {
                // Populate the initial dropdown menus
                let attendance = JSON.parse(data['data'])[0];
                populateDropdowns(attendance);
            } else {

            }

            // Every time, we have to update the possible list of names
            let nameList = JSON.parse(data["names"]);
            populateNameDropdown(nameList);

            if (data['courses']) {
                let courseList = data['courses'];
                populateCourseDropdown(courseList);
            }

            chooseChart(JSON.parse(data['data']));
        }
    });
}

function isSelected(value) {
    return !((value === null) || (value === 'Any') || (value === -1));
}

function chooseChart(data) {

    // Nothing was selected
    if ((!isSelected(globalChartData.program)) &&
        (!isSelected(globalChartData.specialization)) &&
        (!isSelected(globalChartData.course)) &&
        (!isSelected(globalChartData.student_name))) {
        pieChart(data);
    }

    // Specialization AND/OR Program are the only selected queries
    else if (!(isSelected(globalChartData.student_name) && isSelected(globalChartData.course))) {
        stackedBarChart(data);
    }

    // All others will default to a pie chart
    else {
        pieChart(data);
    }
}

function stackedBarChart(data) {
    let allChartsDiv = document.getElementById('allChartsDiv');

    // Clear what's currently in there
    allChartsDiv.innerHTML = "";

    let labels = [];
    let presentCounts = [];
    let absentCounts = [];
    let excusedCounts = [];

    data.forEach(function(e) {
        let attendance = e.attendance[0];

        labels.push(e.title);
        presentCounts.push(attendance.present);
        absentCounts.push(attendance.absent);
        excusedCounts.push(attendance.excused);
    });

    let bar_datasets = [
        {
            label: 'Present',
            data: presentCounts,
            backgroundColor: '#00C851'
        },
        {
            label: 'Absent',
            data: absentCounts,
            backgroundColor: '#ff4444'
        },
        {
            label: 'Excused',
            data: excusedCounts,
            backgroundColor: '#ffbb33'
        },
    ];

    let newChartDiv = document.createElement('div');
    newChartDiv.classList.add('col-12');
    newChartDiv.classList.add('charts');
    newChartDiv.classList.add('single-chart');

    let newChartCanvas = document.createElement('canvas');
    newChartDiv.appendChild(newChartCanvas);
    allChartsDiv.appendChild(newChartDiv);

    _createStackedBarChart(newChartCanvas, labels, bar_datasets);
}

function pieChart(dataArray) {
    let allChartsDiv = document.getElementById('allChartsDiv');

    let data = dataArray[0];

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

        chartData['title'] = i['title'];

        if (!chartData['title']) {
            chartData['title'] = data['title']
        }

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

        _createPieChart(newChartCanvas, labels, elem.title, elem.data, colors);
    });
}


function _createStackedBarChart(location, labels, datasets) {
    new Chart(location, {
        type: 'bar',
        data: {
            datasets: datasets,
            labels: labels,
        },

        options: {
            scales: {
                xAxes: [{
                    stacked: true
                }],
                yAxes: [{
                    stacked: true,
                    ticks: {
                        beginAtZero:true
                    }
                }]
            }
        }
    });
}

function _createPieChart(location, labels, title, data, colors) {
    new Chart(location, {
        type: 'pie',
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