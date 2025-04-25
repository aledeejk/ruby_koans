# Triangle Project Code.

def triangle(a, b, c)
  # Проверка на недопустимые значения сторон
  if [a, b, c].any? { |side| side <= 0 }
    raise TriangleError, "Стороны должны быть положительными"
  end

  # Сортируем стороны для проверки неравенства треугольника
  sides = [a, b, c].sort

  # Проверка неравенства треугольника
  if sides[0] + sides[1] <= sides[2]
    raise TriangleError, "Не выполняется неравенство треугольника"
  end

  # Определение типа треугольника
  if a == b && b == c
    :equilateral
  elsif a == b || b == c || a == c
    :isosceles
  else
    :scalene
  end
end

# Error class used in part 2
class TriangleError < StandardError
end