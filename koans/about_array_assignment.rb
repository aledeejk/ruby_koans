require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutArrayAssignment < Neo::Koan
  def test_non_parallel_assignment
    names = ["John", "Smith"]
    assert_equal ["John", "Smith"], names
  end

  def test_parallel_assignments
    first_name, last_name = ["John", "Smith"]
    assert_equal "John", first_name
    assert_equal "Smith", last_name
  end

  def test_parallel_assignments_with_extra_values
    first_name, last_name = ["John", "Smith", "III"] # Лишние значения игнорируются
    assert_equal "John", first_name
    assert_equal "Smith", last_name # "III" не присваивается никуда
  end

  def test_parallel_assignments_with_splat_operator
    first_name, *last_name = ["John", "Smith", "III"]  # * собирает остаток в массив
    assert_equal "John", first_name
    assert_equal ["Smith", "III"], last_name
  end

  def test_parallel_assignments_with_too_few_values
    first_name, last_name = ["Cher"] # Недостающие значения становятся nil
    assert_equal "Cher", first_name
    assert_equal nil, last_name
  end

  def test_parallel_assignments_with_subarrays
    first_name, last_name = [["Willie", "Rae"], "Johnson"]
    assert_equal ["Willie", "Rae"], first_name
    assert_equal "Johnson", last_name
  end

  def test_parallel_assignment_with_one_variable
    first_name, = ["John", "Smith"] # Запятая в переменной указывает на параллельное присваивание
    assert_equal "John", first_name
  end

  def test_swapping_with_parallel_assignment
    first_name = "Roy"
    last_name = "Rob"
    first_name, last_name = last_name, first_name
    assert_equal __, first_name
    assert_equal __, last_name
  end
end
