require 'spec_helper'

feature 'Listing Tee Times' do

  let(:user) {create(:user)}
  background :each do
    sign_in_with_link user
  end

  scenario 'Signed in user with favorites gets redirected to list favorites' do

    course = create(:course, name: 'Cosmo Golf Course')
    time = create(:tee_time, course_id: course, tee_time: DateTime.parse('11:57'))
    user.courses << course
    user.save

    visit '/'

    expect(page).to have_content '11:57'
  end

end
