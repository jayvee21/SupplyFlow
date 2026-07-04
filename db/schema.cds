namespace supplyFlow;

using { cuid, managed } from '@sap/cds/common';

type DeliveryStatus : String enum {
    planned;
    in_transit;
    delivered;
    delayed;
    cancelled;
}

entity Suppliers : cuid, managed {
    name        : String(100) not null;
    contactName : String(100);
    email       : String(255);
    phone       : String(30);
    address     : String(255);
    deliveries  : Association to many Deliveries on deliveries.supplier = $self;
}

entity Deliveries : cuid, managed {
    supplier        : Association to Suppliers not null;
    scheduledDate   : Date not null;
    status          : DeliveryStatus default 'planned';
    notes           : String(1000);
    items           : Composition of many DeliveryItems on items.delivery = $self;
    statusLog       : Composition of many DeliveryStatusLog on statusLog.delivery = $self;
}

entity DeliveryItems : cuid {
    delivery    : Association to Deliveries not null;
    itemName    : String(100) not null;
    quantity    : Integer not null;
    unit        : String(20);
}

entity DeliveryStatusLog : cuid {
    delivery    : Association to Deliveries not null;
    fromStatus  : DeliveryStatus;
    toStatus    : DeliveryStatus not null;
    changedAt   : DateTime default $now;
    remarks    : String(500);
}