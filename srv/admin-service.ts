import cds from "@sap/cds";

export default class AdminServiceImpl extends cds.ApplicationService {
    async init() {
        this.on('markDelivered', 'Deliveries', async (req) => {
            const deliveryId = (req.params[0] as { ID : string }).ID;

            const delivery = await SELECT.one
                .from('supplyFlow.Deliveries')
                .where({ ID: deliveryId});

            if (!delivery) {
                return req.reject(404, `Delivery with ID ${deliveryId} not found`); 
            }

            const fromStatus = delivery.status;
            if (fromStatus === 'delivered' || fromStatus === 'cancelled') {
                return req.reject(400, `Cannot mark delivery as delivered from status '${fromStatus}'`);
            }

            // Target the underlying db entities directly (not `this.update()`/`this.create()`)
            // so these writes bypass AdminService's own @readOnly restrictions on DeliveryStatusLog.
            
            await UPDATE('supplyFlow.Deliveries')
                .set({ status: 'delivered' })
                .where({ ID: deliveryId });
            
            await INSERT.into('supplyFlow.DeliveryStatusLog').entries({
                delivery_ID: deliveryId,
                fromStatus,
                toStatus: 'delivered'
            });

            return req.reply({ ...delivery, status: 'delivered' });
        });
        return super.init();
    }
}