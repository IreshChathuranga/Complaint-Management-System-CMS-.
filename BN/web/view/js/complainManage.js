window.addEventListener("DOMContentLoaded", () => {
    const rows = document.querySelectorAll("#complainTable tr");

    rows.forEach(row => {
        row.addEventListener("click", () => {
            const id = row.dataset.id;
            const name = row.dataset.name;
            const complain = row.dataset.complain;

            document.getElementById("id").value = id;
            document.getElementById("name").value = name;
            document.getElementById("modalcomplain").value = complain;

            document.getElementById("status").value = "pending";

            const modal = new bootstrap.Modal(document.getElementById("updateModal"));
            modal.show();
        });
    });
});
