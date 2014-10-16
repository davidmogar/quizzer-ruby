require 'quizzer/version'

require_relative '../lib/quizzer/loaders/assessment_loader'
require_relative '../lib/quizzer/loaders/tests_loader'
require_relative '../lib/quizzer/serializers/assessment_serializer'

module Quizzer
  class Quizzer

    def calculate_grades(questions_url, answers_url)
      assessment = nil

      begin
        assessment = AssessmentLoader::load_assessment_from_urls(questions_url, answers_url, nil)
        assessment.calculate_grades;
      end

      return assessment
    end

    def show_grades(grades, format)
      puts 'Assessment\'s grades'
      puts AssessmentSerializer::serialize_grades(grades, format)
      puts
    end

    def show_statistics(statistics, format)
      puts 'Assessment\'s statistics'
      puts AssessmentSerializer::serialize_statistics(statistics, format)
      puts
    end

    def validate_assessments(url)
      valid = true;

      TestsLoader::load_tests(url).each do |test|
        begin
          assessment = AssessmentLoader::load_assessment_from_urls(test.questions_url,
              test.answers_url, test.grades_url)
          if assessment.validate_grades
            puts 'Test valid'
          else
            valid = false
            puts 'Test not valid'
          end
        rescue
          valid = false;
        end
      end

      return valid
    end

  end
end
