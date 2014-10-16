require 'open-uri'

require_relative '../assessment'
require_relative '../../../lib/quizzer/deserializers/assessment_deserializer'

class AssessmentLoader

  # Returns a new Assessment created with the data obtained from the URLs received as arguments
  def self.load_assessment_from_urls(questions_url, answers_url, grades_url)
    raise ArgumentError.new('Questions and answers URLs cannot be nil') if (questions_url.nil? || answers_url.nil?)

    questions_json = fetch_url_content(questions_url)
    answers_json = fetch_url_content(answers_url)

    grades_json = nil
    if !grades_url.nil?
      grades_json = fetch_url_content(grades_url)
    end

    return create_assessment(questions_json, answers_json, grades_json)
  end

  # Returns a new Assessment created with the data obtained from the JSONs received as arguments
  def self.load_assessment_from_jsons(questions_json, answers_json, grades_json)
    raise ArgumentError.new('Questions and answers URLs cannot be nil') if (questions_json.nil? || answers_json.nil?)

    create_assessment(questions_json, answers_json, grades_json)
  end

  # Creates and returns an Assessment with the data obtained after deserialize the given JSONs
  def self.create_assessment(questions_json, answers_json, grades_json)
    assessment = Assessment.new

    assessment.questions = AssessmentDeserializer.deserialize_questions(questions_json)
    assessment.answers = AssessmentDeserializer.deserialize_answers(answers_json)
    assessment.grades = AssessmentDeserializer.deserialize_grades(grades_json) unless grades_json.nil?

    return assessment
  end

  # Fetch content from the given url
  def self.fetch_url_content(url)
    open(url) { |io| io.read } unless url.nil?
  end

  private_class_method :create_assessment, :fetch_url_content
end