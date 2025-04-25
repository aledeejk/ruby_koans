require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutOpenClasses < Neo::Koan
  class Dog
    def bark
      "WOOF"
    end
  end

  def test_as_defined_dogs_do_bark
    fido = Dog.new
    assert_equal "WOOF", fido.bark  # Проверяем исходное поведение
  end

  # ------------------------------------------------------------------

  # Открываем существующий класс Dog и добавляем новый метод
  class Dog
    def wag
      "HAPPY"
    end
  end

  def test_after_reopening_dogs_can_both_wag_and_bark
    fido = Dog.new
    assert_equal "HAPPY", fido.wag  # Новый метод
    assert_equal "WOOF", fido.bark  # Старый метод сохранился
  end
  
  # ------------------------------------------------------------------

  class ::Integer
    def answer_to_life_universe_and_everything?
      self == 42
    end
  end

  def test_even_existing_built_in_classes_can_be_reopened
    assert_equal __, 1.answer_to_life_universe_and_everything?
    assert_equal __, 42.answer_to_life_universe_and_everything?
  end

  # NOTE: To understand why we need the :: before Integer, you need to
  # become enlightened about scope.
end
