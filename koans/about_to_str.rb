require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutToStr < Neo::Koan

  class CanNotBeTreatedAsString
    def to_s
      "non-string-like"  # Просто возвращает строковое представление
    end
  end

  def test_to_s_returns_a_string_representation
    not_like_a_string = CanNotBeTreatedAsString.new
    assert_equal "non-string-like", not_like_a_string.to_s
    # Проверяем, что to_s возвращает строку "non-string-like"
  end

  def test_normally_objects_cannot_be_used_where_strings_are_expected
    assert_raise(TypeError) do
      File.exist?(CanNotBeTreatedAsString.new)
      # File.exist? ожидает строку, а наш объект не может быть автоматически преобразован в строку
      # поэтому возникает TypeError
    end
  end

  # ------------------------------------------------------------------

  class CanBeTreatedAsString
    def to_s
      "string-like"  # Обычное строковое представление
    end

    def to_str
      to_s  # Метод для неявного преобразования в строку
    end
  end

  def test_to_str_also_returns_a_string_representation
    like_a_string = CanBeTreatedAsString.new
    assert_equal "string-like", like_a_string.to_str
    # to_str возвращает то же, что и to_s - "string-like"
  end

  def test_to_str_allows_objects_to_be_treated_as_strings
    assert_equal false, File.exist?(CanBeTreatedAsString.new)
    # Благодаря to_str наш объект может быть использован там, где ожидается строка
    # File.exist? возвращает false, так как файла с таким именем не существует
  end

  # ------------------------------------------------------------------

  def acts_like_a_string?(string)
    string = string.to_str if string.respond_to?(:to_str)
    string.is_a?(String)
    # Метод проверяет, можно ли объект считать строкой:
    # 1. Если есть to_str, используем его для преобразования
    # 2. Проверяем, является ли результат строкой
  end

  def test_user_defined_code_can_check_for_to_str
    assert_equal false, acts_like_a_string?(CanNotBeTreatedAsString.new)
    # CanNotBeTreatedAsString не имеет to_str, поэтому не считается строкой
    
    assert_equal true, acts_like_a_string?(CanBeTreatedAsString.new)
    # CanBeTreatedAsString имеет to_str, поэтому считается строкой
  end
end
