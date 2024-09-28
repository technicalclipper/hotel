$(".submit").on("click", async () => {
    const username = $("#username").val();
    const password = $("#password").val();
    const response = await login(username, password);
    
    if (response.redirected) {
      window.location.href = response.url; // based on returned function
    } else {
      console.error("Login failed or unexpected response");
    }
  });
  
  async function login(username, password) {
    try {
      const response = await fetch("/login", {
        method: "POST",
        headers: {
          "Content-Type": "application/json"
        },
        body: JSON.stringify({
          username: username,
          password: password,
        }),
        credentials: 'include' // Include cookies for session management
      });
      return response; // Return the response for handling in the event handler function so i can use it again
    } catch (error) {
      console.error("Error:", error);
    }
  }
  