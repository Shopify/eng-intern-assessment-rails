import { Controller } from '@hotwired/stimulus';

// Connects to data-controller="search"
export default class extends Controller {
  static targets = ['title', 'content', 'author'];

  connect() {
    console.log('Hello from Stimulus Search Controller', this.connection);
  }

  filterArticles(event) {
    const searchTerm = event.target.value.toLowerCase();

    this.titleTargets.forEach(title => {
      const articleTitle = title.textContent.toLowerCase();
      const articleContent = title.nextElementSibling.textContent.toLowerCase();
      const articleAuthor = title.nextElementSibling.nextElementSibling.textContent.toLowerCase();

      if (
        articleTitle.includes(searchTerm) ||
        articleContent.includes(searchTerm) ||
        articleAuthor.includes(searchTerm)
      ) {
        title.parentElement.style.display = '';
      } else {
        title.parentElement.style.display = 'none';
      }
    });
  }
}
