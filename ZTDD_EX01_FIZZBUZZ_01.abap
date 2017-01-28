*&---------------------------------------------------------------------*
*& Report  ztdd_ex01_fizzubuzz_01
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
REPORT ztdd_ex01_fizzubuzz_01.

*----------------------------------------------------------------------*
* PRODUCTION CODE
*----------------------------------------------------------------------*
CLASS lcl_fizzbuzz01 DEFINITION.
  PUBLIC SECTION.
    METHODS say
      IMPORTING iv_input         TYPE i
      RETURNING VALUE(rv_output) TYPE string.
ENDCLASS.

CLASS lcl_fizzbuzz01 IMPLEMENTATION.

  METHOD say.
    IF iv_input = 5.
      rv_output = `Buzz`.
      RETURN.
    ENDIF.
    IF iv_input = 3.
      rv_output = `Fizz`.
      RETURN.
    ENDIF.
    rv_output = |{ iv_input }|.
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
      get_buzz_when_multiple_of_5 FOR TESTING RAISING cx_static_check.
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
  ENDMETHOD.

  METHOD get_buzz_when_multiple_of_5.
    DATA(lo_fb) = get_new_fizzbuzz01( ).
    cl_abap_unit_assert=>assert_equals(
      exp = `Buzz`
      act = lo_fb->say( 5 ) ).
  ENDMETHOD.

ENDCLASS.