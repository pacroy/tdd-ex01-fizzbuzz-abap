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
    METHODS:
      first_test FOR TESTING RAISING cx_static_check.
ENDCLASS.


CLASS ltcl_fizzbuzz01 IMPLEMENTATION.

  METHOD first_test.
    DATA(lo_fb) = NEW lcl_fizzbuzz01( ).
    cl_abap_unit_assert=>assert_equals(
      exp = `1`
      act = lo_fb->say( 1 ) ).
    cl_abap_unit_assert=>assert_equals(
      exp = `2`
      act = lo_fb->say( 2 ) ).
  ENDMETHOD.

ENDCLASS.