class CardNumberError < ArgumentError
  def message
    "Wrong number of Cards!"
  end
end

class NotCardError < ArgumentError
  def message
    "Adding something that is not a card."
  end
end

class InvalidCardError < ArgumentError
  def message
    "That card does not exist."
  end
end