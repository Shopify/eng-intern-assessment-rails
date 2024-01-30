//Add event listeners for the 'update' button in order to trigger the update form to appear and get populated when clicked
document.addEventListener('turbolinks:load', function() {
    document.querySelector('table').addEventListener('click', function(event){
      if (event.target.className == 'update_article') {
        const articleId = event.target.dataset.articleId;
        fetch(`/articles/${articleId}/edit`)
            .then(response => response.json()) // Fetch the article data (you can use AJAX or a similar approach)
            .then(articleData => { // Populate the update form fields
                document.getElementById('update_article_title').value = articleData.title;
                document.getElementById('update_article_author').value = articleData.author;
                document.getElementById('update_article_date').value = articleData.date;
                document.getElementById('update_article_content').value = articleData.content;
                document.getElementById('update_article_id').value = articleData.id;
                document.getElementById('update_article_form').action = `/articles/${articleId}`;
                //this will update form submission URL based on which update button was selected
            })
            .catch(error => console.error('Error:', error));
        document.getElementById('update_form').style.display = 'block';
      };
    });
  });