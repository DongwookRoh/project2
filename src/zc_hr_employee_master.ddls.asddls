@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Data model for employee master'

@UI: {
 headerInfo: { typeName: 'Employee', typeNamePlural: 'Employees', title: { type: #STANDARD, value: 'employee_id' } } }

@Search.searchable: true

define root view entity ZC_HR_EMPLOYEE_MASTER
 as projection on ZI_HR_EMPLOYEE_MASTER
{
    @UI.facet: [ { id:              'Employee',
                     purpose:         #STANDARD,
                     type:            #IDENTIFICATION_REFERENCE,
                     label:           'Employee',
                     position:        10 } ]

    @UI.hidden: true
    key mykey,
    
    @UI: {
          lineItem:       [ { position: 10, label: 'Employee ID', importance: #HIGH } ],
          identification: [ { position: 10, label: 'EmployeeId' } ], 
          selectionField: [ { position: 10, element: 'employee_id' } ] }
    @Search.defaultSearchElement: true    
    employee_id,
    
    @UI: {
          lineItem:       [ { position: 20, label: 'Employee Name', importance: #HIGH } ],
          identification: [ { position: 20, label: 'EmployeeNm' } ],
          selectionField: [ { position: 20, element: 'employee_nm' } ] }
    @Search.defaultSearchElement: true     
    employee_nm,    
    
//    @UI: {
//          lineItem:       [ { position: 30, label: 'Employee Name2', importance: #HIGH } ],
//          identification: [ { position: 30, label: 'EmployeeNm2' } ],
//          selectionField: [ { position: 30, element: 'employee_nm2' } ] }
//    @Search.defaultSearchElement: true     
//    employee_nm2,   
    
//    @UI: {
//          lineItem:       [ { position: 40, label: 'Employee Name3', importance: #HIGH } ],
//          identification: [ { position: 40, label: 'EmployeeNm3' } ] }
//    @Search.defaultSearchElement: true     
//    employee_nm3,   
//    
//    @UI: {
//          lineItem:       [ { position: 50, label: 'Employee Name4', importance: #HIGH } ],
//          identification: [ { position: 50, label: 'EmployeeNm4' } ] }
//    @Search.defaultSearchElement: true     
//    employee_nm4,   
    
    @UI: {
          lineItem:       [ { position: 60, label: 'BeginDate', importance: #LOW } ],
          identification: [ { position: 60, label: 'BeginDate' } ] }  
    @Search.defaultSearchElement: true                
    begin_date,
    
    @UI: {
          lineItem:       [ { position: 70, label: 'EndDate', importance: #LOW } ],
          identification: [ { position: 70, label: 'EndDate' } ] }
    @Search.defaultSearchElement: true     
    end_date,


    @UI: {
          lineItem:       [ { position: 80, importance: #HIGH } ],
          identification: [ { position: 80 } ] }     
    salary_amount,  
    
    @UI: {
          lineItem:       [ { position: 90, importance: #HIGH } ],
          identification: [ { position: 90, label: 'Bonus' } ] }
    @Search.defaultSearchElement: true         
    bonus,
    
    @UI.hidden: true  
    created_by,
    
    @UI.hidden: true
    created_at,
    
    @UI.hidden: true
    last_changed_by,
    
    @UI.hidden: true
    last_changed_at    
                            
}
