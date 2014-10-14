class Grade

  attr_accessor :student_id, :grade

  def initialize(student_id, grade)
    @student_id = student_id
    @grade = grade
  end

end