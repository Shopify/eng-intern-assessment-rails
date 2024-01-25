class ArticlesController < ApplicationController

  def index
    # return success message and all articles if request ok
    begin
      @articles = Article.all
      render json: {
        status: "success",
        message: "Articles fetched",
        data: { articles: @articles }
      }, status: :ok

    # otherwise return standard 500 error message
    rescue StandardError => e
      return_standard_error(e)
    end
  end

  # renders basic 500 error json
  private
  def return_standard_error(e)
    render json: {
      status: "error",
      error: { code: 500, message: e.message }
    }, status: :internal_server_error
  end
end
