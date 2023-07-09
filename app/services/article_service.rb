class ArticleService
  def create(params)
    Article.create!(params)
  end
end