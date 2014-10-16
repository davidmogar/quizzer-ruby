require 'erb'
require 'sinatra'
require 'sinatra/base'

require_relative '../lib/quizzer/loaders/assessment_loader'
require_relative '../lib/quizzer/serializers/assessment_serializer'

class Server < Sinatra::Base

  get '/' do
    erb :index
  end

  post '/' do
    questions_json = params[:questions]
    answers_json = params[:answers]

    json_grades = 'Invalid input'

    unless (questions_json.nil? || answers_json.nil?)
      begin
        assessment = AssessmentLoader.load_assessment_from_jsons(questions_json, answers_json, nil)
        assessment.calculate_grades
        json_grades = AssessmentSerializer.serialize_grades(assessment.grades, 'json')
      end
    end

    erb :grades, :locals => {:grades => json_grades}
  end

end