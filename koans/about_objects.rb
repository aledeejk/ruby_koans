require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutObjects < Neo::Koan
  def test_everything_is_an_object
    assert_equal true, 1.is_a?(Object)      # Числа - объекты
    assert_equal true, 1.5.is_a?(Object)    # Дробные числа - объекты
    assert_equal true, "string".is_a?(Object) # Строки - объекты
    assert_equal true, nil.is_a?(Object)     # nil - тоже объект
    assert_equal true, Object.is_a?(Object)  # Даже класс Object - это объект
  end


  def test_objects_can_be_converted_to_strings
    assert_equal "123", 123.to_s    # Число в строку
    assert_equal "", nil.to_s       # nil в пустую строку
  end

  def test_objects_can_be_inspected
    assert_equal "123", 123.inspect    # inspect для числа возвращает его строковое представление
    assert_equal "nil", nil.inspect    # inspect для nil возвращает "nil"
  end

  def test_every_object_has_an_id
    obj = Object.new
    assert_equal Integer, obj.object_id.class  # ID объекта - целое число
  end

  def test_every_object_has_different_id
    obj = Object.new
    another_obj = Object.new
    assert_equal true, obj.object_id != another_obj.object_id  # Каждый объект имеет уникальный ID
  end

  def test_small_integers_have_fixed_ids
    # В Ruby object_id для чисел соответствует формуле: число*2 + 1
    assert_equal 1, 0.object_id     # 0*2 + 1 = 1
    assert_equal 3, 1.object_id     # 1*2 + 1 = 3
    assert_equal 5, 2.object_id     # 2*2 + 1 = 5
    assert_equal 201, 100.object_id # 100*2 + 1 = 201

    # THINK ABOUT IT:
    # What pattern do the object IDs for small integers follow?
  end

  def test_clone_creates_a_different_object
    obj = Object.new
    copy = obj.clone

    assert_equal true, obj != copy             # Клон - это другой объект
    assert_equal true, obj.object_id != copy.object_id  # С другим ID
  end
end
