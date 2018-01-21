require 'rails_helper'

RSpec.describe ClassroomsController, type: :controller do
  context 'Success' do
    context 'GET index' do
      it 'should show all classrooms successfully' do
        get :index, format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'GET show' do
      it 'should show classroom with given id successfully' do
        classroom = FactoryGirl.create(:classroom)
        get :show, id: classroom.id, format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'POST create' do
      it 'should be a valid classroom creation' do
        school = FactoryGirl.create(:school)
        post :create, classroom: { standard: "II", no_of_students: 55, school_id: school.id }, format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'PUT edit' do
      it 'should get correct classroom id for updation' do
        classroom = FactoryGirl.create(:classroom)
        get :edit, id: classroom.id
        response.should have_http_status(:ok)
      end
    end
    context 'PUT update' do
      it 'should be a valid classroom updation' do
        classroom = FactoryGirl.create(:classroom)
        put :update, id: classroom.id, classroom: { standard: 'VI', no_of_students: classroom.no_of_students, school_id: classroom.school_id }, format: 'json'
        new_classroom = Classroom.last
        new_classroom.standard.should eq 'VI'
        response.should have_http_status(:ok)
      end
      it 'should be a valid classroom updation' do
        classroom = FactoryGirl.create(:classroom)
        put :update, id: classroom.id, classroom: { standard: 'VI', no_of_students: 46, school_id: classroom.school_id }, format: 'json'
        new_classroom = Classroom.last
        new_classroom.standard.should eq 'VI'
        new_classroom.no_of_students.should eq 46
        response.should have_http_status(:ok)
      end
    end
    context 'DELETE destroy' do
      it 'should be a valid classroom deletion' do
        classroom = FactoryGirl.create(:classroom)
        delete :destroy, id: classroom.id, format: 'json'
        response.should have_http_status(:ok)
      end
    end
  end

  context 'Failure' do
    context 'GET show' do
      it 'should not show a valid classroom' do
        classroom = FactoryGirl.create(:classroom)
        new_classroom = Classroom.last
        get :show, id: new_classroom.id + 1, format: 'json'
        response.should have_http_status(:not_found)
      end
    end
    context 'POST create' do
      it 'should not create a classroom with invalid input' do
        post :create, classroom: { no_of_students: 500 }, format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not create a classroom with nil entries' do
        post :create, classroom: { standard: nil }, format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not create a classroom with invalid school id' do
        post :create, classroom: { school_id: 'ÁBC123' }, format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not create a classroom with invalid school id' do
        post :create, classroom: { school_id: 0 }, format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
    end
    context 'PUT update' do
      it 'should not be a valid classroom updation with invalid id' do
        classroom = FactoryGirl.create(:classroom)
        new_classroom = Classroom.last
        put :update, id: new_classroom.id+1, classroom: { standard: classroom.standard, no_of_students: classroom.no_of_students }, format: 'json'
        response.should have_http_status(:not_found)
      end
      it 'should not be a valid classroom updation with invalid input' do
        classroom = FactoryGirl.create(:classroom)
        put :update, id: classroom.id, classroom: { standard: classroom.standard, no_of_students: nil }, format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not be a valid classroom updation with invalid school id' do
        classroom = FactoryGirl.create(:classroom)
        school = FactoryGirl.create(:school)
        new_school = School.last
        put :update, id: classroom.id, classroom: { standard: 'VI', school_id: new_school.id+1 }, format: 'json'
        response.should have_http_status(:not_found)
      end
    end
    context 'DELETE destroy' do
      it 'should not be a valid classroom deletion with invalid id' do
        classroom = FactoryGirl.create(:classroom)
        new_classroom = Classroom.last
        delete :destroy, id: new_classroom.id+1, format: 'json'
        response.should have_http_status(:not_found)
      end
    end
  end
end
