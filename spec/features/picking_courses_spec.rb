require 'spec_helper'

feature 'Picking Courses' do

  let(:user) {create(:user)}
  background :each do
    sign_in_with_link user
  end

  scenario 'List all courses' do

    create(:course, name: 'Cosmo Golf Course')
    visit '/'

    expect(page).to have_content 'Cosmo Golf Course'
  end

end