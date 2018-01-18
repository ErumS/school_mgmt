require 'rails_helper'

RSpec.describe School, type: :model do
  context 'Validations' do
    context 'Success' do
      it 'should be a valid school' do
        FactoryGirl.build(:school, name: 'Inox', address: 'University', phone_no: '444444443').should be_valid
      end
      it 'should be a valid school' do
        FactoryGirl.build(:school, phone_no: '5588745437895').should be_valid
      end
    end

    context 'Failure' do
      it 'should not be a valid school' do
        FactoryGirl.build(:school, name: 'Inox', address: 'University', phone_no: '44434').should_not be_valid
      end
      it 'should not be a valid school' do
        FactoryGirl.build(:school, phone_no: '44434678783487387874755').should_not be_valid
      end
      it 'should not be a valid school' do
        FactoryGirl.build(:school, address: nil).should_not be_valid
      end
      it 'should not be a valid school' do
        FactoryGirl.build(:school, name: nil).should_not be_valid
      end
      it 'should not be a valid school' do
        FactoryGirl.build(:school, phone_no: nil).should_not be_valid
      end
      it 'should not be a valid school' do
        FactoryGirl.build(:school, address: nil, phone_no: nil).should_not be_valid
      end
      it 'should not be a valid school' do
        FactoryGirl.build(:school, name: nil, address: nil).should_not be_valid
      end
      it 'should not be a valid school' do
        FactoryGirl.build(:school, name: nil, phone_no: nil).should_not be_valid
      end
      it 'should not be a valid school' do
        FactoryGirl.build(:school, name: nil, address: nil, phone_no: nil).should_not be_valid
      end
      it 'should not be a valid school' do
        FactoryGirl.build(:school, phone_no: 454_545).should_not be_valid
      end
    end
  end

  context 'Associations' do
    context 'Success' do
      it 'should have many classrooms' do
        school = FactoryGirl.create(:school, phone_no: '467574378')
        classroom1 = FactoryGirl.create(:classroom, school_id: school.id)
        classroom2 = FactoryGirl.create(:classroom, school_id: school.id)
        school.classrooms.should include classroom1
        school.classrooms.should include classroom2
      end
      it 'should have many students' do
        school = FactoryGirl.create(:school, phone_no: '467574378')
        student1 = FactoryGirl.create(:student, school_id: school.id)
        student2 = FactoryGirl.create(:student, school_id: school.id)
        school.students.should include student1
        school.students.should include student2
      end
      it 'should have many subjects' do
        school = FactoryGirl.create(:school, phone_no: '467574378')
        subject1 = FactoryGirl.create(:subject, school_id: school.id)
        subject2 = FactoryGirl.create(:subject, school_id: school.id)
        school.subjects.should include subject1
        school.subjects.should include subject2
      end
      it 'should have many teachers' do
        school = FactoryGirl.create(:school, phone_no: '467574378')
        teacher1 = FactoryGirl.create(:teacher, school_id: school.id)
        teacher2 = FactoryGirl.create(:teacher, school_id: school.id)
        school.teachers.should include teacher1
        school.teachers.should include teacher2
      end
    end

    context 'Failure' do
      it 'should not have many classrooms' do
        school = FactoryGirl.create(:school, phone_no: '467574378')
        expect { school.classrooms }.to_not raise_exception
        expect { school.classroom }.to raise_exception
      end
      it 'should not have many students' do
        school = FactoryGirl.create(:school, phone_no: '467574378')
        expect { school.students }.to_not raise_exception
        expect { school.student }.to raise_exception
      end
      it 'should not have many subjects' do
        school = FactoryGirl.create(:school, phone_no: '467574378')
        expect { school.subjects }.to_not raise_exception
        expect { school.subject }.to raise_exception
      end
      it 'should not have many teachers' do
        school = FactoryGirl.create(:school, phone_no: '467574378')
        expect { school.teachers }.to_not raise_exception
        expect { school.teacher }.to raise_exception
      end
    end
  end
end
