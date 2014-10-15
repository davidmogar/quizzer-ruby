require_relative '../../../lib/quizzer/deserializers/tests_deserializer'

class TestsLoader

  def self.load_tests(tests_url)
    raise ArgumentError.new('Tests URL cannot be nil') if tests_url.nil?

    tests_json = open(tests_url) { |io| io.read }

    return TestsDeserializer::deserialize(tests_json)
  end

end