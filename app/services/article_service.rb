class ArticleService < BaseService
  def create
    params[:user_id] = current_user.id
    Article.create!(params)
  end

  def show
    record
  end

  def destroy
    record.destroy!
  end

  def update
    record.update!(params)
    record
  end

  # private

  # def article
  #   @article ||= Article.find(id)
  # end
end
