@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Data model for employee master'
define root view entity ZI_HR_EMPLOYEE_MASTER as select from ztb_hr_emp_m
{
    key mykey,
    employee_id,
    employee_nm,
    begin_date,
    end_date,
    salary_amount,
    bonus,    
    
//    overall_status,
    
    @Semantics.user.createdBy: true
    created_by,
    @Semantics.systemDateTime.createdAt: true
    created_at,
    @Semantics.user.lastChangedBy: true
    last_changed_by,
    @Semantics.systemDateTime.lastChangedAt: true
    last_changed_at 
}
