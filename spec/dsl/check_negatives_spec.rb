require 'spec_helper'

describe 'check_negatives' do
  it 'should error if no arguments' do
    expect {
      ProfileSubject.check_negatives
    }.to raise_exception(StandardError, 'Empty fields')
  end

  it 'should accept one argument' do
    expect {
      ProfileSubject.check_negatives :number_of_friends
    }.not_to raise_exception
  end

  it 'should accept several arguments' do
    expect {
      ProfileSubject.check_negatives :number_of_friends, :number_of_points
    }.not_to raise_exception
  end

  it 'should return if negative' do
    create :profile, number_of_points: -1
    res = ProfileSubject.check_negatives :number_of_points
    res.class.should == Array
    res.first.size.should == 1
  end

  it 'should return empty if all ok' do
    create :profile, number_of_points: 1
    res = ProfileSubject.check_negatives :number_of_points
    res.class.should == Array
    res.first.size.should == 0
  end

end
