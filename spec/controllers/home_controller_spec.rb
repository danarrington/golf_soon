require 'spec_helper'

describe HomeController do

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  context 'With logged in User' do
    before :each do
      sign_in create(:user)
    end
    context 'With no saved courses' do

      it 'redirects to course picker page' do
        get :index

        expect(response).to redirect_to pick_courses_path
      end

    end

    context 'with saved courses' do
      it 'redirects to tee times page' do
        User.first.courses << create(:course)
        get :index
        expect(response).to redirect_to times_path
      end
    end
  end

end
