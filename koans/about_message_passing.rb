require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutMessagePassing < Neo::Koan

  class MessageCatcher
    def caught?
      true
    end
  end

  def test_methods_can_be_called_directly
    mc = MessageCatcher.new
    assert mc.caught?  # Обычный вызов метода
  end

  def test_methods_can_be_invoked_by_sending_the_message
    mc = MessageCatcher.new
    assert mc.send(:caught?)  # Вызов метода через send с символом
  end

  def test_methods_can_be_invoked_more_dynamically
    mc = MessageCatcher.new

    assert mc.send("caught?")
    assert mc.send("caught" + "?")    # Конкатенация строк для формирования имени метода
    assert mc.send("CAUGHT?".downcase) # Приведение строки к нижнему регистру
  end

  def test_send_with_underscores_will_also_send_messages
    mc = MessageCatcher.new

    assert_equal true, mc.__send__(:caught?)

    # THINK ABOUT IT:
    #
    # Why does Ruby provide both send and __send__ ?
    # Заметка:
    # Ruby предоставляет и send, и __send__, потому что send может быть переопределен,
    # а __send__ всегда остается оригинальным методом
  end

  def test_classes_can_be_asked_if_they_know_how_to_respond
    mc = MessageCatcher.new

    assert_equal true, mc.respond_to?(:caught?) # Метод существует
    assert_equal false, mc.respond_to?(:does_not_exist) # Метод не существует
  end

  # ------------------------------------------------------------------

  class MessageCatcher
    def add_a_payload(*args)
      args
    end
  end

  def test_sending_a_message_with_arguments
    mc = MessageCatcher.new

    assert_equal [], mc.add_a_payload # Без аргументов - пустой массив
    assert_equal [], mc.send(:add_a_payload) # То же самое через send

    assert_equal [3, 4, nil, 6], mc.add_a_payload(3, 4, nil, 6) # С аргументами
    assert_equal [3, 4, nil, 6], mc.send(:add_a_payload, 3, 4, nil, 6) # Через send
  end

  # NOTE:
  #
  # Both obj.msg and obj.send(:msg) sends the message named :msg to
  # the object. We use "send" when the name of the message can vary
  # dynamically (e.g. calculated at run time), but by far the most
  # common way of sending a message is just to say: obj.msg.

  # ------------------------------------------------------------------

  class TypicalObject
  end

  def test_sending_undefined_messages_to_a_typical_object_results_in_errors
    typical = TypicalObject.new

    exception = assert_raise(NoMethodError) do
      typical.foobar # Пытаемся вызвать несуществующий метод
    end
    assert_match(/foobar/, exception.message) # Проверяем сообщение об ошибке
  end

  def test_calling_method_missing_causes_the_no_method_error
    typical = TypicalObject.new

    exception = assert_raise(NoMethodError) do
      typical.method_missing(:foobar) # Прямой вызов method_missing
    end
    assert_match(/foobar/, exception.message)

    # THINK ABOUT IT:
    #
    # If the method :method_missing causes the NoMethodError, then
    # what would happen if we redefine method_missing?
    # Заметка:
    # Если переопределить method_missing, можно изменить поведение при вызове
    # несуществующих методов. В Ruby 1.8 method_missing был public, а в 1.9+ стал private.
    #
    # NOTE:
    #
    # In Ruby 1.8 the method_missing method is public and can be
    # called as shown above. However, in Ruby 1.9 (and later versions)
    # the method_missing method is private. We explicitly made it
    # public in the testing framework so this example works in both
    # versions of Ruby. Just keep in mind you can't call
    # method_missing like that after Ruby 1.9 normally.
    #
    # Thanks.  We now return you to your regularly scheduled Ruby
    # Koans.
  end

  # ------------------------------------------------------------------

  # Класс, который перехватывает любые сообщения
  class AllMessageCatcher
    def method_missing(method_name, *args, &block)
      "Someone called #{method_name} with <#{args.join(", ")}>"
    end
  end

  def test_all_messages_are_caught
    catcher = AllMessageCatcher.new

    assert_equal "Someone called foobar with <>", catcher.foobar
    assert_equal "Someone called foobaz with <1>", catcher.foobaz(1)
    assert_equal "Someone called sum with <1, 2, 3, 4, 5, 6>", catcher.sum(1,2,3,4,5,6)
  end

  def test_catching_messages_makes_respond_to_lie
    catcher = AllMessageCatcher.new

    assert_nothing_raised do
      catcher.any_method # Метод "существует" благодаря method_missing
    end
    assert_equal false, catcher.respond_to?(:any_method) # Но respond_to? говорит false
  end

  # ------------------------------------------------------------------

  # Класс, который перехватывает только методы, начинающиеся на foo
  class WellBehavedFooCatcher
    def method_missing(method_name, *args, &block)
      if method_name.to_s[0,3] == "foo"
        "Foo to you too"
      else
        super(method_name, *args, &block)  # Передаем дальше для стандартной обработки
      end
    end
  end

  def test_foo_method_are_caught
    catcher = WellBehavedFooCatcher.new

    assert_equal "Foo to you too", catcher.foo_bar
    assert_equal "Foo to you too", catcher.foo_baz
  end

  def test_non_foo_messages_are_treated_normally
    catcher = WellBehavedFooCatcher.new

    assert_raise(NoMethodError) do
      catcher.normal_undefined_method # Не начинается на foo - получаем ошибку
    end
  end

  # ------------------------------------------------------------------

  # (note: just reopening class from above)
  # Расширяем класс, чтобы respond_to? правильно работал для foo-методов
  class WellBehavedFooCatcher
    def respond_to?(method_name)
      if method_name.to_s[0,3] == "foo"
        true  # Говорим, что foo-методы существуют
      else
        super(method_name)  # Для остальных - стандартное поведение
      end
    end
  end

  def test_explicitly_implementing_respond_to_lets_objects_tell_the_truth
    catcher = WellBehavedFooCatcher.new

    assert_equal true, catcher.respond_to?(:foo_bar) # foo-метод "существует"
    assert_equal false, catcher.respond_to?(:something_else) # Другие - нет
  end

end
