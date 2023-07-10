class ArticleService
  def create(params)
    Article.create!(params)
  end

  def show(id)
    Article.find(id)
  end

  def destroy(id)
    Article.find(id).destroy!
  end

  def update(id, params)
    article = Article.find(id)
    article.update!(params)
    article
  end
end
