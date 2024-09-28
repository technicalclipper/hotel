document.getElementById("retrieve-date").addEventListener("change", function() {
    const date = this.value;
    window.location.href = `/getbookingdetails/${date}`;
});

