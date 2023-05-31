class ErrorSerializer
  def initialize(error)
    @error = error
  end

  def validation_error
    {
      "errors": [
        {
          "status": 400,
          "title": "validation error",
          "detail": @error.message.split(',').map do |message|
            message.strip
          end
        }
      ]
    }
  end
end