require 'test/unit'
require 'open-uri'

require_relative '../../../lib/quizzer/deserializers/tests_deserializer'

class TestsDeserializerTest < Test::Unit::TestCase

  @@tests_url = 'test/resources/tests.json'

  def test_load_assessment_from_urls
    assert(File.exist?(@@tests_url), 'Missing tests file')

    tests = TestsDeserializer::deserialize(open(@@tests_url) { |io| io.read })

    assert(tests.length == 1, 'Unexpected size for tests array')
    assert(tests[0].questions_url == 'test/resources/questions.json')
    assert(tests[0].grades_url == 'test/resources/grades.json')
  end

end