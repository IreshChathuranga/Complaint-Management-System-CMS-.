document.addEventListener("DOMContentLoaded", function () {
    const form = document.querySelector("form");

    form.addEventListener("submit", function (e) {
        const role = document.getElementById("role").value.trim().toLowerCase();
        const email = document.getElementById("email").value.trim();
        const password = document.getElementById("password").value.trim();

        const validRoles = ["admin", "employee"];
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

        if (!validRoles.includes(role)) {
            alert("Role must be either 'Admin' or 'Employee'.");
            e.preventDefault();
            return;
        }

        if (!emailRegex.test(email)) {
            alert("Please enter a valid email address.");
            e.preventDefault();
            return;
        }

        if (password.length < 6) {
            alert("Password must be at least 6 characters long.");
            e.preventDefault();
            return;
        }
    });

    const urlParams = new URLSearchParams(window.location.search);
    const status = urlParams.get("status");

    if (status === "success") {
        alert("Registration successfully!");
        window.history.replaceState({}, document.title, window.location.pathname);
    } else if (status === "fail") {
        alert("Login failed. Please try again.");
    }
});
