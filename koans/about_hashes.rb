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
    assert_equal __, hash.keys.size
    assert_equal __, hash.keys.include?(:one)
    assert_equal __, hash.keys.include?(:two)
    assert_equal __, hash.keys.class
  end

  def test_hash_values
    hash = { :one => "uno", :two => "dos" }
    assert_equal __, hash.values.size
    assert_equal __, hash.values.include?("uno")
    assert_equal __, hash.values.include?("dos")
    assert_equal __, hash.values.class
  end

  def test_combining_hashes
    hash = { "jim" => 53, "amy" => 20, "dan" => 23 }
    new_hash = hash.merge({ "jim" => 54, "jenny" => 26 })

    assert_equal __, hash != new_hash

    expected = { "jim" => __, "amy" => 20, "dan" => 23, "jenny" => __ }
    assert_equal __, expected == new_hash
  end

  def test_default_value
    hash1 = Hash.new
    hash1[:one] = 1

    assert_equal __, hash1[:one]
    assert_equal __, hash1[:two]

    hash2 = Hash.new("dos")
    hash2[:one] = 1

    assert_equal __, hash2[:one]
    assert_equal __, hash2[:two]
  end

  def test_default_value_is_the_same_object
    hash = Hash.new([])

    hash[:one] << "uno"
    hash[:two] << "dos"

    assert_equal __, hash[:one]
    assert_equal __, hash[:two]
    assert_equal __, hash[:three]

    assert_equal __, hash[:one].object_id == hash[:two].object_id
  end

  def test_default_value_with_block
    hash = Hash.new {|hash, key| hash[key] = [] }

    hash[:one] << "uno"
    hash[:two] << "dos"

    assert_equal __, hash[:one]
    assert_equal __, hash[:two]
    assert_equal __, hash[:three]
  end

  def test_default_value_attribute
    hash = Hash.new

    assert_equal __, hash[:some_key]

    hash.default = 'peanut'

    assert_equal __, hash[:some_key]
  end
end
