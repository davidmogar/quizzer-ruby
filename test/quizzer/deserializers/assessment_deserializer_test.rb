require 'test/unit'

require_relative '../../../lib/quizzer/deserializers/assessment_deserializer'

class AssessmentDeserializerTest < Test::Unit::TestCase

  @@questions_json = '{ "questions": [ { "type": "multichoice", "id" : 1, "questionText": "Scala fue creado por...",
        "alternatives": [ { "text": "Martin Odersky", "code": 1, "value": 1 }, { "text": "James Gosling", "code": 2,
        "value": -0.25 }, { "text": "Guido van Rossum", "code": 3, "value": -0.25 } ] }, { "type" : "truefalse",
        "id" : 2, "questionText": "El creador de Ruby es Yukihiro Matsumoto", "correct": true, "valueOK": 1,
        "valueFailed": -0.25, "feedback": "Yukihiro Matsumoto es el principal desarrollador de Ruby desde 1996" } ] }'

  @@answers_json = '{ "items": [ { "studentId": 234 , "answers": [ { "question" : 1, "value": 1 }, { "question" : 2,
        "value": false } ] }, { "studentId": 245 , "answers": [ { "question" : 1, "value": 1 }, { "question" : 2,
        "value": true } ] }, { "studentId": 221 , "answers": [ { "question" : 1, "value": 2 } ] } ] }'

  @@grades_json = '{ "scores": [ { "studentId": 234, "value": 0.75 } , { "studentId": 245, "value": 2.0 } ,
        { "studentId": 221, "value": 0.75 } ] }'

  def test_deserialize_answers
    answers = AssessmentDeserializer::deserialize_answers(@@answers_json)

    assert_not_nil(answers, 'Answers is nil')
    assert(answers.length == 3, 'Unexpected size for answers map')
    assert(answers[234].length == 2, 'Unexpected size for answers of student id 234')
    assert(answers[245].length == 2, 'Unexpected size for answers of student id 245')
    assert(answers[221].length == 1, 'Unexpected size for answers of student id 221')
  end

  def test_deserialize_grades
    grades = AssessmentDeserializer::deserialize_grades(@@grades_json)

    assert_not_nil(grades, 'Grades is nil')
    assert(grades.length == 3, 'Unexpected size for grades map')
    assert_in_delta(grades[234].grade, 0.75, 0.05, 'Grade value for id 234 doesn\'t match')
    assert_in_delta(grades[245].grade, 2, 0.05, 'Grade alue for id 245 doesn\'t match')
    assert_in_delta(grades[221].grade, 0.75, 0.05, 'Grade alue for id 221 doesn\'t match')
  end

  def test_deserialize_questions
    questions = AssessmentDeserializer::deserialize_questions(@@questions_json)

    assert_not_nil(questions, 'Questions is nil')
    assert(questions.length == 2, 'Unexpected size for questions map')
    assert(questions[1].instance_of?(MultichoiceQuestion), 'Unexpected type for question 1')
    assert(questions[2].instance_of?(TrueFalseQuestion), 'Unexpected type for question 2')
    assert(questions[2].correct, 'Unexpected value for question 2')

    answers = AssessmentDeserializer::deserialize_answers(@@answers_json)
    assert_in_delta(questions[1].get_score(answers[234][0]), 1, 0.05, 'Unexpected score for answer 1 of student 234')
  end

end
