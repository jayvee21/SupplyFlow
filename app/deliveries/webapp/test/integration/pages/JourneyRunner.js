sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"supplyflow/deliveries/deliveries/test/integration/pages/DeliveriesList",
	"supplyflow/deliveries/deliveries/test/integration/pages/DeliveriesObjectPage",
	"supplyflow/deliveries/deliveries/test/integration/pages/DeliveryItemsObjectPage"
], function (JourneyRunner, DeliveriesList, DeliveriesObjectPage, DeliveryItemsObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('supplyflow/deliveries/deliveries') + '/test/flp.html#app-preview',
        pages: {
			onTheDeliveriesList: DeliveriesList,
			onTheDeliveriesObjectPage: DeliveriesObjectPage,
			onTheDeliveryItemsObjectPage: DeliveryItemsObjectPage
        },
        async: true
    });

    return runner;
});

