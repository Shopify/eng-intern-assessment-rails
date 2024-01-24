document.addEventListener("turbo:load", function () {
  setupCollapsibleForm();
  setupClearButton();
  setupDateToggle("new-article-date-checkbox", "article_date");
});

function setupCollapsibleForm() {
  var toggleButton = document.getElementById("new-article-toggle");
  var form = document.getElementById("new-article-form");
  var arrow = document.getElementById("arrow");

  if (!toggleButton || !form || !arrow) return;

  form.style.display = "none";
  arrow.innerHTML = "&#9660;";

  toggleButton.addEventListener("click", function () {
    var isFormVisible = form.style.display !== "none";
    form.style.display = isFormVisible ? "none" : "block";
    arrow.innerHTML = isFormVisible ? "&#9660;" : "&#9650;";
  });
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

function setupDateToggle(checkboxId, dateFieldPrefix) {
  var checkbox = document.getElementById(checkboxId);
  if (!checkbox) return;

  var dateFields = document.querySelectorAll(
    `select[id^='${dateFieldPrefix}']`
  );
  checkbox.addEventListener("change", function () {
    dateFields.forEach(function (field) {
      field.disabled = !checkbox.checked;
    });
  });

  dateFields.forEach(function (field) {
    field.disabled = !checkbox.checked;
  });
}
