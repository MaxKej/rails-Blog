document.addEventListener('DOMContentLoaded', function() {
    document.querySelectorAll('.edit-post-btn').forEach(button => {
        button.addEventListener('click', function() {
            const postId = this.dataset.postId;
            document.getElementById(`post-edit-form-${postId}`).style.display = 'block';
        });
    });

    document.querySelectorAll('.cancel-edit-post-btn').forEach(button => {
        button.addEventListener('click', function() {
            const postId = this.dataset.postId;
            document.getElementById(`post-edit-form-${postId}`).style.display = 'none';
        });
    });
});
