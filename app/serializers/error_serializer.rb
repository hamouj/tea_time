class ErrorSerializer
  def initialize(error)
    @error = error.message
  end

  def validation_error
    {
      "errors": [
        {
          "status": 400,
          "title": "validation error",
          "detail": @error
        }
      ]
    }
  end

  def record_not_found_error
    {
      "errors": [
        {
          "status": 404,
          "title": "record not found",
          "detail": @error
        }
      ]
    }
  end
end
