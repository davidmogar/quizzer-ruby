class Answer

  attr_accessor :question_id, :value

  def initialize(question_id, value)
    @question_id = question_id
    @value = value
  end

end