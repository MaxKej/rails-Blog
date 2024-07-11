document.addEventListener("DOMContentLoaded", function() {
    document.getElementById("show-comment-form").addEventListener("click", function() {
        let commentForm = document.getElementById("comment-form");
        if (commentForm.style.display === "none" || commentForm.style.display === "") {
            commentForm.style.display = "block";
        } else {
            commentForm.style.display = "none";
        }
    });
});
