require 'json'

class AssessmentJsonSerializer

  def self::serialize_grades(grades)
    scores = Array.new

    grades.each { |student_id, grade| scores << { "studentId" => student_id, "value" => grade.grade } }

    return JSON.pretty_generate({ "scores" => scores })
  end

  def self::serialize_statistics(statistics)
    items = Array.new

    statistics.each { |question_id, correct_answers| items << { "questionId" => question_id, "correctAnswers" => correct_answers } }

    return JSON.pretty_generate({ "items" => items })
  end

end