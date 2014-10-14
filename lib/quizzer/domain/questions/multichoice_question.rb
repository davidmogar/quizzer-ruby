require_relative 'question'

class MultichoiceQuestion < Question

  attr_accessor :correct, :alternatives

  def initialize(id, text)
    super(id, text)
    @alternatives = Hash.new
  end

  def add_alternative(id, text, value)
    alternatives[id] = Alternative.new(id, text, value);
  end

  def get_score(answer)
    raise ArgumentError.new('Answer cannot be nil') if (answer == nil)

    return alternatives.has_key?(answer.value)? alternatives[answer.value] : 0
  end

  class Alternative

    attr_accessor :id, :text, :value

    def initialize(id, text, value)
      @id = id
      @text = text
      @value = value
    end

  end

end