require 'spec_helper'

feature 'Picking Courses' do

  background :each do
    sign_in_with_link create(:user)
  end

  scenario 'List all courses' do

    create(:course, name: 'Cosmo Golf Course')
    visit '/'

    expect(page).to have_content 'Cosmo Golf Course'
  end
end