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
    assert_equal __, 0.object_id
    assert_equal __, 1.object_id
    assert_equal __, 2.object_id
    assert_equal __, 100.object_id

    # THINK ABOUT IT:
    # What pattern do the object IDs for small integers follow?
  end

  def test_clone_creates_a_different_object
    obj = Object.new
    copy = obj.clone

    assert_equal __, obj           != copy
    assert_equal __, obj.object_id != copy.object_id
  end
end
