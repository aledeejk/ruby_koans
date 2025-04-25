require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutModules < Neo::Koan
  module Nameable
    def set_name(new_name)
      @name = new_name
    end

    def here
      :in_module
    end
  end

  def test_cant_instantiate_modules
    assert_raise(NoMethodError) do
      Nameable.new  # Нельзя создавать экземпляры модулей
    end
  end

  # ------------------------------------------------------------------

  class Dog
    include Nameable # Включаем модуль в класс

    attr_reader :name

    def initialize
      @name = "Fido"
    end

    def bark
      "WOOF"
    end

    def here  
      :in_object   # Переопределяем метод из модуля
    end
  end

  def test_normal_methods_are_available_in_the_object
    fido = Dog.new
    assert_equal "WOOF", fido.bark  # Метод класса работает
  end

  def test_module_methods_are_also_available_in_the_object
    fido = Dog.new
    assert_nothing_raised do
      fido.set_name("Rover")  # Метод из модуля доступен
    end
  end

  def test_module_methods_can_affect_instance_variables_in_the_object
    fido = Dog.new
    assert_equal "Fido", fido.name  # Изначальное имя
    fido.set_name("Rover")          # Изменяем через метод модуля
    assert_equal "Rover", fido.name # Имя изменилось
  end

  def test_classes_can_override_module_methods
    fido = Dog.new
    assert_equal __, fido.here
  end
end
