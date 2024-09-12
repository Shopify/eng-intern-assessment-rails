require 'test_helper'

class DatabaseConnectionTest < ActiveSupport::TestCase
  test 'should connect to the database' do
    assert ActiveRecord::Base.connection.active?
  end

  test 'should retrieve records from the database' do
    records = Article.all

    assert_not_nil records
    assert records.any?, 'No records found in the database'
  end

end

