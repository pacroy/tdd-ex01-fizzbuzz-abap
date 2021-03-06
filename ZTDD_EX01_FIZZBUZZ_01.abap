*&---------------------------------------------------------------------*
*& Report  ztdd_ex01_fizzbuzz_01
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
REPORT ztdd_ex01_fizzbuzz_01.

*----------------------------------------------------------------------*
* PRODUCTION CODE
*----------------------------------------------------------------------*
CLASS lcl_fizzbuzz01 DEFINITION.
  PUBLIC SECTION.
    METHODS say
      IMPORTING iv_input         TYPE i
      RETURNING VALUE(rv_output) TYPE string.
  PRIVATE SECTION.
    METHODS isfizz
      IMPORTING
        iv_input        TYPE i
      RETURNING
        VALUE(r_result) TYPE abap_bool.
    METHODS isbuzz
      IMPORTING
        iv_input        TYPE i
      RETURNING
        VALUE(r_result) TYPE abap_bool.
ENDCLASS.

CLASS lcl_fizzbuzz01 IMPLEMENTATION.

  METHOD say.
    CLEAR rv_output.
    IF isfizz( iv_input ) = abap_true.
      rv_output = `Fizz`.
    ENDIF.
    IF isbuzz( iv_input ) = abap_true.
      rv_output = rv_output && `Buzz`.
    ENDIF.
    IF rv_output IS INITIAL.
      rv_output = |{ iv_input }|.
    ENDIF.
  ENDMETHOD.

  METHOD isbuzz.
    r_result = boolc( iv_input MOD 5 = 0 ).
  ENDMETHOD.

  METHOD isfizz.
    r_result = boolc( iv_input MOD 3 = 0 ).
  ENDMETHOD.

ENDCLASS.

*----------------------------------------------------------------------*
* TEST CODE
*----------------------------------------------------------------------*
CLASS ltcl_fizzbuzz01 DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS get_new_fizzbuzz01
      RETURNING
        VALUE(r_result) TYPE REF TO lcl_fizzbuzz01.
    METHODS:
      get_number_when_not_multiple FOR TESTING RAISING cx_static_check,
      get_fizz_when_multiple_of_3 FOR TESTING RAISING cx_static_check,
      get_buzz_when_multiple_of_5 FOR TESTING RAISING cx_static_check,
      get_fizzbuzz_on_multiple_of_15 FOR TESTING RAISING cx_static_check.
ENDCLASS.


CLASS ltcl_fizzbuzz01 IMPLEMENTATION.

  METHOD get_new_fizzbuzz01.
    r_result = NEW lcl_fizzbuzz01( ).
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

ENDCLASS.