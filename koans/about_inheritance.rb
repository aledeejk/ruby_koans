require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutInheritance < Neo::Koan
  class Dog
    attr_reader :name

    def initialize(name)
      @name = name
    end

    def bark
      "WOOF"
    end
  end

  class Chihuahua < Dog
    def wag
      :happy
    end

    def bark
      "yip"
    end
  end

  def test_subclasses_have_the_parent_as_an_ancestor
    assert_equal true, Chihuahua.ancestors.include?(Dog)  # Chihuahua наследует от Dog
  end

  def test_all_classes_ultimately_inherit_from_object
    assert_equal true, Chihuahua.ancestors.include?(Object)  # Все классы наследуют от Object
  end

  def test_subclasses_inherit_behavior_from_parent_class
    chico = Chihuahua.new("Chico")
    assert_equal "Chico", chico.name  # Метод name унаследован от Dog
  end

  def test_subclasses_add_new_behavior
    chico = Chihuahua.new("Chico")
    assert_equal :happy, chico.wag  # Chihuahua добавляет новый метод wag

    assert_raise(NoMethodError) do
      fido = Dog.new("Fido")
      fido.wag  # У Dog нет метода wag
    end
  end

  def test_subclasses_can_modify_existing_behavior
    chico = Chihuahua.new("Chico")
    assert_equal "yip", chico.bark  # Chihuahua переопределяет bark

    fido = Dog.new("Fido")
    assert_equal "WOOF", fido.bark  # Dog имеет оригинальный bark
  end

  # ------------------------------------------------------------------

  class BullDog < Dog
    def bark
      super + ", GROWL"   # super вызывает метод bark родительского класса
    end
  end

  def test_subclasses_can_invoke_parent_behavior_via_super
    ralph = BullDog.new("Ralph")
    assert_equal "WOOF, GROWL", ralph.bark  # Комбинация родительского и дочернего метода
  end

  # ------------------------------------------------------------------

  class GreatDane < Dog
    def growl
      super.bark + ", GROWL"  # Неправильное использование super
    end
  end

  def test_super_does_not_work_cross_method
    george = GreatDane.new("George")
    assert_raise(NoMethodError) do
      george.growl  # super в growl пытается вызвать несуществующий метод
    end
  end

end
