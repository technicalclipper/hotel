document.getElementById("retrieve-date").addEventListener("change", function() {
    const date = this.value;
    window.location.href = `/getbookingdetails/${date}`;
});

$(".triggerbutton").on("click",async()=>{
    await trigger()
})

async function trigger() {
    try {
        const response = await fetch('/trigger');
        const data = await response.json();
        console.log(data);
        const logMessage = data.log;
        const imageUrl = data.iurl;
        const campaign=data.campaign;
        const no_of_campaigns=data.no_of_campaigns;
        $(".log").text(logMessage);
        $("#genimage").attr("src",imageUrl);
        $(".campaign").text(campaign);                       
        $("#totalCampaignsValue").text("Total: "+no_of_campaigns+ " campaigns");
    }
    catch (error) {
        console.error('Error fetching data:', error);
    }
}


//for charts logic



// Initialize the chart
// Rooms Booked Chart
const roomsChart = document.getElementById('roomsChart').getContext('2d');
new Chart(roomsChart, {
    type: 'bar', // Type of chart (can be line, pie, etc.)
    data: {
        labels: ['Deluxe Room', 'Super Deluxe', 'Suite', 'Lounge', 'Beach View'],
        datasets: [{
            label: 'Rooms Booked',
            data: [25, 25, 20, 7, 3], // Data for each room type
            backgroundColor: 'rgba(75, 192, 192, 1)',  
            borderColor: 'rgba(75, 192, 192, 1)',
            borderWidth: 1
        }]
    },
    options: {
        responsive: true,
        scales: {
            y: {
                beginAtZero: true,
                ticks: {
                    color: 'white' // Y-axis labels in white
                }
            },
            x: {
                ticks: {
                    color: 'white' // X-axis labels in white
                }
            }
        },
        plugins: {
            legend: {
                labels: {
                    color: 'white' // Legend text color in white
                }
            }
        }
    }
});

// Campaigns Triggered Chart
const campaignsChart = document.getElementById('campaignsChart').getContext('2d');
new Chart(campaignsChart, {
    type: 'pie', // A pie chart for campaigns
    data: {
        labels: ['Targeted Ads', 'Insta Campaigns', 'Event Promotion'],
        datasets: [{
            label: 'Campaigns',
            data: [0, 1, 0], // Example data for campaigns
            backgroundColor: ['#FF6384', '#36A2EB', '#FFCE56'],
        }]
    },
    options: {
        responsive: true,
        plugins: {
            legend: {
                labels: {
                    color: 'white' // Legend text color in white
                }
            }
        }
    }
});

// Local Events Chart
const eventsChart = document.getElementById('eventsChart').getContext('2d');
new Chart(eventsChart, {
    type: 'line', // Line chart for events over time
    data: {
        labels: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'],
        datasets: [{
            label: 'Local Events',
            data: [0, 1, 2, 1, 3, 1, 5], // Example data for events
            backgroundColor: 'rgba(75, 192, 192, 0.2)',
            borderColor: 'rgba(75, 192, 192, 1)',
            borderWidth: 2
        }]
    },
    options: {
        responsive: true,
        scales: {
            y: {
                beginAtZero: true,
                ticks: {
                    color: 'white' // Y-axis labels in white
                }
            },
            x: {
                ticks: {
                    color: 'white' // X-axis labels in white
                }
            }
        },
        plugins: {
            legend: {
                labels: {
                    color: 'white' // Legend text color in white
                }
            }
        }
    }
});
