window.onload = function () {
    console.log(chart_data);
    let semester = chart_data['semester'];
    let attendance_list = chart_data['attendance'];
    let labels = [];
    let present = [];
    let absent = [];
    let excused = [];
    let me_attendance = [];
    let msc_attendance = [];
    let fgitm_attendance = [];
    let exchange_attendance = [];

    function getRandomColorHex() {
        var hex = "0123456789ABCDEF",
            color = "#";
        for (var i = 1; i <= 6; i++) {
            color += hex[Math.floor(Math.random() * 16)];
        }
        return color;
    }

    attendance_list.forEach(function (i) {

        // console.log(i['present']);
        // console.log(i);
        // if ((i['present'] !== 0) && (i['absent'] !== 0) && (i['excused'] !== 0)) {
        //     console.log(i['program']);
        //     labels.push(i['program']);
        if (i['program'] === "None")
            present.push(i['present']);
        if (i['program'] === "Master of Engineering")
            present.push(i['present']);

        if (i['program'] === "Master of Science")
            present.push(i['present']);

        if (i['program'] === "Global IT Management (French)")
            present.push(i['present']);

        if (i['program'] === "Exchange")
            present.push(i['present']);
        labels.push(i['program']);
        // }
    });

    console.log(present);
    console.log(labels);
    let chart = document.getElementById('mainChart').getContext('2d');
    // canvas.style.height = '1300px';
    // canvas.style.width = '1300px';

    let byProgramChart = new Chart(chart, {
        type: 'bar', // bar, horizontal bar, pie, line, doughnut, radar, polarArea
        data: {
            labels: labels,
            datasets: [{
                // label: 'Insert Label Here',
                data: present,
                backgroundColor: getRandomColorHex(),
                borderWidth: 4,
                borderColor: 'grey'
            }]
        },
        options: {
            title: {
                display: true,
                text: 'Program Statistics'
            },
            legend: {
                position: 'right'
            }
        }
    });
};