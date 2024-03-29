@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Data model for online shop'
define root view entity ZI_ONLINE_SHOP_077 as select from zonlineshop_077
association [1..1] to zshop_as_077 as _Shop on
 $projection.Order_Uuid = _Shop.order_uuid {
    key order_uuid as Order_Uuid,
    order_id as Order_Id,
    ordereditem as Ordereditem,
    deliverydate as Deliverydate,
    creationdate as Creationdate,
    pkgid as PackageId,
    _Shop.costcenter as CostCenter,
    
    /*Association*/
    _Shop // Make association public
}
