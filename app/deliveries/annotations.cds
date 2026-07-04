using AdminService as service from '../../srv/admin-service';

annotate service.Deliveries with @(
    UI.SelectionFields: [
        scheduledDate,
        status_code
    ],
    UI.LineItem: [
        { Value: supplier_ID},
        { Value : scheduledDate },
        { Value : status_code },
        { Value : notes }
    ],
    UI.HeaderInfo: {
        TypeName: 'Delivery',
        TypeNamePlural: 'Deliveries',
        Title: { Value: supplier_ID },
        Description: { Value: scheduledDate }
    },
    UI.Facets: [
        {
            $Type: 'UI.ReferenceFacet',
            Label: 'General Information',
            Target: '@UI.FieldGroup#GeneralInfo'
        },
        {
            $Type: 'UI.ReferenceFacet',
            Label: 'Items',
            Target: 'items/@UI.LineItem'
        },
        {
            $Type: 'UI.ReferenceFacet',
            Label: 'Status History',
            Target: 'statusLog/@UI.LineItem'
        }
    ],
    UI.FieldGroup#GeneralInfo: {
        Data: [
            { Value: supplier_ID },
            { Value: scheduledDate },
            { Value: status_code }
        ]
    }
);



annotate service.DeliveryItems with @(
    UI.LineItem: [
        { Value: itemName },
        { Value: quantity },
        { Value: unit}
    ]
);

annotate service.DeliveryStatusLog with @(
    UI.LineItem: [
        { Value: fromStatus_code },
        { Value: toStatus_code },
        { Value: changedAt },
        { Value: remarks }
    ]
)