require 'json'

require_relative '../domain/test_assessment'

class TestsDeserializer

  # Deserializes the JSON representation received as arguments to a list of Test objects
  def self.deserialize(json)
    tests = Array.new

    unless json.nil?
      data = JSON.parse(json)
      if data.has_key?('tests')
        data['tests'].map do |test|
          begin
            tests << TestAssessment.new(test['quizz'], test['assessment'], test['scores'])
          end
        end
      end
    end

    return tests
  end

end