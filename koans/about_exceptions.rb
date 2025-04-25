require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutExceptions < Neo::Koan

  class MySpecialError < RuntimeError
  end

  def test_exceptions_inherit_from_Exception
    assert_equal RuntimeError, MySpecialError.ancestors[1]
    assert_equal StandardError, MySpecialError.ancestors[2]
    assert_equal Exception, MySpecialError.ancestors[3]
    assert_equal Object, MySpecialError.ancestors[4]
    # Иерархия наследования:
    # MySpecialError -> RuntimeError -> StandardError -> Exception -> Object
  end

  def test_rescue_clause
    result = nil
    begin
      fail "Oops"  # Синтаксический сахар для raise
    rescue StandardError => ex
      result = :exception_handled
    end

    assert_equal :exception_handled, result  # Исключение было обработано

    assert_equal true, ex.is_a?(StandardError), "Should be a Standard Error"
    assert_equal true, ex.is_a?(RuntimeError),  "Should be a Runtime Error"

    assert RuntimeError.ancestors.include?(StandardError),
      "RuntimeError is a subclass of StandardError"

    assert_equal "Oops", ex.message  # Сообщение из исключения
  end

  def test_raising_a_particular_error
    result = nil
    begin
      raise MySpecialError, "My Message"  # Выбрасываем конкретное исключение
    rescue MySpecialError => ex
      result = :exception_handled
    end

    assert_equal :exception_handled, result  # Исключение было поймано
    assert_equal "My Message", ex.message    # Сообщение сохраняется
  end

  def test_ensure_clause
    result = nil
    begin
      fail "Oops"
    rescue StandardError
      # Блок rescue может быть пустым
    ensure
      result = :always_run  # Ensure выполняется всегда
    end

    assert_equal :always_run, result  # Блок ensure сработал
  end

  # Sometimes, we must know about the unknown
  def test_asserting_an_error_is_raised
    # A do-end is a block, a topic to explore more later
    assert_raise(___) do
      raise MySpecialError.new("New instances can be raised directly.")
    end
  end

end
