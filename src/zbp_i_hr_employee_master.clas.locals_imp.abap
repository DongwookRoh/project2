*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

*CLASS lhc_travel DEFINITION INHERITING FROM cl_abap_behavior_handler.
*
*  PRIVATE SECTION.
*
**    TYPES tt_travel_update TYPE TABLE FOR UPDATE zi_travel_m_010.
*
*
*    METHODS set_status_completed       FOR MODIFY IMPORTING   keys FOR ACTION emp~journalentry              RESULT result.
**    METHODS get_features               FOR FEATURES IMPORTING keys REQUEST    requested_features FOR travel    RESULT result.
*
**    METHODS CalculateTravelKey         FOR DETERMINE ON MODIFY IMPORTING keys FOR Travel~CalculateTravelKey.
*
*
*ENDCLASS.
*
*CLASS lhc_travel IMPLEMENTATION.
*
*********************************************************************************
**
** Implements journalEntry action
**
*********************************************************************************
*  METHOD set_status_completed.
*
*    DATA: lt_je_deep TYPE TABLE FOR ACTION IMPORT i_journalentrytp~post,
*          lv_cid     TYPE abp_behv_cid.
*    TRY.
*        lv_cid = to_upper( cl_uuid_factory=>create_system_uuid( )->create_uuid_x16( ) ).
*      CATCH cx_uuid_error.
*        ASSERT 1 = 0.
*    ENDTRY.
*    APPEND INITIAL LINE TO lt_je_deep ASSIGNING FIELD-SYMBOL(<je_deep>).
*    <je_deep>-%cid = lv_cid.
*    <je_deep>-%param = VALUE #(
*    companycode = 'F001' " Success
*    documentreferenceid = 'BKPFF'
*    createdbyuser = 'TESTER'
*    businesstransactiontype = 'RFBU'
*    accountingdocumenttype = 'SA'
*    documentdate = sy-datlo
*    postingdate = sy-datlo
*    accountingdocumentheadertext = 'RAP rules'
*    _glitems = VALUE #( ( glaccountlineitem = |001| glaccount = '0000400000' _currencyamount = VALUE #( ( currencyrole = '00' journalentryitemamount = '-100.55' currency = 'JPY' ) ) )
*    ( glaccountlineitem = |002| glaccount = '0000400000' _currencyamount = VALUE #( ( currencyrole = '00' journalentryitemamount = '100.55' currency = 'JPY' ) ) ) )
*    ).
*    MODIFY ENTITIES OF i_journalentrytp
*    ENTITY journalentry
*    EXECUTE post FROM lt_je_deep
*    FAILED DATA(ls_failed_deep)
*    REPORTED DATA(ls_reported_deep)
*    MAPPED DATA(ls_mapped_deep).
*    IF ls_failed_deep IS NOT INITIAL.
**      LOOP AT ls_reported_deep-journalentry ASSIGNING FIELD-SYMBOL(ls_reported_deep).
**        DATA(lv_result) = ls_reported_deep>-%msg-if_message~get_text( ).
**        ...
**      ENDLOOP.
*    ELSE.
**      COMMIT ENTITIES BEGIN
**      RESPONSE OF i_journalentrytp
**      FAILED DATA(lt_commit_failed)
**      REPORTED DATA(lt_commit_reported).
**      ...
**      COMMIT ENTITIES END.
*    ENDIF.
*
**    " Modify in local mode: BO-related updates that are not relevant for authorization checks
**    MODIFY ENTITIES OF zi_hr_employee_master IN LOCAL MODE
**           ENTITY emp
**              UPDATE FROM VALUE #( FOR key IN keys ( mykey = key-mykey
**                                                     overall_status = 'A' " Accepted
**                                                     %control-overall_status = if_abap_behv=>mk-on ) )
**           FAILED   failed
**           REPORTED reported.
**
**    " Read changed data for action result
**    READ ENTITIES OF zi_travel_m_010 IN LOCAL MODE
**         ENTITY travel
**         FROM VALUE #( FOR key IN keys (  mykey = key-mykey
**                                          %control = VALUE #(
**                                            agency_id       = if_abap_behv=>mk-on
**                                            customer_id     = if_abap_behv=>mk-on
**                                            begin_date      = if_abap_behv=>mk-on
**                                            end_date        = if_abap_behv=>mk-on
**                                            overall_status  = if_abap_behv=>mk-on
**                                            description     = if_abap_behv=>mk-on
**                                            created_by      = if_abap_behv=>mk-on
**                                            created_at      = if_abap_behv=>mk-on
**                                            last_changed_by = if_abap_behv=>mk-on
**                                            last_changed_at = if_abap_behv=>mk-on
**                                          ) ) )
**         RESULT DATA(lt_travel).
**
**    result = VALUE #( FOR travel IN lt_travel ( mykey = travel-mykey
**                                                %param    = travel
**                                              ) ).
*
*  ENDMETHOD.
*
*ENDCLASS.
