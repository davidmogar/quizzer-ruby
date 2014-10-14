require 'json'

require_relative '../domain/answer'
require_relative '../domain/questions/multichoice_question'
require_relative '../domain/questions/numerical_question'
require_relative '../domain/questions/true_false_question'

class AssessmentDeserializer

  @@question_type = {
      'multichoice' => :deserialize_multichoice,
      'numerical' => :deserialize_numerical,
      'truefalse' => :deserialize_true_false
  }

  def self.deserialize_answers(json)
    answers = Hash.new

    unless json.nil?
      data = JSON.parse(json)
      if data.has_key?('items')
        data['items'].map do |item|
          begin
            answers[item['studentId']] = item['answers'].map { |answer| Answer.new(answer['question'], answer['value']) }
          end
        end if data.has_key?('items')
      end
    end

    return answers
  end

  def self.deserialize_grades(json)
    grades = Hash.new

    unless json.nil?
      data = JSON.parse(json)
      if data.has_key?('scores')
        data['scores'].map do |grade|
          begin
            grades[grade['studentId']] = Grade.new(grade['studentId'], grade['value'])
          end
        end
      end
    end

    return grades
  end

  def self.deserialize_questions(json)
    questions = Hash.new

    unless json.nil?
      data = JSON.parse(json)
      if data.has_key?('questions')
        data['questions'].map do |question|
          begin
            questions[question['id']] = method(@@question_type[question['type']]).call(question) if data.has_key?('questionText')
          end
        end
      end
    end

    return questions
  end

  def self.deserialize_multichoice(hash)
    question = MultichoiceQuestion.new(hash['id'], hash['questionText'])

    if hash.has_key?('alternatives')
      hash['alternatives'].map do |alternative|
        if alternative.has_key?('code') && alternative.has_key?('text') && alternative.has_key?('value')
          question.add_alternative(alternative['code'], alternative['text'], alternative['value'])
        end
      end
    end

    return question
  end

  def self.deserialize_numerical(hash)
    question = TrueFalseQuestion.new(hash['id'], hash['questionText'])

    question.correct = hash['correct'] if hash.has_key?('correct')
    question.value_correct = hash['valueOK'] if hash.has_key?('valueOK')
    question.value_incorrect = hash['valueFailed'] if hash.has_key?('valueFailed')

    return question
  end

  def self.deserialize_true_false(hash)
    question = TrueFalseQuestion.new(hash['id'], hash['questionText'])

    question.correct = hash['correct'] if hash.has_key?('correct')
    question.value_correct = hash['valueOK'] if hash.has_key?('valueOK')
    question.value_incorrect = hash['valueFailed'] if hash.has_key?('valueFailed')
    question.feedback = hash['feedback'] if hash.has_key?('feedback')

    return question
  end

  private_class_method :deserialize_multichoice, :deserialize_numerical, :deserialize_true_false

end