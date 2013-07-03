require 'spec_helper'

describe 'check_equal' do
  it 'should error if no arguments' do
    expect {
      ProfileSubject.check_equal
    }.to raise_exception(StandardError, 'Empty fields')
  end

  it 'should error if one argument' do
    expect {
      ProfileSubject.check_equal :number_of_friends
    }.to raise_exception(StandardError, 'Two fields required')
  end

  it 'should accept two arguments' do
    expect {
      ProfileSubject.check_equal :number_of_friends, :number_of_points
    }.not_to raise_exception
  end

  it 'should return if equal' do
    create :profile, number_of_points: 3, number_of_friends: 3
    res = ProfileSubject.check_equal :number_of_points, :number_of_friends
    res.class.should == Array
    res.size.should == 1
  end

  it 'should return empty if all ok' do
    create :profile, number_of_points: 3, number_of_friends: 2
    res = ProfileSubject.check_equal :number_of_points, :number_of_friends
    res.class.should == Array
    res.size.should == 0
  end

end
