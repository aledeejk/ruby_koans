require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutControlStatements < Neo::Koan

  def test_if_then_else_statements
    if true
      result = :true_value
    else
      result = :false_value
    end
    assert_equal :true_value, result  # Условие true → выполняется первая ветка
  end

  def test_if_then_statements
    result = :default_value
    if true
      result = :true_value
    end
    assert_equal :true_value, result  # Условие true → переменная изменяется
  end

  def test_if_statements_return_values
    value = if true
              :true_value
            else
              :false_value
            end
    assert_equal :true_value, value  # Возвращается значение из выполненной ветки

    value = if false
              :true_value
            else
              :false_value
            end
    assert_equal :false_value, value  # Условие false → выполняется else


    # NOTE: Actually, EVERY statement in Ruby will return a value, not
    # just if statements.
    # В Ruby ВСЕ выражения возвращают значение, не только if
  end

  def test_if_statements_with_no_else_with_false_condition_return_value
    value = if false
              :true_value
            end
    assert_equal nil, value  # Если условие false и нет else → возвращается nil
  end

  def test_condition_operators
    assert_equal :true_value, (true ? :true_value : :false_value)  # Тернарный оператор
    assert_equal :false_value, (false ? :true_value : :false_value)
  end

  def test_if_statement_modifiers
    result = :default_value
    result = :true_value if true  # Инлайн версия if

    assert_equal :true_value, result
  end

  def test_unless_statement
    result = :default_value
    unless false    # unless false ≡ if !false ≡ if true
      result = :false_value
    end
    assert_equal :false_value, result  # Условие false → блок выполняется
  end

  def test_unless_statement_evaluate_true
    result = :default_value
    unless true    # same as saying 'if !true', which evaluates as 'if false'
                   # unless true ≡ if !true ≡ if false
      result = :true_value
    end
    assert_equal :default_value, result  # Условие true → блок не выполняется
  end

  def test_unless_statement_modifier
    result = :default_value
    result = :false_value unless false  # Инлайн версия unless

    assert_equal :false_value, result
  end

  def test_while_statement
    i = 1
    result = 1
    while i <= 10  # Вычисляем факториал 10
      result = result * i
      i += 1
    end
    assert_equal 3628800, result  # 10! = 3628800
  end

  def test_break_statement
    i = 1
    result = 1
    while true
      break unless i <= 10  # Выход из цикла когда i > 10
      result = result * i
      i += 1
    end
    assert_equal 3628800, result  # Тот же результат - факториал 10
  end

  def test_break_statement_returns_values
    i = 1
    result = while i <= 10
      break i if i % 2 == 0  # Выход с возвратом текущего i
      i += 1
    end

    assert_equal 2, result  # Первое четное число - 2
  end

  def test_next_statement
    i = 0
    result = []
    while i < 10
      i += 1
      next if (i % 2) == 0  # Пропускаем четные числа
      result << i
    end
    assert_equal [1, 3, 5, 7, 9], result  # Только нечетные числа
  end

  def test_for_statement
    array = ["fish", "and", "chips"]
    result = []
    for item in array  # Цикл for для обхода массива
      result << item.upcase
    end
    assert_equal ["FISH", "AND", "CHIPS"], result  # Все элементы в верхнем регистре
  end

  def test_times_statement
    sum = 0
    10.times do  # Выполнить блок 10 раз
      sum += 1
    end
    assert_equal 10, sum  # 0 + 1*10 = 10
  end
end
