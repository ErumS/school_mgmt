require 'rails_helper'

RSpec.describe SubjectsController, type: :controller do
  context 'Success' do
    context 'GET index' do
      it 'should show all subjects successfully' do
        get :index, format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'GET show' do
      it 'should show subject with given id successfully' do
        subject = FactoryGirl.create(:subject)
        get :show, id: subject.id, format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'POST create' do
      it 'should be a valid subject creation' do
        post :create, subject: { name: "History", subject_duration: 2 }, format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'PUT edit' do
      it 'should get correct subject id for updation' do
        subject = FactoryGirl.create(:subject)
        get :edit, id: subject.id
        response.should have_http_status(:ok)
      end
    end
    context 'PUT update' do
      it 'should be a valid subject updation' do
        subject = FactoryGirl.create(:subject)
        put :update, id: subject.id, subject: { name: 'Nia', subject_duration: subject.subject_duration }, format: 'json'
        new_subject = Subject.last
        new_subject.name.should eq 'Nia'
        response.should have_http_status(:ok)
      end
      it 'should be a valid subject updation' do
        subject = FactoryGirl.create(:subject)
        put :update, id: subject.id, subject: { subject_duration: 3 }, format: 'json'
        new_subject = Subject.last
        new_subject.subject_duration.should eq 3
        response.should have_http_status(:ok)
      end
    end
    context 'DELETE destroy' do
      it 'should be a valid subject deletion' do
        subject = FactoryGirl.create(:subject)
        delete :destroy, id: subject.id, format: 'json'
        response.should have_http_status(:ok)
      end
    end
  end

  context 'Failure' do
    context 'GET show' do
      it 'should not show a valid subject' do
        subject = FactoryGirl.create(:subject)
        new_subject = Subject.last
        get :show, id: new_subject.id+1, format: 'json'
        response.should have_http_status(:not_found)
      end
    end
    context 'POST create' do
      it 'should not create a subject with invalid input' do
        post :create, subject: { subject_duration: 90 }, format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not create a subject with nil entries' do
        post :create, subject: { name: nil }, format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not create a subject with invalid school id' do
        post :create, subject: { school_id: nil }, format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not create a subject with invalid student id' do
        post :create, subject: { student_ids: nil }, format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
    end
    context 'PUT update' do
      it 'should not be a valid subject updation with invalid id' do
        subject = FactoryGirl.create(:subject)
        new_subject = Subject.last
        put :update, id: new_subject.id+1, subject: { name: 'abc', subject_duration: subject.subject_duration }, format: 'json'
        response.should have_http_status(:not_found)
      end
      it 'should not be a valid subject updation with invalid input' do
        subject = FactoryGirl.create(:subject)
        put :update, id: subject.id, subject: { name: 'abc', subject_duration: nil }, format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not be a valid subject updation with invalid school id' do
        subject = FactoryGirl.create(:subject)
        school = FactoryGirl.create(:school, phone_no:"76473685828")
        new_school = School.last
        put :update, id: subject.id, subject: { name: 'abc', school_id: new_school.id+1 }, format: 'json'
        response.should have_http_status(:not_found)
      end
    end
    context 'DELETE destroy' do
      it 'should not be a valid subject deletion with invalid id' do
        subject = FactoryGirl.create(:subject)
        new_subject = Subject.last
        delete :destroy, id: new_subject.id+1, format: 'json'
        response.should have_http_status(:not_found)
      end
    end
  end
end
