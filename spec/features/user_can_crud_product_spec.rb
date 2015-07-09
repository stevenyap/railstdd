require 'rails_helper'

RSpec.describe 'User can CRUD products', type: :feature do
  let!(:category) { create(:category) }

  it 'allows user to CRUD products' do
    visit '/products'
    expect(page).not_to have_content 'Ruby Book'
    click_on 'Create Product'

    fill_in 'Title', with: 'Ruby Book'
    fill_in 'Description', with: 'This is a good Ruby book'
    fill_in 'Price', with: 12.99
    check 'Published'
    select category.title, from: 'Category'
    click_on 'Create Product'

    expect(page).to have_content 'Ruby Book'
    click_on 'Edit'
    
    fill_in 'Title', with: 'Rails Book'
    click_on 'Update Product'
    
    expect(page).to have_content 'Rails Book'
    click_on 'Delete'

    expect(page).not_to have_content 'Rails Book'
  end
end