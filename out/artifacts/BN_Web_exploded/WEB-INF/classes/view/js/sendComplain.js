window.addEventListener("DOMContentLoaded", () => {
    const rows = document.querySelectorAll("#complainTable tr");

    rows.forEach(row => {
        row.addEventListener("click", () => {
            const id = row.dataset.id;
            const name = row.dataset.name;
            const complain = row.dataset.complain;

            document.getElementById("modal-id").value = id;
            document.getElementById("modal-name").value = name;
            document.getElementById("modal-complain").value = complain;

            // ✅ Force status to always be "pending"
            document.getElementById("modal-status").value = "pending";

            const modal = new bootstrap.Modal(document.getElementById("exampleModal"));
            modal.show();
        });
    });
});
