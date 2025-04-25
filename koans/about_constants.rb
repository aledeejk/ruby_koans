require File.expand_path(File.dirname(__FILE__) + '/neo')

C = "top level"  # Константа верхнего уровня

class AboutConstants < Neo::Koan

  C = "nested"   # Константа внутри класса

  def test_nested_constants_may_also_be_referenced_with_relative_paths
    assert_equal "nested", C  # Поиск начинается с текущей области видимости
  end

  def test_top_level_constants_are_referenced_by_double_colons
    assert_equal "top level", ::C  # :: указывает на константу верхнего уровня
  end

  def test_nested_constants_are_referenced_by_their_complete_path
    assert_equal "nested", AboutConstants::C  # Полный путь к константе
    assert_equal "nested", ::AboutConstants::C  # Абсолютный путь с ::
  end

  # ------------------------------------------------------------------

  class Animal
    LEGS = 4
    def legs_in_animal
      LEGS # Ищет константу в текущем классе
    end

    class NestedAnimal
      def legs_in_nested_animal
        LEGS  # Наследует константу из внешнего класса Animal
      end
    end
  end

  def test_nested_classes_inherit_constants_from_enclosing_classes
    assert_equal 4, Animal::NestedAnimal.new.legs_in_nested_animal
  end

  # ------------------------------------------------------------------

  class Reptile < Animal
    def legs_in_reptile
      LEGS  # Наследует константу от родительского класса
    end
  end

  def test_subclasses_inherit_constants_from_parent_classes
    assert_equal 4, Reptile.new.legs_in_reptile
  end

  # ------------------------------------------------------------------

  class MyAnimals
    LEGS = 2  # Константа в новой области видимости

    class Bird < Animal
      def legs_in_bird
        LEGS
      end
    end
  end

  def test_who_wins_with_both_nested_and_inherited_constants
    assert_equal 2, MyAnimals::Bird.new.legs_in_bird
  end

  # QUESTION: Which has precedence: The constant in the lexical scope,
  # or the constant from the inheritance hierarchy?
  # Ответ: Константа из лексической области видимости (MyAnimals::LEGS) имеет приоритет
    # над унаследованной константой (Animal::LEGS)

  # ------------------------------------------------------------------

  class MyAnimals::Oyster < Animal
    def legs_in_oyster
      LEGS
    end
  end

  def test_who_wins_with_explicit_scoping_on_class_definition
    assert_equal 4, MyAnimals::Oyster.new.legs_in_oyster
  end

  # QUESTION: Now which has precedence: The constant in the lexical
  # scope, or the constant from the inheritance hierarchy?  Why is it
  # different than the previous answer?
  # Ответ: Теперь используется унаследованная константа Animal::LEGS,
    # потому что MyAnimals::Oyster определен вне тела класса MyAnimals,
    # поэтому не видит MyAnimals::LEGS
end
