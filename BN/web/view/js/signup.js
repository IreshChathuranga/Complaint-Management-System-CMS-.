
document.addEventListener("DOMContentLoaded", function () {
    document.querySelector("form").addEventListener("submit", function (e) {
        const role = document.getElementById("role").value.trim().toLowerCase();
        const name = document.getElementById("name").value.trim();
        const address = document.getElementById("address").value.trim();
        const phone = document.getElementById("phone").value.trim();
        const email = document.getElementById("email").value.trim();
        const password = document.getElementById("password").value.trim();

        const validRoles = ["admin", "employee"];
        const nameRegex = /^[A-Za-z\s]{2,}$/;
        const phoneRegex = /^\d{10}$/;
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

        if (!validRoles.includes(role)) {
            alert("Role must be either 'Admin' or 'Employee'.");
            e.preventDefault();
            return;
        }

        if (!nameRegex.test(name)) {
            alert("Please enter a valid name (only letters, min 2 characters).");
            e.preventDefault();
            return;
        }

        if (address.length < 3) {
            alert("Please enter a valid address (at least 3 characters).");
            e.preventDefault();
            return;
        }

        if (!phoneRegex.test(phone)) {
            alert("Please enter a valid 10-digit phone number.");
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
        alert("User registered successfully!");
    } else if (status === "fail") {
        alert("Registration failed. Please try again.");
    }
});
