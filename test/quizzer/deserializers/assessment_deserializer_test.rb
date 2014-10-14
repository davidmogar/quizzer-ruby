require 'test/unit'

require_relative '../../../lib/quizzer/deserializers/assessment_deserializer'

class AssesmentDeserializerTest < Test::Unit::TestCase

  @@questionsJson = '{ "questions": [ { "type": "multichoice", "id" : 1, "questionText": "Scala fue creado por...",
        "alternatives": [ { "text": "Martin Odersky", "code": 1, "value": 1 }, { "text": "James Gosling", "code": 2,
        "value": -0.25 }, { "text": "Guido van Rossum", "code": 3, "value": -0.25 } ] }, { "type" : "truefalse",
        "id" : 2, "questionText": "El creador de Ruby es Yukihiro Matsumoto", "correct": true, "valueOK": 1,
        "valueFailed": -0.25, "feedback": "Yukihiro Matsumoto es el principal desarrollador de Ruby desde 1996" } ] }'

  @@answersJson = '{ "items": [ { "studentId": 234 , "answers": [ { "question" : 1, "value": 1 }, { "question" : 2,
        "value": false } ] }, { "studentId": 245 , "answers": [ { "question" : 1, "value": 1 }, { "question" : 2,
        "value": true } ] }, { "studentId": 221 , "answers": [ { "question" : 1, "value": 2 } ] } ] }'

  @@gradesJson = '{ "scores": [ { "studentId": 234, "value": 0.75 } , { "studentId": 245, "value": 2.0 } ,
        { "studentId": 221, "value": 0.75 } ] }'

  def test_deserialize_answers
    answers = AssessmentDeserializer::deserialize_answers(@@answersJson);

    assert_not_nil(answers, 'Answers is nil')

    assert(answers.length == 3, 'Unexpected size for answers map')
    assert(answers[234].length == 2, 'Unexpected size for answers of student id 234')
    assert(answers[245].length == 2, 'Unexpected size for answers of student id 245')
    assert(answers[221].length == 1, 'Unexpected size for answers of student id 221')
  end
end