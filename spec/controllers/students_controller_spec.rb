require 'rails_helper'

RSpec.describe StudentsController, type: :controller do
  context 'Success' do
    context 'GET index' do
      it 'should show all students successfully' do
        get :index, format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'GET show' do
      it 'should show student with given id successfully' do
        student = FactoryGirl.create(:student)
        get :show, id: student.id, format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'POST create' do
      it 'should be a valid student creation' do
        post :create, student: { name: "Aamir", address: "Delhi", phone_no: "7589493032" }, format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'PUT edit' do
      it 'should get correct student id for updation' do
        student = FactoryGirl.create(:student)
        get :edit, id: student.id
        response.should have_http_status(:ok)
      end
    end
    context 'PUT update' do
      it 'should be a valid student updation' do
        student = FactoryGirl.create(:student)
        put :update, id: student.id, student: { name: 'Nia', address: student.address, phone_no: student.phone_no }, format: 'json'
        new_student = Student.last
        new_student.name.should eq "Nia"
        response.should have_http_status(:ok)
      end
      it 'should be a valid student updation' do
        student = FactoryGirl.create(:student)
        put :update, id: student.id, student: { name: 'Nia', address: 'India', phone_no: student.phone_no }, format: 'json'
        new_student = Student.last
        new_student.name.should eq "Nia"
        new_student.address.should eq "India"
        response.should have_http_status(:ok)
      end
    end
    context 'DELETE destroy' do
      it 'should be a valid student deletion' do
        student = FactoryGirl.create(:student)
        delete :destroy, id: student.id, format: 'json'
        response.should have_http_status(:ok)
      end
    end
  end

  context 'Failure' do
    context 'GET show' do
      it 'should not show a valid student' do
        student = FactoryGirl.create(:student)
        new_student = Student.last
        get :show, id: new_student.id+1, format: 'json'
        response.should have_http_status(:not_found)
      end
    end
    context 'POST create' do
      it 'should not create a student with invalid input' do
        post :create, student: { phone_no: '1346' }, format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not create a student with nil entries' do
        post :create, student: { name: nil, phone_no: nil }, format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not create a student with invalid school id' do
        post :create, student: { school_id: nil }, format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not create a student with invalid classroom id' do
        post :create, student: { classroom_id: nil }, format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
    end
    context 'PUT update' do
      it 'should not be a valid student updation with invalid id' do
        student = FactoryGirl.create(:student)
        new_student = Student.last
        put :update, id: new_student.id+1, student: { name: 'abc', address: student.address, phone_no: student.phone_no }, format: 'json'
        response.should have_http_status(:not_found)
      end
      it 'should not be a valid student updation with invalid input' do
        student = FactoryGirl.create(:student)
        put :update, id: student.id, student: { name: 'abc', address: student.address, phone_no: nil }, format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not be a valid student updation with invalid school id' do
        student = FactoryGirl.create(:student)
        school = FactoryGirl.create(:school)
        new_school = School.last
        put :update, id: student.id, student: { standard: 'VI', school_id: new_school.id+1 }, format: 'json'
        response.should have_http_status(:not_found)
      end
      it 'should not be a valid student updation with invalid classroom id' do
        student = FactoryGirl.create(:student)
        classroom = FactoryGirl.create(:classroom)
        new_classroom = Classroom.last
        put :update, id: student.id, student: { standard: 'VI', classroom_id: new_classroom.id+1 }, format: 'json'
        response.should have_http_status(:not_found)
      end
    end
    context 'DELETE destroy' do
      it 'should not be a valid student deletion with invalid id' do
        student = FactoryGirl.create(:student)
        new_student = Student.last
        delete :destroy, id: new_student.id+1, format: 'json'
        response.should have_http_status(:not_found)
      end
    end
  end
end
