require 'spec_helper'

describe 'check_references' do
  it 'should error if no arguments' do
    expect {
      ProfileSubject.check_references
    }.to raise_exception(StandardError, 'Empty fields')
  end

  it 'should accept one argument' do
    expect {
      ProfileSubject.check_references :user
    }.not_to raise_exception
  end

  it 'should accept several arguments' do
    expect {
      ProfileSubject.check_references :user, :provider
    }.not_to raise_exception
  end

  it 'should return if bad references' do
    create :profile, user_id: 0
    res = ProfileSubject.check_references :user
    res.class.should == Array
    res.first.size.should == 1
  end

  it 'should return empty if all ok' do
    create :user
    create :profile, user_id: User.first.id
    res = ProfileSubject.check_references :user
    res.class.should == Array
    res.first.size.should == 0
  end

end
