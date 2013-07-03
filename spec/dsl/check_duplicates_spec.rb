require 'spec_helper'

describe 'check_duplicates' do
  it 'should error if no arguments' do
    expect {
      ProfileSubject.check_duplicates
    }.to raise_exception(StandardError, 'Empty fields')
  end

  it 'should accept one argument' do
    expect {
      ProfileSubject.check_duplicates :user_id
    }.not_to raise_exception
  end

  it 'should accept several arguments' do
    expect {
      ProfileSubject.check_duplicates :user_id, :provider_id
    }.not_to raise_exception
  end

  it 'should return if duplicates' do
    create :user
    create :profile, user_id: User.first.id
    create :profile, user_id: User.first.id
    res = ProfileSubject.check_duplicates :user_id
    res.class.should == Array
    res.size.should == 1
  end

  it 'should return empty if all ok' do
    create :user
    create :user
    create :profile, user_id: User.first.id
    create :profile, user_id: User.last.id
    res = ProfileSubject.check_duplicates :user_id
    res.class.should == Array
    res.size.should == 0
  end

end
