require 'test/unit'

require_relative '../../../lib/quizzer/loaders/assessment_loader'

class AssessmentDeserializerTest < Test::Unit::TestCase

  @@questions_url = 'resources/questions.json';
  @@answers_url = 'resources/answers.json';
  @@grades__url = 'resources/grades.json';

  def test_load_assessment_from___urls
    assert(File.exist?(@@questions_url), 'Missing questions file')
    assert(File.exist?(@@answers_url), 'Missing answers file')
    assert(File.exist?(@@grades__url), 'Missing grades file')

    begin
      AssessmentLoader::load_assessment_from_urls(@@questions_url, @@answers_url, @@grades__url)
      AssessmentLoader::load_assessment_from_urls(@@questions_url, @@answers_url, nil)
    rescue
      fail('Exception not expected')
    end
  end

end