using { supplyFlow  } from '../db/schema';

service AdminService {
    entity Suppliers as projection on supplyFlow.Suppliers;
    @Capabilities.DeleteRestrictions.Deletable: false
    entity Deliveries as projection on supplyFlow.Deliveries actions {
        action markDelivered() returns Deliveries;
    }
    entity DeliveryItems as projection on supplyFlow.DeliveryItems;
    @readonly
    entity DeliveryStatusLog as projection on supplyFlow.DeliveryStatusLog;
}