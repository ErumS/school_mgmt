require 'rails_helper'

RSpec.describe Classroom, type: :model do
  context 'Validations' do
    context 'Success' do
      it 'should be a valid classroom with entries from FactoryGirl' do
        FactoryGirl.build(:classroom).should be_valid
      end
      it 'should be a valid classroom with manual entries' do
        FactoryGirl.build(:classroom, standard: 'II', no_of_students: 50).should be_valid
      end
    end

    context 'Failure' do
      it 'should not be a valid classroom with nil no_of_students' do
        FactoryGirl.build(:classroom, standard: 'II', no_of_students: nil).should_not be_valid
      end
      it 'should not be a valid classroom with invalid no_of_students greater than 60' do
        FactoryGirl.build(:classroom, standard: 'II', no_of_students: 500).should_not be_valid
      end
      it 'should not be a valid classroom with nil standard' do
        FactoryGirl.build(:classroom, standard: nil).should_not be_valid
      end
      it 'should not be a valid classroom with nil no_of_students' do
        FactoryGirl.build(:classroom, no_of_students: nil).should_not be_valid
      end
      it 'should not be a valid classroom with nil standard and no_of_students' do
        FactoryGirl.build(:classroom, standard: nil, no_of_students: nil).should_not be_valid
      end
      it 'should not be a valid classroom with invalid no_of_students' do
        FactoryGirl.build(:classroom, standard: 'II', no_of_students: 'abc').should_not be_valid
      end
      it 'should not be a valid classroom with invalid no_of_students less than 10' do
        FactoryGirl.build(:classroom, standard: 'II', no_of_students: 1).should_not be_valid
      end
    end
  end

  context 'Associations' do
    context 'Success' do
      it 'should belongs to school' do
        school = FactoryGirl.create(:school, phone_no: '3344556677')
        classroom = FactoryGirl.create(:classroom, school_id: school.id)
        classroom.school.id.should eq school.id
      end
      it 'should have many students' do
        classroom = FactoryGirl.create(:classroom)
        student1 = FactoryGirl.create(:student, classroom_id: classroom.id)
        student2 = FactoryGirl.create(:student, classroom_id: classroom.id)
        classroom.students.should include student1
        classroom.students.should include student2
      end
      it 'should have many teachers' do
        classroom = FactoryGirl.create(:classroom)
        teacher1 = FactoryGirl.create(:teacher, classroom_id: classroom.id)
        teacher2 = FactoryGirl.create(:teacher, classroom_id: classroom.id)
        classroom.teachers.should include teacher1
        classroom.teachers.should include teacher2
      end
    end

    context 'Failure' do
      it 'should not belongs to school' do
        school1 = FactoryGirl.create(:school, phone_no: '3344556677')
        school2 = FactoryGirl.create(:school, phone_no: '3344556677')
        classroom1 = FactoryGirl.create(:classroom, school_id: school1.id)
        classroom2 = FactoryGirl.create(:classroom, school_id: school2.id)
        classroom1.school.id.should eq school1.id
        classroom1.school.id.should_not eq school2.id
        classroom2.school.id.should eq school2.id
        classroom2.school.id.should_not eq school1.id
      end
      it 'should not have students as single object of classroom' do
        classroom = FactoryGirl.create(:classroom)
        expect { classroom.students }.to_not raise_exception
        expect { classroom.student }.to raise_exception
      end
      it 'should not have teachers as single object of classroom' do
        classroom = FactoryGirl.create(:classroom)
        expect { classroom.teachers }.to_not raise_exception
        expect { classroom.teacher }.to raise_exception
      end
    end
  end
end
