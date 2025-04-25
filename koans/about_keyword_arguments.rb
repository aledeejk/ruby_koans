require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutKeywordArguments < Neo::Koan

  # Метод с именованными аргументами и значениями по умолчанию
  def method_with_keyword_arguments(one: 1, two: 'two')
    [one, two]
  end

  def test_keyword_arguments
    assert_equal Array, method_with_keyword_arguments.class # Возвращает массив
    assert_equal [1, "two"], method_with_keyword_arguments # Значения по умолчанию
    assert_equal ["one", "two"], method_with_keyword_arguments(one: 'one') # Переопределяем one
    assert_equal [1, 2], method_with_keyword_arguments(two: 2) # Переопределяем two
  end

  # Метод с обязательным позиционным и именованными аргументами
  def method_with_keyword_arguments_with_mandatory_argument(one, two: 2, three: 3)
    [one, two, three]
  end

  def test_keyword_arguments_with_wrong_number_of_arguments
    exception = assert_raise (ArgumentError) do
      method_with_keyword_arguments_with_mandatory_argument # Не указан обязательный аргумент one
    end
    assert_match(/wrong number of arguments/, exception.message) # Ожидаем ошибку о неверном числе аргументов
  end

  # Метод с обязательным именованным аргументом (без значения по умолчанию)
  def method_with_mandatory_keyword_arguments(one:, two: 'two')
    [one, two]
  end

  def test_mandatory_keyword_arguments
    assert_equal ["one", "two"], method_with_mandatory_keyword_arguments(one: 'one') # two берется по умолчанию
    assert_equal [1, 2], method_with_mandatory_keyword_arguments(two: 2, one: 1) # Порядок не важен
  end

  def test_mandatory_keyword_arguments_without_mandatory_argument
    exception = assert_raise(ArgumentError) do
      method_with_mandatory_keyword_arguments # Не указан обязательный one:
    end
    assert_match(/missing keyword/, exception.message) # Ожидаем сообщение об отсутствующем аргументе
  end
end
