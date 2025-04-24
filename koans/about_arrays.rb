require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutArrays < Neo::Koan
  def test_creating_arrays
    empty_array = Array.new
    assert_equal Array, empty_array.class # Класс - Array
    assert_equal 0, empty_array.size # Размер пустого массива - 0
  end

  def test_array_literals
    array = Array.new
    assert_equal [], array

    array[0] = 1
    assert_equal [1], array

    array[1] = 2
    assert_equal [1, 2], array

    array << 333
    assert_equal [1, 2, 333], array
  end

  def test_accessing_array_elements
    array = [:peanut, :butter, :and, :jelly]

    assert_equal :peanut, array[0]
    assert_equal :peanut, array.first
    assert_equal :jelly, array[3]
    assert_equal :jelly, array.last
    assert_equal :jelly, array[-1]
    assert_equal :butter, array[-3]
  end

  def test_slicing_arrays
    array = [:peanut, :butter, :and, :jelly]

    assert_equal [:peanut], array[0,1]
    assert_equal [:peanut, :butter], array[0,2]
    assert_equal [:and, :jelly], array[2,2]
    assert_equal [:and, :jelly], array[2,20] # Запрошено больше элементов чем есть
    assert_equal [], array[4,0] # За пределами массива - пустой массив
    assert_equal [], array[4,100] # За пределами массива - пустой массив
    assert_equal nil, array[5,0] # Если начальный индекс за пределами - nil
  end

  def test_arrays_and_ranges
    assert_equal Range, (1..5).class  # Диапазон - это отдельный класс
    assert_not_equal [1,2,3,4,5], (1..5)  # Диапазон не равен массиву
    assert_equal [1,2,3,4,5], (1..5).to_a  # Преобразование диапазона в массив
    assert_equal [1,2,3,4], (1...5).to_a   # Троеточие исключает конечное значение
  end
  def test_slicing_with_ranges
    array = [:peanut, :butter, :and, :jelly]

    assert_equal [:peanut, :butter, :and], array[0..2]  # Включительно (0,1,2)
    assert_equal [:peanut, :butter], array[0...2]       # Исключая последний (0,1)
    assert_equal [:and, :jelly], array[2..-1]           # От индекса 2 до конца
  end

  def test_pushing_and_popping_arrays
    array = [1,2]
    array.push(:last) # Добавление элемента в конец

    assert_equal [1, 2, :last], array

    popped_value = array.pop
    assert_equal :last, popped_value # pop удаляет и возвращает последний элемент
    assert_equal [1, 2], array        # Массив после удаления
  end

  def test_shifting_arrays
    array = [1,2]
    array.unshift(:first) # Добавление элемента в начало

    assert_equal [:first, 1, 2], array

    shifted_value = array.shift
    assert_equal :first, shifted_value  # shift удаляет и возвращает первый элемент
    assert_equal [1, 2], array         # Массив после удаления
  end

end
