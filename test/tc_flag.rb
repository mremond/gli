require 'gli.rb'
require 'test/unit/given'
require 'option_test_helper'

include GLI
class TC_testFlag < Test::Unit::Given::TestCase
  include OptionTestHelper

  def test_basics_simple
    Given flag_with_names(:f)
    Then attributes_should_be_set
    And name_should_be(:f)
    And aliases_should_be(nil)
  end

  def test_basics_kinda_complex
    Given flag_with_names([:f])
    Then attributes_should_be_set
    And name_should_be(:f)
    And aliases_should_be(nil)
  end

  def test_basics_complex
    Given flag_with_names([:f,:file,:filename])
    Then attributes_should_be_set
    And name_should_be(:f)
    And aliases_should_be([:file,:filename])
    And {
      assert_equal ["-f VAL","--file VAL","--filename VAL",/foobar/],@flag.arguments_for_option_parser
    }
  end

  def flag_with_names(names)
    lambda do
      @options = {
        :desc => 'Filename',
        :long_desc => 'The Filename',
        :arg_name => 'file',
        :default_value => '~/.blah.rc',
        :must_match => /foobar/,
      }
      @flag = Flag.new(names,@options)
      @cli_option = @flag
    end
  end

  def attributes_should_be_set
    lambda {
      assert_equal(@options[:desc],@flag.description)
      assert_equal(@options[:long_desc],@flag.long_description)
      assert_equal(@options[:default_value],@flag.default_value)
      assert_equal(@options[:must_match],@flag.must_match)
      assert(@flag.usage != nil)
    }
  end


end
