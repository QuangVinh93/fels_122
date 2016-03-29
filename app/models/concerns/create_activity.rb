module CreateActivity
  def create_activity user_id, lesson_id, name
    Activity.create! action: name, lesson_id: lesson_id, user_id: user_id
  end
end
