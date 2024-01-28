// validateArticleForm function is attached to the window object, making it globally accessible.
// It checks whether the title and content fields are empty.
// If either field is empty, it alerts the user and prevents form submission.
window.validateArticleForm = function() {
  const title = document.querySelector('[name="article[title]"]').value;
  const content = document.querySelector('[name="article[content]"]').value;
  if (!title.trim() || !content.trim()) {
    alert('Title and content cannot be empty.');
    return false;
  }
  return true;
};
