class AssessmentXmlSerializer

  def self::serialize_grades(grades)
    result = "<scores>\n"

    grades.each do |student_id, grade|
      result += "\t<score>\n\t\t<studentId>#{student_id}</studentId>\n"
      result += "\t\t<value>#{grade.grade}</value>\n\t</score>\n"
    end

    return result + '</scores>'
  end

  def self::serialize_statistics(statistics)
    result = "<statistics>\n"

    statistics.each do |question_id, correct_answers|
      result += "\t<item>\n\t\t<questionId>#{question_id}</questionId>\n"
      result += "\t\t<correctAnswers>#{correct_answers}</correctAnswers>\n\t</item>\n"
    end

    return result + '</statistics>'
  end

end