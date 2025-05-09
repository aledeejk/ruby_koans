require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutBlocks < Neo::Koan
  def method_with_block
    result = yield  # Выполняем переданный блок
    result
  end

  def test_methods_can_take_blocks
    yielded_result = method_with_block { 1 + 2 }
    assert_equal 3, yielded_result  # Блок возвращает сумму 1 + 2
  end

  def test_blocks_can_be_defined_with_do_end_too
    yielded_result = method_with_block do 1 + 2 end
    assert_equal 3, yielded_result  # Альтернативный синтаксис с do/end
  end

  # ------------------------------------------------------------------

  def method_with_block_arguments
    yield("Jim")  # Передаем аргумент в блок
  end

  def test_blocks_can_take_arguments
    method_with_block_arguments do |argument|
      assert_equal "Jim", argument  # Блок получает переданный аргумент
    end
  end

  # ------------------------------------------------------------------

  def many_yields
    yield(:peanut)   # Многократный вызов yield
    yield(:butter)
    yield(:and)
    yield(:jelly)
  end

  def test_methods_can_call_yield_many_times
    result = []
    many_yields { |item| result << item }  # Собираем все переданные значения
    assert_equal [:peanut, :butter, :and, :jelly], result
  end

  # ------------------------------------------------------------------

  def yield_tester
    if block_given?  # Проверяем, передан ли блок
      yield
    else
      :no_block
    end
  end

  def test_methods_can_see_if_they_have_been_called_with_a_block
    assert_equal :with_block, yield_tester { :with_block }  # Блок передан
    assert_equal :no_block, yield_tester  # Блок не передан
  end

  # ------------------------------------------------------------------

  def test_block_can_affect_variables_in_the_code_where_they_are_created
    value = :initial_value
    method_with_block { value = :modified_in_a_block }  # Блок изменяет внешнюю переменную
    assert_equal :modified_in_a_block, value
  end

  def test_blocks_can_be_assigned_to_variables_and_called_explicitly
    add_one = lambda { |n| n + 1 }  # Блок, сохраненный в переменную
    assert_equal 11, add_one.call(10)  # Явный вызов

    # Альтернативный синтаксис вызова
    assert_equal 11, add_one[10]
  end

  def test_stand_alone_blocks_can_be_passed_to_methods_expecting_blocks
    make_upper = lambda { |n| n.upcase }
    result = method_with_block_arguments(&make_upper)  # Передача лямбды как блока
    assert_equal "JIM", result
  end

  # ------------------------------------------------------------------

  def method_with_explicit_block(&block)
    block.call(10)  # Явный вызов переданного блока
  end

  def test_methods_can_take_an_explicit_block_argument
    assert_equal 20, method_with_explicit_block { |n| n * 2 }  # Блок умножает на 2

    add_one = lambda { |n| n + 1 }
    assert_equal 11, method_with_explicit_block(&add_one)  # Передача лямбды
  end
end
