require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutHashes < Neo::Koan
  def test_creating_hashes
    empty_hash = Hash.new
    assert_equal Hash, empty_hash.class  # Класс объекта - Hash
    assert_equal({}, empty_hash)        # Литерал пустого хэша
    assert_equal 0, empty_hash.size     # Размер пустого хэша
  end

  def test_hash_literals
    hash = { :one => "uno", :two => "dos" }
    assert_equal 2, hash.size  # Хэш содержит 2 пары ключ-значение
  end

  def test_accessing_hashes
    hash = { :one => "uno", :two => "dos" }
    assert_equal "uno", hash[:one]           # Доступ по существующему ключу
    assert_equal "dos", hash[:two]
    assert_equal nil, hash[:doesnt_exist]   # Несуществующий ключ возвращает nil
  end

  def test_accessing_hashes_with_fetch
    hash = { :one => "uno" }
    assert_equal "uno", hash.fetch(:one)    # fetch для существующего ключа
    assert_raise(KeyError) do               # fetch для несуществующего ключа вызывает исключение
      hash.fetch(:doesnt_exist)
    end

    # THINK ABOUT IT:
    #
    # Why might you want to use #fetch instead of #[] when accessing hash keys?
    # fetch лучше использовать, когда:
    # 1. Нужно явно обработать отсутствие ключа
    # 2. Хотим получить исключение при отсутствии ключа
    # 3. Можем указать значение по умолчанию как второй аргумент
  end

  def test_changing_hashes
    hash = { :one => "uno", :two => "dos" }
    hash[:one] = "eins"  # Изменение значения по ключу

    expected = { :one => "eins", :two => "dos" }
    assert_equal expected, hash  # Проверка всего хэша
    # Bonus Question: Why was "expected" broken out into a variable
    # rather than used as a literal?
    # Переменная expected используется для:
    # 1. Улучшения читаемости
    # 2. Возможности повторного использования
    # 3. Упрощения отладки
  end

  def test_hash_is_unordered
    hash1 = { :one => "uno", :two => "dos" }
    hash2 = { :two => "dos", :one => "uno" }

    assert_equal true, hash1 == hash2  # Порядок элементов в хэше не важен
  end

  def test_hash_keys
    hash = { :one => "uno", :two => "dos" }
    assert_equal 2, hash.keys.size          # Количество ключей
    assert_equal true, hash.keys.include?(:one)  # Проверка наличия ключа
    assert_equal true, hash.keys.include?(:two)
    assert_equal Array, hash.keys.class     # keys возвращает массив
  end

  def test_hash_values
    hash = { :one => "uno", :two => "dos" }
    assert_equal 2, hash.values.size        # Количество значений
    assert_equal true, hash.values.include?("uno")  # Проверка наличия значения
    assert_equal true, hash.values.include?("dos")
    assert_equal Array, hash.values.class   # values возвращает массив
  end

  def test_combining_hashes
    hash = { "jim" => 53, "amy" => 20, "dan" => 23 }
    new_hash = hash.merge({ "jim" => 54, "jenny" => 26 })  # Объединение хэшей

    assert_equal true, hash != new_hash  # Исходный хэш не изменился

    expected = { "jim" => 54, "amy" => 20, "dan" => 23, "jenny" => 26 }
    assert_equal true, expected == new_hash  # Новые значения перезаписали старые
  end

  def test_default_value
    hash1 = Hash.new
    hash1[:one] = 1

    assert_equal 1, hash1[:one]
    assert_equal nil, hash1[:two]  # Значение по умолчанию - nil

    hash2 = Hash.new("dos")        # Указано значение по умолчанию
    hash2[:one] = 1

    assert_equal 1, hash2[:one]
    assert_equal "dos", hash2[:two]  # Возвращает указанное значение по умолчанию
  end

  def test_default_value_is_the_same_object
    hash = Hash.new([])  # Все значения по умолчанию - один и тот же массив

    hash[:one] << "uno"  # Изменяется общий массив
    hash[:two] << "dos"

    assert_equal ["uno", "dos"], hash[:one]  # Все ключи возвращают один массив
    assert_equal ["uno", "dos"], hash[:two]
    assert_equal ["uno", "dos"], hash[:three]

    assert_equal true, hash[:one].object_id == hash[:two].object_id  # Это один объект
  end

  def test_default_value_with_block
    hash = Hash.new {|hash, key| hash[key] = [] }  # Блок создает новый массив для каждого ключа

    hash[:one] << "uno"  # Добавление в массив для :one
    hash[:two] << "dos"  # Добавление в массив для :two

    assert_equal ["uno"], hash[:one]  # Уникальный массив для :one
    assert_equal ["dos"], hash[:two]  # Уникальный массив для :two
    assert_equal [], hash[:three]     # Новый пустой массив для нового ключа
  end

  def test_default_value_attribute
    hash = Hash.new

    assert_equal nil, hash[:some_key]  # Значение по умолчанию не установлено

    hash.default = 'peanut'  # Установка значения по умолчанию

    assert_equal 'peanut', hash[:some_key]  # Теперь возвращает 'peanut'
  end
end