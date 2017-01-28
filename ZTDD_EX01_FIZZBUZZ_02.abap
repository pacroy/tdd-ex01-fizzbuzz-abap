*&---------------------------------------------------------------------*
*& Report  ztdd_ex01_fizzbuzz_02
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
REPORT ztdd_ex01_fizzbuzz_02.

*----------------------------------------------------------------------*
* PRODUCTION CODE
*----------------------------------------------------------------------*
INTERFACE lif_rule.
  METHODS isvalid
    IMPORTING
      iv_input        TYPE i
    RETURNING
      VALUE(r_result) TYPE abap_bool.
  METHODS say
    RETURNING
      VALUE(rv_output) TYPE string.
ENDINTERFACE.

CLASS lcl_fizzrule DEFINITION.
  PUBLIC SECTION.
    INTERFACES lif_rule.
    ALIASES isvalid FOR lif_rule~isvalid.
    ALIASES say FOR lif_rule~say.
ENDCLASS.

CLASS lcl_fizzrule IMPLEMENTATION.

  METHOD lif_rule~isvalid.
    r_result = boolc( iv_input MOD 3 = 0 ).
  ENDMETHOD.

  METHOD lif_rule~say.
    rv_output = `Fizz`.
  ENDMETHOD.

ENDCLASS.

CLASS lcl_buzzrule DEFINITION.
  PUBLIC SECTION.
    INTERFACES lif_rule.
    ALIASES isvalid FOR lif_rule~isvalid.
    ALIASES say FOR lif_rule~say.
ENDCLASS.

CLASS lcl_buzzrule IMPLEMENTATION.

  METHOD lif_rule~isvalid.
    r_result = boolc( iv_input MOD 5 = 0 ).
  ENDMETHOD.

  METHOD lif_rule~say.
    rv_output = `Buzz`.
  ENDMETHOD.

ENDCLASS.

CLASS lcl_wowrule DEFINITION.
  PUBLIC SECTION.
    INTERFACES lif_rule.
    ALIASES isvalid FOR lif_rule~isvalid.
    ALIASES say FOR lif_rule~say.
ENDCLASS.

CLASS lcl_wowrule IMPLEMENTATION.

  METHOD lif_rule~isvalid.
    r_result = boolc( iv_input MOD 7 = 0 ).
  ENDMETHOD.

  METHOD lif_rule~say.
    rv_output = `Wow`.
  ENDMETHOD.

ENDCLASS.

CLASS lcl_fizzbuzz02 DEFINITION.
  PUBLIC SECTION.
    TYPES: tt_rule TYPE STANDARD TABLE OF REF TO lif_rule WITH EMPTY KEY.

    METHODS say
      IMPORTING iv_input         TYPE i
      RETURNING VALUE(rv_output) TYPE string.
    METHODS set_rule
      IMPORTING it_rule TYPE tt_rule.

  PRIVATE SECTION.
    DATA at_rule TYPE STANDARD TABLE OF REF TO lif_rule WITH EMPTY KEY.
ENDCLASS.

CLASS lcl_fizzbuzz02 IMPLEMENTATION.

  METHOD say.
    CLEAR rv_output.
    LOOP AT at_rule INTO DATA(lo_rule).
      IF lo_rule->isvalid( iv_input ) = abap_true.
        rv_output = rv_output && lo_rule->say( ).
      ENDIF.
    ENDLOOP.
    IF rv_output IS INITIAL.
      rv_output = |{ iv_input }|.
    ENDIF.
  ENDMETHOD.

  METHOD set_rule.
    at_rule = it_rule.
  ENDMETHOD.

ENDCLASS.

*----------------------------------------------------------------------*
* TEST CODE
*----------------------------------------------------------------------*
CLASS ltcl_fizzbuzz02 DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS get_new_fizzbuzz01
      RETURNING
        VALUE(r_result) TYPE REF TO lcl_fizzbuzz02.
    METHODS:
      get_number_when_not_multiple FOR TESTING RAISING cx_static_check,
      get_fizz_when_multiple_of_3 FOR TESTING RAISING cx_static_check,
      get_buzz_when_multiple_of_5 FOR TESTING RAISING cx_static_check,
      get_fizzbuzz_on_multiple_of_15 FOR TESTING RAISING cx_static_check,
      get_wow_when_multiple_of_7 FOR TESTING RAISING cx_static_check,
      get_fizzwow_when_mult_of_21 FOR TESTING RAISING cx_static_check,
      get_buzzwow_when_mult_of_35 FOR TESTING RAISING cx_static_check,
      get_fizzbuzzwow_when_mof_105 FOR TESTING RAISING cx_static_check.
