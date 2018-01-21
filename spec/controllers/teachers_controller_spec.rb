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
        post :create, teacher: { name: 'Ms. Mary', subject_name: 'Civics', salary: 23000 }, format: 'json'
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
        new_teacher = Teacher.last
        new_teacher.name.should eq 'Nia'
        response.should have_http_status(:ok)
      end
      it 'should be a valid teacher updation' do
        teacher = FactoryGirl.create(:teacher)
        put :update, id: teacher.id, teacher: { name: 'Nia', subject_name: teacher.subject_name, salary: 45000 }, format: 'json'
        new_teacher = Teacher.last
        new_teacher.name.should eq 'Nia'
        new_teacher.salary.should eq 45000
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
        new_teacher = Teacher.last
        get :show, id: new_teacher.id+1, format: 'json'
        response.should have_http_status(:not_found)
      end
    end
    context 'POST create' do
      it 'should not create a teacher with invalid input' do
        post :create, teacher: { salary: 10 }, format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not create a teacher with nil entries' do
        post :create, teacher: { name: nil }, format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not create a teacher with invalid school id' do
        post :create, teacher: { school_id: nil }, format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not create a teacher with invalid subject id' do
        post :create, teacher: { subject_id: nil }, format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
    end
    context 'PUT update' do
      it 'should not be a valid teacher updation with invalid id' do
        teacher = FactoryGirl.create(:teacher)
        new_teacher = Teacher.last
        put :update, id: new_teacher.id+1, teacher: { name: 'abc', subject_name: teacher.subject_name, salary: teacher.salary }, format: 'json'
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
        new_school = School.last
        put :update, id: teacher.id, teacher: { name: 'abc', school_id: new_school.id+1 }, format: 'json'
        response.should have_http_status(:not_found)
      end
      it 'should not be a valid teacher updation with invalid subject id' do
        teacher = FactoryGirl.create(:teacher)
        subject = FactoryGirl.create(:subject)
        new_subject = Subject.last
        put :update, id: teacher.id, teacher: { name: 'abc', subject_id: new_subject.id+1 }, format: 'json'
        response.should have_http_status(:not_found)
      end
    end
    context 'DELETE destroy' do
      it 'should not be a valid teacher deletion with invalid id' do
        teacher = FactoryGirl.create(:teacher)
        new_teacher = Teacher.last
        delete :destroy, id: new_teacher.id+1, format: 'json'
        response.should have_http_status(:not_found)
      end
    end
  end
end
