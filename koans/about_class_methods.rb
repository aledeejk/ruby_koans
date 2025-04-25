require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutClassMethods < Neo::Koan
  class Dog
  end

  def test_objects_are_objects
    fido = Dog.new
    assert_equal true, fido.is_a?(Object)  # Все объекты наследуют от Object
  end

  def test_classes_are_classes
    assert_equal true, Dog.is_a?(Class)  # Класс Dog является классом
  end

  def test_classes_are_objects_too
    assert_equal true, Dog.is_a?(Object)  # Классы тоже объекты (в Ruby всё объекты)
  end

  def test_objects_have_methods
    fido = Dog.new
    assert fido.methods.size > 0  # Объекты имеют методы (наследуют от Object)
  end

  def test_classes_have_methods
    assert Dog.methods.size > 0  # Классы тоже имеют методы
  end

  def test_you_can_define_methods_on_individual_objects
    fido = Dog.new
    def fido.wag  # Определяем метод только для объекта fido
      :fidos_wag
    end
    assert_equal :fidos_wag, fido.wag  # Метод доступен только fido
  end

  def test_other_objects_are_not_affected_by_these_singleton_methods
    fido = Dog.new
    rover = Dog.new
    def fido.wag
      :fidos_wag
    end

    assert_raise(NoMethodError) do
      rover.wag  # У rover нет этого метода
    end
  end

  # ------------------------------------------------------------------

  class Dog2
    def wag  # Обычный метод экземпляра
      :instance_level_wag
    end
  end

  def Dog2.wag  # Метод класса (классовый метод)
    :class_level_wag
  end

  def test_since_classes_are_objects_you_can_define_singleton_methods_on_them_too
    assert_equal :class_level_wag, Dog2.wag  # Вызов классового метода
  end

  def test_class_methods_are_independent_of_instance_methods
    fido = Dog2.new
    assert_equal :instance_level_wag, fido.wag  # Метод экземпляра
    assert_equal :class_level_wag, Dog2.wag     # Метод класса
  end

  # ------------------------------------------------------------------

  class Dog
    attr_accessor :name  # Создает методы name и name= для экземпляров

    def self.name  # Метод класса для Dog
      @name
    end
  end

  def test_classes_and_instances_do_not_share_instance_variables
    fido = Dog.new
    fido.name = "Fido"  # Устанавливаем переменную экземпляра @name для fido
    assert_equal "Fido", fido.name  # Читаем из fido
    assert_equal nil, Dog.name      # @name класса Dog не установлен
  end

  # ------------------------------------------------------------------

  class Dog
    def Dog.a_class_method # Еще один способ определения классового метода
      :dogs_class_method
    end
  end

  def test_you_can_define_class_methods_inside_the_class
    assert_equal :dogs_class_method, Dog.a_class_method
  end

  # ------------------------------------------------------------------

  LastExpressionInClassStatement = class Dog
                                     21   # Последнее выражение в определении класса
                                   end

                                   def test_class_statements_return_the_value_of_their_last_expression
                                    assert_equal 21, LastExpressionInClassStatement  # Возвращается 21
                                  end

  # ------------------------------------------------------------------

  SelfInsideOfClassStatement = class Dog
                                 self  # self внутри класса - это сам класс
                               end

                               def test_self_while_inside_class_is_class_object_not_instance
                                assert_equal true, Dog == SelfInsideOfClassStatement  # self внутри класса - это класс
                              end

  # ------------------------------------------------------------------

  class Dog
    def self.class_method2  # Предпочтительный способ определения классовых методов
      :another_way_to_write_class_methods
    end
  end

  def test_you_can_use_self_instead_of_an_explicit_reference_to_dog
    assert_equal :another_way_to_write_class_methods, Dog.class_method2
  end

  # ------------------------------------------------------------------

  class Dog
    class << self
      def another_class_method
        :still_another_way
      end
    end
  end

  def test_heres_still_another_way_to_write_class_methods
    assert_equal __, Dog.another_class_method
  end

  # THINK ABOUT IT:
  #
  # The two major ways to write class methods are:
  #   class Demo
  #     def self.method
  #     end
  #
  #     class << self
  #       def class_methods
  #       end
  #     end
  #   end
  #
  # Which do you prefer and why?
  # Are there times you might prefer one over the other?

  # ------------------------------------------------------------------

  def test_heres_an_easy_way_to_call_class_methods_from_instance_methods
    fido = Dog.new
    assert_equal __, fido.class.another_class_method
  end

end
