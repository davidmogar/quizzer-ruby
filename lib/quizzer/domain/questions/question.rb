class Question

  def initialize(id, text)
    @id = id
    @text = text
  end

  def get_score(answer)
    raise 'SubclassResponsibility'
  end

end