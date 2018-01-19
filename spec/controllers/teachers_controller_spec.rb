require 'rails_helper'

RSpec.describe TeachersController, type: :controller do
  context 'Success' do
    context 'GET index' do
      it 'should show all teachers successfully' do
        get :index, format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'GET show' do
      it 'should show teacher with given id successfully' do
        teacher = FactoryGirl.create(:teacher)
        get :show, id: teacher.id, format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'POST create' do
      it 'should be a valid teacher creation' do
        teacher = FactoryGirl.build(:teacher)
        post :create, teacher: { name: teacher.name, subject_name: teacher.subject_name, salary: teacher.salary }, format: 'json'
        response.should have_http_status(:ok)
      end
      it 'should be a valid teacher creation' do
        teacher = FactoryGirl.build(:teacher)
        post :create, teacher: { name: teacher.name, subject_name: 'History', salary: teacher.salary }, format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'PUT edit' do
      it 'should get correct teacher id for updation' do
        teacher = FactoryGirl.create(:teacher)
        get :edit, id: teacher.id
        response.should have_http_status(:ok)
      end
    end
    context 'PUT update' do
      it 'should be a valid teacher updation' do
        teacher = FactoryGirl.create(:teacher)
        put :update, id: teacher.id, teacher: { name: 'Nia', subject_name: teacher.subject_name, salary: teacher.salary }, format: 'json'
        response.should have_http_status(:ok)
      end
      it 'should be a valid teacher updation' do
        teacher = FactoryGirl.create(:teacher)
        put :update, id: teacher.id, teacher: { name: 'Nia', subject_name: teacher.subject_name, salary: 45_000 }, format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'DELETE destroy' do
      it 'should be a valid teacher deletion' do
        teacher = FactoryGirl.create(:teacher)
        delete :destroy, id: teacher.id, format: 'json'
        response.should have_http_status(:ok)
      end
    end
  end

  context 'Failure' do
    context 'GET show' do
      it 'should not show a valid teacher' do
        teacher = FactoryGirl.create(:teacher)
        a = Teacher.last
        get :show, id: a.id+1, format: 'json'
        response.should have_http_status(:not_found)
      end
    end
    context 'POST create' do
      it 'should not create a teacher with invalid input' do
        teacher = FactoryGirl.build(:teacher)
        post :create, teacher: { name: teacher.name, subject_name: teacher.subject_name, salary: 10 }, format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not create a teacher with nil entries' do
        teacher = FactoryGirl.build(:teacher)
        post :create, teacher: { name: nil }, format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not create a teacher with invalid school id' do
        teacher = FactoryGirl.build(:teacher)
        post :create, teacher: { school_id: nil }, format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not create a teacher with invalid subject id' do
        teacher = FactoryGirl.build(:teacher)
        post :create, teacher: { subject_id: nil }, format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
    end
    context 'PUT update' do
      it 'should not be a valid teacher updation with invalid id' do
        teacher = FactoryGirl.create(:teacher)
        a = Teacher.last
        put :update, id: a.id+1, teacher: { name: 'abc', subject_name: teacher.subject_name, salary: teacher.salary }, format: 'json'
        response.should have_http_status(:not_found)
      end
      it 'should not be a valid teacher updation with invalid input' do
        teacher = FactoryGirl.create(:teacher)
        put :update, id: teacher.id, teacher: { name: 'abc', subject_name: nil }, format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not be a valid teacher updation with invalid school id' do
        teacher = FactoryGirl.create(:teacher)
        school = FactoryGirl.create(:school, phone_no:"6476578378")
        a = School.last
        put :update, id: teacher.id, teacher: { name: 'abc', school_id: a.id+1 }, format: 'json'
        response.should have_http_status(:not_found)
      end
      it 'should not be a valid teacher updation with invalid subject id' do
        teacher = FactoryGirl.create(:teacher)
        subject = FactoryGirl.create(:subject)
        a = Subject.last
        put :update, id: teacher.id, teacher: { name: 'abc', subject_id: a.id+1 }, format: 'json'
        response.should have_http_status(:not_found)
      end
    end
    context 'DELETE destroy' do
      it 'should not be a valid teacher deletion with invalid id' do
        teacher = FactoryGirl.create(:teacher)
        a = Teacher.last
        delete :destroy, id: a.id+1, format: 'json'
        response.should have_http_status(:not_found)
      end
    end
  end
end
