require 'rails_helper'

RSpec.describe SchoolsController, type: :controller do
  context 'Success' do
    context 'GET index' do
      it 'should show all schools successfully' do
        get :index, format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'GET show' do
      it 'should show school with given id successfully' do
        school = FactoryGirl.create(:school)
        get :show, id: school.id, format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'GET new' do
      it 'should get correct classroom id for updation' do
        post :new
        response.should have_http_status(:ok)
      end
    end
    context 'POST create' do
      it 'should be a valid school creation' do
        post :create, school: { name: "Xavier's", address: "Mumbai", phone_no: "657548992" }, format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'PUT edit' do
      it 'should get correct school id for updation' do
        school = FactoryGirl.create(:school)
        put :edit, id: school.id
        response.should have_http_status(:ok)
      end
    end
    context 'PUT update' do
      it 'should be a valid school updation' do
        school = FactoryGirl.create(:school)
        put :update, id: school.id, school: { name: 'abc', address: school.address, phone_no: school.phone_no }, format: 'json'
        new_school = School.last
        new_school.name.should eq "abc"
        response.should have_http_status(:ok)
      end
      it 'should be a valid school updation' do
        school = FactoryGirl.create(:school)
        put :update, id: school.id, school: { name: 'abc', address: school.address, phone_no: '5555555555' }, format: 'json'
        new_school = School.last
        new_school.name.should eq "abc"
        new_school.phone_no.should eq "5555555555"
        response.should have_http_status(:ok)
      end
    end
    context 'DELETE destroy' do
      it 'should be a valid school deletion' do
        school = FactoryGirl.create(:school)
        delete :destroy, id: school.id, format: 'json'
        response.should have_http_status(:ok)
      end
    end
  end

  context 'Failure' do
    context 'GET show' do
      it 'should not show a valid school' do
        school = FactoryGirl.create(:school)
        new_school = School.last
        get :show, id: new_school.id+1, format: 'json'
        response.should have_http_status(:not_found)
      end
    end
    context 'POST create' do
      it 'should not create a school with invalid input' do
        post :create, school: { phone_no: '1346' }, format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not create a school with nil entries' do
        post :create, school: { name: nil, phone_no: nil }, format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
    end
    context 'PUT update' do
      it 'should not be a valid school updation with invalid id' do
        school = FactoryGirl.create(:school)
        new_school = School.last
        put :update, id: new_school.id+1, school: { name: 'abc', address: school.address, phone_no: school.phone_no }, format: 'json'
        response.should have_http_status(:not_found)
      end
      it 'should not be a valid school updation with invalid input' do
        school = FactoryGirl.create(:school)
        put :update, id: school.id, school: { name: 'abc', address: school.address, phone_no: nil }, format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
    end
    context 'DELETE destroy' do
      it 'should not be a valid school deletion with invalid id' do
        school = FactoryGirl.create(:school)
        new_school = School.last
        delete :destroy, id: new_school.id+1, format: 'json'
        response.should have_http_status(:not_found)
      end
    end
  end
end
