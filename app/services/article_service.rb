class ArticleService < BaseService
  def create
    Article.create!(params.merge!(user_id: current_user.id))
  end

  def show
    article
  end

  def destroy
    authorize article, :destroy?
    article.destroy!
  end

  def update
    authorize article, :update?
    article.update!(params)
    article
  end

  private

  def article
    @article ||= Article.find(id)
  end
end
