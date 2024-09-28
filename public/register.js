$(".submit").on("click", () => {
    const username = $("#username").val();
    const password = $("#password").val();
    const name = $("#name").val();
    const age = $("#age").val();
    const phone_no = $("#phone_no").val();
    register(username, password, name, age, phone_no);
});

async function register(username, password, name, age, phone_no) {
    try {
        const response = await fetch("/register", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                username: username,
                password: password,
                name: name,
                age: age,
                phone_no: phone_no
            })
        });

        if (response.status===200) {
            console.log("Registered successfully");
            window.location.href = "/home";
        } else if (response.status === 409) {
            console.error("User already registered");
            // Redirect to login if the user already exists
            window.location.href = "/login";
        } else {
            console.error("Failed to register:", response.statusText);
        }
    } catch (error) {
        console.error("Error:", error);
    }
}