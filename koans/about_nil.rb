require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutNil < Neo::Koan
  def test_nil_is_an_object
    assert_equal true, nil.is_a?(Object), "Unlike NULL in other languages"
    # В Ruby nil - это полноценный объект, в отличие от NULL в других языках
  end

  def test_you_dont_get_null_pointer_errors_when_calling_methods_on_nil
    # What happens when you call a method that doesn't exist.  The
    # following begin/rescue/end code block captures the exception and
    # makes some assertions about it.
    begin
      nil.some_method_nil_doesnt_know_about
    rescue Exception => ex
      # What exception has been caught?
      assert_equal NoMethodError, ex.class

      # What message was attached to the exception?
      # (HINT: replace __ with part of the error message.)
      # Сообщение содержит информацию о несуществующем методе
      assert_match(/undefined method `some_method_nil_doesnt_know_about'/, ex.message)
    end
    # В Ruby вы получите NoMethodError вместо NullPointerException как в других языках
  end

  def test_nil_has_a_few_methods_defined_on_it
    assert_equal true, nil.nil?      # Проверка на nil
    assert_equal "", nil.to_s        # Преобразование в строку (пустая строка)
    assert_equal "nil", nil.inspect  # Строковое представление для отладки

    # THINK ABOUT IT:
    #
    # Is it better to use
    #    obj.nil?
    # or
    #    obj == nil
    # Why?
    # Ответ: лучше использовать obj.nil?, так как:
    # 1. Это более идиоматично для Ruby
    # 2. Работает быстрее (меньше накладных расходов)
    # 3. Читается более естественно
  end

end
