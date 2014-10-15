require 'pp'
class Assessment

  attr_accessor :questions, :answers, :grades

  def initialize
    @questions = Hash.new
    @answers = Hash.new
    @grades = Hash.new
  end

  def calculate_grades
    @grades = Hash.new

    answers.keys.each do |student_id|
      @grades[student_id] = Grade.new(student_id, calculate_student_grade(student_id))
    end
  end

  def calculate_student_grade(student_id)
    grade = 0

    if (@answers.has_key?(student_id))
      @answers[student_id].each do |answer|
        question_id = answer.question_id
        grade += @questions[question_id].get_score(answer) if @questions.has_key?(question_id)
      end
    end

    return grade
  end

  def get_statistics
    statistics = Hash.new

    @answers.keys.each do |student_id|
      @answers[student_id].each do |answer|
        question_id = answer.question_id

        if @questions.has_key?(question_id) && @questions[question_id].get_score(answer) > 0
          if statistics.has_key?(question_id)
            statistics[question_id] = statistics[question_id] + 1
          else
            statistics[question_id] = 1
          end
        end
      end
    end

    return statistics
  end

  def validate_grade(grade)
    valid = false

    if (!grade.nil?)
      valid = grade.grade == calculate_student_grade(grade.student_id)
    end

    return valid
  end

  def validate_grades
    valid = true

    grades.values.each do |grade|
      if !(valid = validate_grade(grade))
        break
      end
    end

    return valid
  end

end