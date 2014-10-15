require_relative 'question'

class TrueFalseQuestion < Question

  attr_accessor :correct, :value_correct, :value_incorrect, :feedback

  def get_score(answer)
    raise ArgumentError.new('Answer cannot be nil') if answer.nil?

    return (answer.value == @correct)? @value_correct : @value_incorrect
  end

end