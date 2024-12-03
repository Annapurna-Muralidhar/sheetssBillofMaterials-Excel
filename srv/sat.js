const cds = require('@sap/cds');

module.exports = cds.service.impl(async function () {
    const { SalesOrderBOM } = this.entities; 

    this.on('SalesOrderBOMData', async (req) => {
        const data = req.data.sales;
        const db = cds.tx(req);
        const bomItems = data.flatMap(bom => 
            bom.BOMItems.map(item => ({
                ref_id: bom.ref_id, 
                ...item 
            }))
        );

        console.log("Extracted BOM Items:", bomItems);

        const items = bomItems.map((component) => ({
            ref_id: component.ref_id,
            BillOfMaterialItemNodeNumber: component.BillOfMaterialItemNodeNumber,
            Material: component.Material,
            Plant: component.Plant,
            BOMItemInternalChangeCount: component.BOMItemInternalChangeCount,
            InheritedNodeNumberForBOMItem:component.InheritedNodeNumberForBOMItem,
            BillOfMaterialComponent: component.BillOfMaterialComponent,
            BillOfMaterialItemCategory: component.BillOfMaterialItemCategory,
            BillOfMaterialItemNumber: component.BillOfMaterialItemNumber,
            BillOfMaterialItemUnit: component.BillOfMaterialItemUnit,
            BillOfMaterialItemQuantity: component.BillOfMaterialItemQuantity,
            IdentifierBOMItem: component.IdentifierBOMItem,
            ComponentDescription: component.ComponentDescription,
            ObjectType: component.ObjectType,
            BOMItemIsCostingRelevant: component.BOMItemIsCostingRelevant
          }));
        try {
            for (const bom of data) {
                await db.run(
                    INSERT.into(SalesOrderBOM).entries({
                        ref_id: bom.ref_id,
                        BillOfMaterialCategory: bom.BillOfMaterialCategory,
                        BillOfMaterialVariant: bom.BillOfMaterialVariant,
                        Material: bom.Material,
                        Plant: bom.Plant,
                        SalesOrder: bom.SalesOrder,
                        SalesOrderItem: bom.SalesOrderItem,
                        BillOfMaterialVariantUsage: bom.BillOfMaterialVariantUsage,
                        BOMHeaderInternalChangeCount: bom.BOMHeaderInternalChangeCount,
                        BOMHeaderText: bom.BOMHeaderText,
                        BillOfMaterialStatus: bom.BillOfMaterialStatus,
                        BOMHeaderBaseUnit: bom.BOMHeaderBaseUnit,
                        BOMHeaderQuantityInBaseUnit: bom.BOMHeaderQuantityInBaseUnit,
                        BOMItems:items
                    })
                );
            }
            return { message: "Data inserted successfully." };
        } catch (error) {
            console.error("Error inserting data:", error);
            req.error(500, "Failed to insert data.");
        }
    });
});
