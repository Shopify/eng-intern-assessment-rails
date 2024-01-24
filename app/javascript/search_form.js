document.addEventListener("turbo:load", function () {
  setupCollapsibleForm();
  setupClearButton();
});

function setupCollapsibleForm() {
  var toggleButton = document.getElementById("new-article-toggle");
  var form = document.getElementById("new-article-form");
  var arrow = document.getElementById("arrow");

  if (!toggleButton || !form || !arrow) return;

  form.style.display = "none";
  arrow.innerHTML = "&#9660;"; // Arrow down

  toggleButton.removeEventListener("click", handleToggleClick);
  toggleButton.addEventListener("click", handleToggleClick);
}

function handleToggleClick() {
  var form = document.getElementById("new-article-form");
  var arrow = document.getElementById("arrow");
  var isFormVisible = form.style.display !== "none";
  form.style.display = isFormVisible ? "none" : "block";
  arrow.innerHTML = isFormVisible ? "&#9660;" : "&#9650;";
}

function setupClearButton() {
  var clearButton = document.querySelector(".clear-btn");
  var searchField = document.getElementById("search-field");
  var searchForm = document.getElementById("search-form");

  if (clearButton && searchField && searchForm) {
    clearButton.addEventListener("click", function () {
      searchField.value = "";
      searchForm.submit();
    });
  }
}
