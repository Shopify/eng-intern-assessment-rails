import { Controller } from '@hotwired/stimulus';

// Connects to data-controller="search"
export default class extends Controller {
  static targets = ['title', 'content', 'author', 'date'];

  /**
   * Debounces a given function to limit the rate at which it is called.
   * This is used to prevent excessive filtering during user input.
   *
   * @param {Function} func - The function to be debounced.
   * @param {number} delay - The delay in milliseconds.
   * @returns {Function} - The debounced function.
   */
  debounce(func, delay) {
    let timerId;
    return (...args) => {
      clearTimeout(timerId);
      timerId = setTimeout(() => func(...args), delay);
    };
  }

  connect() {
    this.filterArticlesDebounced = this.debounce(this.filterArticles, 300);
  }

  filterArticles(event) {
    const searchTerm = event.target.value.toLowerCase();

    this.titleTargets.forEach(title => {
      const article = title.closest('.article');
      const articleTitle = article.querySelector('.title').textContent.toLowerCase();
      const articleContent = article.querySelector('.content').textContent.toLowerCase();
      const articleAuthor = article.querySelector('.author').textContent.toLowerCase();
      const articleDate = article.querySelector('.date').textContent.toLowerCase();

      if (
        articleTitle.includes(searchTerm) ||
        articleContent.includes(searchTerm) ||
        articleAuthor.includes(searchTerm) ||
        articleDate.includes(searchTerm)
      ) {
        article.classList.toggle('hide', false);
      } else {
        article.classList.toggle('hide', true);
      }
    });
  }
}
