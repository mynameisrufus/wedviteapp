module PostsHelper
  def continue_link scope, &block
    pagination_link scope, :last_page?, &block
  end

  def newer_link scope, &block
    pagination_link scope, :first_page?, &block
  end

  def pagination_link scope, meth, &block
    direction = {
      first_page?: -1,
      last_page?: 1
    }.fetch(meth)

    unless scope.send(meth)
      link_to capture(&block), page_posts_path(scope.current_page + direction), class: 'btn'
    end
  end
end
