# frozen_string_literal: true

class Calculator
  def add(left, right)
    left + right
  end

  def subtract(left, right)
    left - right
  end

  def multiply(left, right)
    left * right
  end

  def divide(left, right)
    raise ZeroDivisionError, "cannot divide by zero" if right.zero?

    left.fdiv(right)
  end
end
