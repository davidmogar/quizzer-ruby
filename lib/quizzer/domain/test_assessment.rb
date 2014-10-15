class TestAssessment

  attr_accessor :questions_url, :answers_url, :grades_url

  def initialize(questions_url, answers_url, grades_url)
    @questions_url = questions_url
    @answers_url= answers_url
    @grades_url = grades_url
  end

end