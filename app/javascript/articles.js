// Attach event listeners when the turbo page is loaded
document.addEventListener("turbo:load", function () {
  setupCollapsibleForm();
  setupClearButton();
});

// Sets up the collapsible form functionality
function setupCollapsibleForm() {
  var toggleButton = document.getElementById("new-article-toggle");
  var form = document.getElementById("new-article-form");
  var arrow = document.getElementById("arrow");

  if (!toggleButton || !form || !arrow) return;

  form.style.display = "none";
  arrow.innerHTML = "&#9660;"; // Downward arrow

  toggleButton.addEventListener("click", function () {
    var isFormVisible = form.style.display !== "none";
    form.style.display = isFormVisible ? "none" : "block";
    arrow.innerHTML = isFormVisible ? "&#9660;" : "&#9650;"; // Change arrow direction
  });
}

// Sets up the clear button functionality in the search form
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
