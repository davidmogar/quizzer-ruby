require_relative 'question'

class NumericalQuestion < Question

  attr_accessor :correct, :value_correct, :value_incorrect

  def get_score(answer)
    raise ArgumentError.new('Answer cannot be nil') if (answer == nil)

    return (answer.value == @correct)? @value_correct : @value_incorrect
  end

end