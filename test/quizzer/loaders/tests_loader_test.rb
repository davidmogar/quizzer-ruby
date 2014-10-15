require 'test/unit'

require_relative '../../../lib/quizzer/loaders/tests_loader'

class TestsLoaderTest < Test::Unit::TestCase

  @@tests_url = 'test/resources/tests.json';

  def test_load_tests
    assert(File.exist?(@@tests_url), 'Missing tests file')

    begin
      tests = TestsLoader::load_tests(@@tests_url)
      assert(tests.length == 1, 'Unexpected tests array size')
    rescue
      fail('Exception not expected')
    end
  end

end