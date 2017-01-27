*&---------------------------------------------------------------------*
*& Report  ztdd_ex01_fizzubuzz_01
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
REPORT ztdd_ex01_fizzubuzz_01.

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
    DATA(lo_fb) = NEW lcl_fizzbuzz01( ).  "Arrange
    DATA(lv_actual) = lo_fb->say( 1 ).    "Act
    cl_abap_unit_assert=>assert_equals(   "Assert
      exp = `1`
      act = lv_actual ).
  ENDMETHOD.

ENDCLASS.

*----------------------------------------------------------------------*
* PRODUCTION CODE
*----------------------------------------------------------------------*

