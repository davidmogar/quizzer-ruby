require 'test/unit'

require_relative '../../lib/quizzer/assessment'
require_relative '../../lib/quizzer/domain/grade'
require_relative '../../lib/quizzer/domain/questions/multichoice_question'
require_relative '../../lib/quizzer/domain/questions/numerical_question'
require_relative '../../lib/quizzer/domain/questions/true_false_question'

class AssessmentTest < Test::Unit::TestCase

  @@assessment

  def setup
    @@assessment = Assessment.new

    questions = Hash.new
    answers = Hash.new

    multichoice = MultichoiceQuestion.new(1, 'Question 1')
    multichoice.add_alternative(1, 'Alternative 1', 0)
    multichoice.add_alternative(2, 'Alternative 2', 0.75)
    questions[1] = multichoice

    numerical = NumericalQuestion.new(2, 'Question 2')
    numerical.correct = 4.3
    numerical.value_correct = 1
    numerical.value_incorrect = -0.5
    questions[2] = numerical

    truefalse = TrueFalseQuestion.new(3, 'Question 3')
    truefalse.correct = true
    truefalse.value_correct = 1
    truefalse.value_incorrect = -0.25
    questions[3] = truefalse

    answers[1] = [ Answer.new(1, 2), Answer.new(2, 4.3), Answer.new(3, true) ]
    answers[2] = [ Answer.new(1, 1), Answer.new(2, 2), Answer.new(3, false) ]
    answers[3] = [ Answer.new(1, 2), Answer.new(2, 2), Answer.new(3, true) ]

    @@assessment.questions = questions
    @@assessment.answers = answers
  end

  # Fake test
  def test_calculate_grades
    @@assessment.calculate_grades()

    assert(@@assessment.grades.length == 3, 'Unexpected grades size')
    assert_in_delta(@@assessment.grades[1].grade, 2.75, 0.05, 'Unexpected grade value for id 1')
    assert_in_delta(@@assessment.grades[2].grade, -0.75, 0.05, 'Unexpected grade value for id 2')
  end

  def test_calculate_student_grade
    assert_in_delta(@@assessment.calculate_student_grade(1), 2.75, 0.05, 'Unexpected grade value for id 1')
    assert_in_delta(@@assessment.calculate_student_grade(2), -0.75, 0.05, 'Unexpected grade value for id 2')
  end

  def test_get_statistics
    statistics = @@assessment.get_statistics()

    assert(statistics[1] == 2, 'Unexpected value for question 1 statistics')
    assert(statistics[2] == 1, 'Unexpected value for question 2 statistics')
    assert(statistics[3] == 2, 'Unexpected value for question 3 statistics')
  end

  def test_validate_grade
    assert(@@assessment.validate_grade(Grade.new(1, 2.75)), 'Unexpected grade validation result for id 1')
    assert(@@assessment.validate_grade(Grade.new(2, -0.75)), 'Unexpected grade validation result for id 2')
  end

  def test_validate_grades
    grades = Hash.new
    grades[1] = Grade.new(1, 2.75)
    grades[2] = Grade.new(2, -0.75)

    @@assessment.grades = grades
    assert(@@assessment.validate_grades(), 'Unexpected validation result. Expected a valid grade')

    grades = Hash.new
    grades[1] = Grade.new(1, 2.75)
    grades[2] = Grade.new(2, 0.25)

    @@assessment.grades = grades
    assert(!@@assessment.validate_grades(), 'Unexpected validation result. Expected a non valid grade')
  end

end