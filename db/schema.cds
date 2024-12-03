namespace com.sap.satinfotech;

entity SalesOrderBOM {
    @title: 'refID'
    key ref_id: String(10);
    @title: 'Bill Of Material Category'
    BillOfMaterialCategory: String(2);
    @title: 'Bill Of Material Variant'
    BillOfMaterialVariant: String(2);
    @title: 'Material'
    Material: String(40);
    @title: 'Plant'
    Plant: String(4);
    @title: 'Sales Order'
    SalesOrder: String(10);
    @title: 'Sales Order Item'
    SalesOrderItem: String(6);
    @title: 'Bill Of Material Variant Usage'
    BillOfMaterialVariantUsage: String(1);
    @title: 'BOM Header Internal Change Count'
    BOMHeaderInternalChangeCount: String(8);
    @title: 'BOM Header Text'
    BOMHeaderText: String(40);
    @title: 'Bill Of Material Status'
    BillOfMaterialStatus: String(2);
    @title: 'BOM Header Base Unit'
    BOMHeaderBaseUnit: String(3);
    @title: 'BOM Header Quantity In Base Unit'
    BOMHeaderQuantityInBaseUnit: Decimal(13, 3);
    @title: 'BOM Items'
    //BOMItems: Composition of many SalesOrderBOMItems on BOMItems.ref_id = $self.ref_id;
    BOMItems: Composition of many {
    @title: 'refID'
    key ref_id: String(10);
    @title: 'Bill Of Material Item Node Number'
    BillOfMaterialItemNodeNumber: String(8);
    @title: 'Material'
    Material: String(40);
    @title: 'Plant'
    Plant: String(4);
    @title: 'BOM Item Internal Change Count'
    BOMItemInternalChangeCount: String(8);
    @title: 'Inherited Node Number For BOM Item'
    InheritedNodeNumberForBOMItem: String(8);
    @title: 'Bill Of Material Component'
    BillOfMaterialComponent: String(40);
    @title: 'Bill Of Material Item Category'
    BillOfMaterialItemCategory: String(1);
    @title: 'Bill Of Material Item Number'
    BillOfMaterialItemNumber: String(4);
    @title: 'Bill Of Material Item Unit'
    BillOfMaterialItemUnit: String(3);
    @title: 'Bill Of Material Item Quantity'
    BillOfMaterialItemQuantity: Decimal(13, 3);
    @title: 'Identifier BOM Item'
    IdentifierBOMItem: String(8);
    @title: 'Component Description'
    ComponentDescription: String(40);
    @title: 'Object Type'
    ObjectType: String(1);
    @title: 'BOM Item Is Costing Relevant'
    BOMItemIsCostingRelevant: String(1);

    }
}

