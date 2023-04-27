class ArticlePolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    return true if !record.private
    return false unless user

    user.article_ids.include?(record.id)
  end
end
