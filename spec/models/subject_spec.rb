require 'rails_helper'

RSpec.describe Subject, type: :model do
  context 'Validations' do
    context 'Success' do
      it 'should be a valid subject with entries from FactoryGirl' do
        FactoryGirl.build(:subject).should be_valid
      end
      it 'should be a valid subject with manual entries' do
        FactoryGirl.build(:subject, name: 'History', subject_duration: 3).should be_valid
      end
    end

    context 'Failure' do
      it 'should not be a valid subject with nil subject_duration' do
        FactoryGirl.build(:subject, name: 'History', subject_duration: nil).should_not be_valid
      end
      it 'should not be a valid subject with invalid subject_duration greater than 8' do
        FactoryGirl.build(:subject, name: 'History', subject_duration: 399).should_not be_valid
      end
      it 'should not be a valid subject with nil name' do
        FactoryGirl.build(:subject, name: nil).should_not be_valid
      end
      it 'should not be a valid subject with nil subject_duration' do
        FactoryGirl.build(:subject, subject_duration: nil).should_not be_valid
      end
      it 'should not be a valid subject with nil name and subject_duration' do
        FactoryGirl.build(:subject, name: nil, subject_duration: nil).should_not be_valid
      end
      it 'should not be a valid subject with invalid subject_duration' do
        FactoryGirl.build(:subject, name: 'History', subject_duration: 'abc').should_not be_valid
      end
      it 'should not be a valid subject with invalid subject_duration less than 1' do
        FactoryGirl.build(:subject, name: 'History', subject_duration: 0).should_not be_valid
      end
    end
  end

  context 'Associations' do
    context 'Success' do
      it 'should belongs to school' do
        school = FactoryGirl.create(:school, phone_no: '3344556677')
        subject = FactoryGirl.create(:subject, school_id: school.id)
        subject.school.id.should eq school.id
      end
      it 'should have many students' do
        subject = FactoryGirl.create(:subject)
        student1 = FactoryGirl.create(:student, subject_ids: subject.id)
        student2 = FactoryGirl.create(:student, subject_ids: subject.id)
        subject.students.should include student1
        subject.students.should include student2
      end
      it 'should have many teachers' do
        subject = FactoryGirl.create(:subject)
        teacher1 = FactoryGirl.create(:teacher, subject_id: subject.id)
        teacher2 = FactoryGirl.create(:teacher, subject_id: subject.id)
        subject.teachers.should include teacher1
        subject.teachers.should include teacher2
      end
    end

    context 'Failure' do
      it 'should not belongs to school' do
        school1 = FactoryGirl.create(:school, phone_no: '3344556677')
        school2 = FactoryGirl.create(:school, phone_no: '3344556677')
        subject1 = FactoryGirl.create(:subject, school_id: school1.id)
        subject2 = FactoryGirl.create(:subject, school_id: school2.id)
        subject1.school.id.should eq school1.id
        subject1.school.id.should_not eq school2.id
        subject2.school.id.should eq school2.id
        subject2.school.id.should_not eq school1.id
      end
      it 'should not have students as single object of subject' do
        subject = FactoryGirl.create(:subject)
        expect { subject.students }.to_not raise_exception
        expect { subject.student }.to raise_exception
      end
      it 'should not have teachers as single object of subject' do
        subject = FactoryGirl.create(:subject)
        expect { subject.teachers }.to_not raise_exception
        expect { subject.teacher }.to raise_exception
      end
    end
  end
end
