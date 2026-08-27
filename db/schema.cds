namespace supplyFlow;

using {
    cuid,
    managed,
    User,
    sap.common.CodeList as CodeList
} from '@sap/cds/common';

type DeliveryStatus : String enum {
    planned    @description: 'Planned';
    in_transit @description: 'In Transit';
    delivered  @description: 'Delivered';
    delayed    @description: 'Delayed';
    cancelled  @description: 'Cancelled';
}

entity DeliveryStatuses: CodeList {
    key code: DeliveryStatus;
}

entity Suppliers : cuid, managed {
    name        : String(100) not null;
    contactName : String(100);
    email       : String(255);
    phone       : String(30);
    address     : String(255);
    deliveries  : Association to many Deliveries
                      on deliveries.supplier = $self;
}

annotate Suppliers with @assert.unique.supplierName: [ name ];

entity Deliveries : cuid, managed {
    @title                 : 'Supplier'
    @Common.Text           : supplier.name
    @Common.TextArrangement: #TextOnly
    supplier      : Association to Suppliers not null;

    @title: 'Scheduled Date'
    scheduledDate : Date not null;

    @title: 'Status'
    @Common.Text: status.name
    @Common.TextArrangement: #TextOnly
    status        : Association to DeliveryStatuses default 'planned';

    @title: 'Notes'
    notes         : String(1000);
    items         : Composition of many DeliveryItems
                        on items.delivery = $self;
    statusLog     : Composition of many DeliveryStatusLog
                        on statusLog.delivery = $self;
}

entity DeliveryItems : cuid {
    delivery : Association to Deliveries not null;

    @title: 'Item Name'
    itemName : String(100) not null;

    @title: 'Quantity'
    quantity : Integer not null;

    @title: 'Unit'
    unit     : String(20);
}

entity DeliveryStatusLog : cuid {
    delivery   : Association to Deliveries not null;

    @title: 'From Status'
    @Common.Text: fromStatus.name
    @Common.TextArrangement: #TextOnly
    fromStatus : Association to DeliveryStatuses;

    @title: 'To Status'
    @Common.Text: toStatus.name
    @Common.TextArrangement: #TextOnly
    toStatus   : Association to DeliveryStatuses not null;

    @title: 'Changed At'
    changedAt  : DateTime default $now;
    @title: 'Changed By'
    changedBy   : User;
    @title: 'Remarks'
    remarks    : String(500);
}