class Question

  def initialize(id, text)
    @id = id
    @text = text
  end

  # Calculates the score obtained by an student given its answer
  def get_score(answer)
    raise 'SubclassResponsibility'
  end

end