class SearchController < ApplicationController
  before_action :set_query, only: %i[ index ]

  # GET /search/index
  def index
    # Redirect to root if @query contains nothing or space chars (i.e., '  ')
    if !@query.nil? && @query.blank?
      redirect_to root_path, flash: { warning: "Please enter valid search term(s) in the search field." }
    else
      @pagy, @results = pagy(Article.search(@query))
    end
  end

  private

  # Store the user's search query input in an instance variable
  def set_query
    @query = params[:query]
  end
end
