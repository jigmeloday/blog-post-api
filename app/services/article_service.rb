class ArticleService < BaseService
  def create
    params[:user_id] = current_user.id
    Article.create!(params)
  end

  def show
    article
  end

  def destroy
    article.destroy!
  end

  def update
    article.update!(params)
    article
  end

  private

  def article
    @article ||= Article.find(id)
  end
end
