module Helpers
  def create_blog
    Blog.default.update_attributes!(
      blog_name: 'Teh Blag',
      base_url:  'http://localhost:3000'
    )
  end

  def create_admin
    User.create!(
      login:      'admin',
      password:   'secret',
      email:      'joe@snow.com',
      profile_id: 1,
      name:       'admin',
      state:      'active'
    )
  end

  def sign_in
    fill_in 'user_login',    with: 'admin'
    fill_in 'user_password', with: 'secret'

    click_on_submit_button
  end

  def fill_out_article
    fill_in 'article_title',                     with: article.title
    fill_in 'article__body_and_extended_editor', with: article.body
  end

  def fill_out_category
    fill_in 'category_name',      with: category.name
    fill_in 'category_permalink', with: category.permalink
  end

  def click_on_submit_button
    find('*[type=submit]').click
  end

  def article
    @article ||= Article.new(
      title: 'Foobar',
      body:  'Lorem Ipsum'
    )
  end

  def category
    @category ||= Category.new(
      name:      'Sports',
      permalink: 'sports'
    )
  end

  private

  def method_missing(method_name, *args)
    # Returns an ActiveRecord::Relation scope object or finds the first/last record.
    # 
    # Examples:
    #   all_categories => Category.all
    #   first_category => Category.first
    #   last_category  => Category.last
    # 
    # The named matches in a regular expression are also available as local variables, but only if
    # you use a literal regexp and that literal appears on the left hand side of the =~ operator.
    # 
    # @return
    # 
    if /\A(?<message>all|first|last)_(?<model_name>[a-z_]+)\z/ =~ method_name
      model_name.singularize.camelize.constantize.order(:id).send(message)
    else
      super
    end
  end
end

World(Helpers)
