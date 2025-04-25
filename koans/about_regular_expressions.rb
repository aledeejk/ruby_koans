# -*- coding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutRegularExpressions < Neo::Koan
  def test_a_pattern_is_a_regular_expression
    assert_equal Regexp, /pattern/.class  # Регулярные выражения имеют класс Regexp
  end

  def test_a_regexp_can_search_a_string_for_matching_content
    assert_equal "match", "some matching content"[/match/]  # Находит подстроку
  end

  def test_a_failed_match_returns_nil
    assert_equal nil, "some matching content"[/missing/]  # Если нет совпадения - nil
  end

  # ------------------------------------------------------------------

  def test_question_mark_means_optional
    assert_equal "ab", "abbcccddddeeeee"[/ab?/]  # "b" - 0 или 1 раз
    assert_equal "a", "abbcccddddeeeee"[/az?/]   # "z" нет, но "a" есть
  end

  def test_plus_means_one_or_more
    assert_equal "bccc", "abbcccddddeeeee"[/bc+/]  # "c" - 1 или более раз
  end

  def test_asterisk_means_zero_or_more
    assert_equal "abb", "abbcccddddeeeee"[/ab*/]  # "b" - 0 или более раз
    assert_equal "a", "abbcccddddeeeee"[/az*/]    # "z" нет, но "a" есть
    assert_equal "", "abbcccddddeeeee"[/z*/]      # Пустое совпадение (0 раз)

    # THINK ABOUT IT:
    #
    # When would * fail to match?
    # * не совпадет только если нужно конкретное совпадение, а не пустая строка
  end

  # THINK ABOUT IT:
  #
  # We say that the repetition operators above are "greedy."
  #
  # Why?
  # Жадность означает, что операторы стараются захватить как можно больше символов

  # ------------------------------------------------------------------

  def test_the_left_most_match_wins
    assert_equal "a", "abbccc az"[/az*/]  # Первое возможное совпадение
  end

  # ------------------------------------------------------------------

  def test_character_classes_give_options_for_a_character
    animals = ["cat", "bat", "rat", "zat"]
    assert_equal ["cat", "bat", "rat"], animals.select { |a| a[/[cbr]at/] }  # Любой из c,b,r
  end

  def test_slash_d_is_a_shortcut_for_a_digit_character_class
    assert_equal "42", "the number is 42"[/[0123456789]+/]  # Любая цифра
    assert_equal "42", "the number is 42"[/\d+/]            # То же через \d
  end

  def test_character_classes_can_include_ranges
    assert_equal "42", "the number is 42"[/[0-9]+/]  # Диапазон цифр
  end

  def test_slash_s_is_a_shortcut_for_a_whitespace_character_class
    assert_equal " \t\n", "space: \t\n"[/\s+/]  # Пробельные символы
  end

  def test_slash_w_is_a_shortcut_for_a_word_character_class
    # NOTE:  This is more like how a programmer might define a word.
    assert_equal __, "variable_1 = 42"[/[a-zA-Z0-9_]+/]
    assert_equal __, "variable_1 = 42"[/\w+/]
  end

  def test_period_is_a_shortcut_for_any_non_newline_character
    assert_equal __, "abc\n123"[/a.+/]
  end

  def test_a_character_class_can_be_negated
    assert_equal __, "the number is 42"[/[^0-9]+/]
  end

  def test_shortcut_character_classes_are_negated_with_capitals
    assert_equal __, "the number is 42"[/\D+/]
    assert_equal __, "space: \t\n"[/\S+/]
    # ... a programmer would most likely do
    assert_equal __, "variable_1 = 42"[/[^a-zA-Z0-9_]+/]
    assert_equal __, "variable_1 = 42"[/\W+/]
  end

  # ------------------------------------------------------------------

  def test_slash_a_anchors_to_the_start_of_the_string
    assert_equal __, "start end"[/\Astart/]
    assert_equal __, "start end"[/\Aend/]
  end

  def test_slash_z_anchors_to_the_end_of_the_string
    assert_equal __, "start end"[/end\z/]
    assert_equal __, "start end"[/start\z/]
  end

  def test_caret_anchors_to_the_start_of_lines
    assert_equal __, "num 42\n2 lines"[/^\d+/]
  end

  def test_dollar_sign_anchors_to_the_end_of_lines
    assert_equal __, "2 lines\nnum 42"[/\d+$/]
  end

  def test_slash_b_anchors_to_a_word_boundary
    assert_equal __, "bovine vines"[/\bvine./]
  end

  # ------------------------------------------------------------------

  def test_parentheses_group_contents
    assert_equal __, "ahahaha"[/(ha)+/]
  end

  # ------------------------------------------------------------------

  def test_parentheses_also_capture_matched_content_by_number
    assert_equal __, "Gray, James"[/(\w+), (\w+)/, 1]
    assert_equal __, "Gray, James"[/(\w+), (\w+)/, 2]
  end

  def test_variables_can_also_be_used_to_access_captures
    assert_equal __, "Name:  Gray, James"[/(\w+), (\w+)/]
    assert_equal __, $1
    assert_equal __, $2
  end

  # ------------------------------------------------------------------

  def test_a_vertical_pipe_means_or
    grays = /(James|Dana|Summer) Gray/
    assert_equal __, "James Gray"[grays]
    assert_equal __, "Summer Gray"[grays, 1]
    assert_equal __, "Jim Gray"[grays, 1]
  end

  # THINK ABOUT IT:
  #
  # Explain the difference between a character class ([...]) and alternation (|).

  # ------------------------------------------------------------------

  def test_scan_is_like_find_all
    assert_equal __, "one two-three".scan(/\w+/)
  end

  def test_sub_is_like_find_and_replace
    assert_equal __, "one two-three".sub(/(t\w*)/) { $1[0, 1] }
  end

  def test_gsub_is_like_find_and_replace_all
    assert_equal __, "one two-three".gsub(/(t\w*)/) { $1[0, 1] }
  end
end
