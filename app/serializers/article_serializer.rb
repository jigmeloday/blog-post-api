class ArticleSerializer < ActiveModel:: Serializer
  attributes(
    :id,
    :title,
    :body,
    :like_count,
    :comment_count,
    :user_id
  )
end
