Given /^I am on the home page$/ do
  visit root_path
end

Given /^the blog is set up$/ do
  create_blog
  create_admin
end

Given /^I am logged into the admin panel$/ do
  visit '/accounts/login'
  sign_in
end

Given /^I am on the new article page$/ do
  visit '/admin/content/new'
end

# ============================================================================================= #

When /^I follow "(.*)"$/ do |link|
  click_link link
end

When /^I create a new (.*)$/ do |resource|
  send "fill_out_#{resource}"
  click_on_submit_button
end

When /^I change the name of an existing category$/ do
  step 'I create a new category'

  within "tr#category_#{last_category.id}" do
    click_link 'Edit'
  end
  category.name = 'Updated'

  step 'I create a new category'
end

# ============================================================================================= #

Then /^I should see "(.*)"$/ do |content|
  expect(page.body).to have_content(content)
end

Then /^I should not see "(.*)"$/ do |content|
  expect(page.body).not_to have_content(content)
end

Then /^I should be on the admin content page$/ do
  expect(current_path).to eq('/admin/content')
end

Then /^the article should be created$/ do
  expect(last_article.title).to eq(article.title)
  expect(last_article.body).to eq(article.body)
end

Then /^I should be on the new category page$/ do
  expect(current_path).to eq('/admin/categories/new')
end

Then /^I should see the category on categories table$/ do
  within 'table#category_container' do
    expect(page.body).to have_content(category.name)
    expect(page.body).to have_content(category.permalink)
  end
end

Then /^I should see the updated name of the category on categories table$/ do
  within 'table#category_container' do
    expect(page.body).to have_content('Updated')
  end
end
