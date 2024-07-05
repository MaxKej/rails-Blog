document.addEventListener("DOMContentLoaded", function() {
    // Pokaż formularz edycji komentarza
    document.querySelectorAll(".edit-comment-btn").forEach(button => {
        button.addEventListener("click", function() {
            const commentId = this.dataset.commentId;
            document.getElementById(`comment-edit-form-${commentId}`).style.display = 'block';
        });
    });

    // Ukryj formularz edycji komentarza, gdy kliknięty przycisk "Porzuć"
    document.querySelectorAll(".cancel-edit-comment-btn").forEach(button => {
        button.addEventListener("click", function() {
            const commentId = this.dataset.commentId;
            document.getElementById(`comment-edit-form-${commentId}`).style.display = 'none';
        });
    });
});
