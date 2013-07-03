require 'spec_helper'

describe 'check_nil' do
  it 'should error if no arguments' do
    expect {
      UserSubject.check_nil
    }.to raise_exception(StandardError, 'Empty fields')
  end

  it 'should accept one argument' do
    expect {
      UserSubject.check_nil :name
    }.not_to raise_exception
  end

  it 'should accept several arguments' do
    expect {
      UserSubject.check_nil :name, :email
    }.not_to raise_exception
  end

  it 'should return if field is nil' do
    create :user, name: nil
    res = UserSubject.check_nil(:name)
    res.class.should == Array
    res.first.size.should == 1
  end

  it 'should do nothing if field is no nil' do
    create :user
    res = UserSubject.check_nil(:name)
    res.class.should == Array
    res.first.size.should == 0
  end
end