ENDCLASS.


CLASS ltcl_fizzbuzz02 IMPLEMENTATION.

  METHOD get_new_fizzbuzz01.
    DATA lt_rule TYPE lcl_fizzbuzz02=>tt_rule.

    r_result = NEW lcl_fizzbuzz02( ).
    lt_rule = VALUE #( ( NEW lcl_fizzrule( ) )
                       ( NEW lcl_buzzrule( ) )
                       ( NEW lcl_wowrule( ) ) ).
    r_result->set_rule( lt_rule ).
  ENDMETHOD.

  METHOD get_number_when_not_multiple.
    DATA(lo_fb) = get_new_fizzbuzz01( ).
    cl_abap_unit_assert=>assert_equals(
      exp = `1`
      act = lo_fb->say( 1 ) ).
    cl_abap_unit_assert=>assert_equals(
      exp = `2`
      act = lo_fb->say( 2 ) ).
  ENDMETHOD.

  METHOD get_fizz_when_multiple_of_3.
    DATA(lo_fb) = get_new_fizzbuzz01( ).
    cl_abap_unit_assert=>assert_equals(
      exp = `Fizz`
      act = lo_fb->say( 3 ) ).
    cl_abap_unit_assert=>assert_equals(
      exp = `Fizz`
      act = lo_fb->say( 6 ) ).
  ENDMETHOD.

  METHOD get_buzz_when_multiple_of_5.
    DATA(lo_fb) = get_new_fizzbuzz01( ).
    cl_abap_unit_assert=>assert_equals(
      exp = `Buzz`
      act = lo_fb->say( 5 ) ).
    cl_abap_unit_assert=>assert_equals(
      exp = `Buzz`
      act = lo_fb->say( 10 ) ).
  ENDMETHOD.

  METHOD get_fizzbuzz_on_multiple_of_15.
    DATA(lo_fb) = get_new_fizzbuzz01( ).
    cl_abap_unit_assert=>assert_equals(
      exp = `FizzBuzz`
      act = lo_fb->say( 15 ) ).
    cl_abap_unit_assert=>assert_equals(
      exp = `FizzBuzz`
      act = lo_fb->say( 30 ) ).
  ENDMETHOD.

  METHOD get_wow_when_multiple_of_7.
    DATA(lo_fb) = get_new_fizzbuzz01( ).
    cl_abap_unit_assert=>assert_equals(
      exp = `Wow`
      act = lo_fb->say( 7 ) ).
    cl_abap_unit_assert=>assert_equals(
      exp = `Wow`
      act = lo_fb->say( 14 ) ).
  ENDMETHOD.

  METHOD get_buzzwow_when_mult_of_35.
    DATA(lo_fb) = get_new_fizzbuzz01( ).
    cl_abap_unit_assert=>assert_equals(
      exp = `BuzzWow`
      act = lo_fb->say( 35 ) ).
    cl_abap_unit_assert=>assert_equals(
      exp = `BuzzWow`
      act = lo_fb->say( 70 ) ).
  ENDMETHOD.

  METHOD get_fizzbuzzwow_when_mof_105.
    DATA(lo_fb) = get_new_fizzbuzz01( ).
    cl_abap_unit_assert=>assert_equals(
      exp = `FizzBuzzWow`
      act = lo_fb->say( 105 ) ).
    cl_abap_unit_assert=>assert_equals(
      exp = `FizzBuzzWow`
      act = lo_fb->say( 210 ) ).
  ENDMETHOD.

  METHOD get_fizzwow_when_mult_of_21.
    DATA(lo_fb) = get_new_fizzbuzz01( ).
    cl_abap_unit_assert=>assert_equals(
      exp = `FizzWow`
      act = lo_fb->say( 21 ) ).
    cl_abap_unit_assert=>assert_equals(
      exp = `FizzWow`
      act = lo_fb->say( 42 ) ).
  ENDMETHOD.

ENDCLASS.