using { com.sap.satinfotech as db } from '../db/schema';

service Myservice {

    entity SalesOrderBOM as projection on db.SalesOrderBOM;
    action SalesOrderBOMData(sales: Array of {
        ref_id: String;
        BillOfMaterialCategory: String;
        BillOfMaterialVariant: String;
        Material: String;
        Plant: String;
        SalesOrder: String;
        SalesOrderItem: String;
        BillOfMaterialVariantUsage: String;
        BOMHeaderInternalChangeCount: String;
        BOMHeaderText: String;
        BillOfMaterialStatus: String;
        BOMHeaderBaseUnit: String;
        BOMHeaderQuantityInBaseUnit: Decimal;
        BOMItems: Array of {
            BillOfMaterialItemNodeNumber: String;
            Material: String;
            Plant: String;
            BOMItemInternalChangeCount: String;
            InheritedNodeNumberForBOMItem: String;
            BillOfMaterialComponent: String;
            BillOfMaterialItemCategory: String;
            BillOfMaterialItemNumber: String;
            BillOfMaterialItemUnit: String;
            BillOfMaterialItemQuantity: Decimal;
            IdentifierBOMItem: String;
            ComponentDescription: String;
            ObjectType: String;
            BOMItemIsCostingRelevant: String;
        };
    });

    //entity SalesOrderBOMItems as projection on db.SalesOrderBOMItems;

}


annotate Myservice.SalesOrderBOM with @odata.draft.enabled;


annotate Myservice.SalesOrderBOM with @(
    Capabilities.SearchRestrictions: { false },
    Capabilities.DeleteRestrictions: {
        $Type: 'Capabilities.DeleteRestrictionsType',
        Deletable: false
    },
    UI.PresentationVariant: {
        $Type: 'UI.PresentationVariantType',
        Visualizations: ['@UI.LineItem']
    },
    UI.LineItem: [
        { $Type: 'UI.DataField', Label: 'refID', Value: ref_id },
        { $Type: 'UI.DataField', Label: 'Bill Of Material Category', Value: BillOfMaterialCategory },
        { $Type: 'UI.DataField', Label: 'Bill Of Material Variant', Value: BillOfMaterialVariant },
        { $Type: 'UI.DataField', Label: 'Material', Value: Material },
        { $Type: 'UI.DataField', Label: 'Plant', Value: Plant },
        { $Type: 'UI.DataField', Label: 'Sales Order', Value: SalesOrder },
        { $Type: 'UI.DataField', Label: 'Sales Order Item', Value: SalesOrderItem },
        { $Type: 'UI.DataField', Label: 'Bill Of Material Variant Usage', Value: BillOfMaterialVariantUsage },
        { $Type: 'UI.DataField', Label: 'BOM Header Internal Change Count', Value: BOMHeaderInternalChangeCount },
        { $Type: 'UI.DataField', Label: 'BOM Header Text', Value: BOMHeaderText },
        { $Type: 'UI.DataField', Label: 'Bill Of Material Status', Value: BillOfMaterialStatus },
        { $Type: 'UI.DataField', Label: 'BOM Header Base Unit', Value: BOMHeaderBaseUnit },
        { $Type: 'UI.DataField', Label: 'BOM Header Quantity In Base Unit', Value: BOMHeaderQuantityInBaseUnit }
    ]
);

annotate Myservice.SalesOrderBOM with @(
    UI.FieldGroup#SalesOrderBOMInformation: {
        $Type: 'UI.FieldGroupType',
        Data: [
            { $Type: 'UI.DataField', Label: 'refID', Value: ref_id },
            { $Type: 'UI.DataField', Label: 'Bill Of Material Category', Value: BillOfMaterialCategory },
            { $Type: 'UI.DataField', Label: 'Bill Of Material Variant', Value: BillOfMaterialVariant },
            { $Type: 'UI.DataField', Label: 'Material', Value: Material },
            { $Type: 'UI.DataField', Label: 'Plant', Value: Plant },
            { $Type: 'UI.DataField', Label: 'Sales Order', Value: SalesOrder },
            { $Type: 'UI.DataField', Label: 'Sales Order Item', Value: SalesOrderItem },
            { $Type: 'UI.DataField', Label: 'Bill Of Material Variant Usage', Value: BillOfMaterialVariantUsage },
            { $Type: 'UI.DataField', Label: 'BOM Header Internal Change Count', Value: BOMHeaderInternalChangeCount },
            { $Type: 'UI.DataField', Label: 'BOM Header Text', Value: BOMHeaderText },
            { $Type: 'UI.DataField', Label: 'Bill Of Material Status', Value: BillOfMaterialStatus },
            { $Type: 'UI.DataField', Label: 'BOM Header Base Unit', Value: BOMHeaderBaseUnit },
            { $Type: 'UI.DataField', Label: 'BOM Header Quantity In Base Unit', Value: BOMHeaderQuantityInBaseUnit }
        ]
    },
    UI.Facets: [
        {
            $Type: 'UI.ReferenceFacet',
            ID: 'SalesOrderBOMHeaderFacet',
            Label: 'SalesOrderBOM Header Information',
            Target: '@UI.FieldGroup#SalesOrderBOMInformation'
        },
        {
            $Type: 'UI.ReferenceFacet',
            ID: 'SalesOrderBOMItemsFacet',
            Label: 'BOM Items',
            Target: 'BOMItems/@UI.LineItem'
        }
    ]
);

// Annotations for SalesOrderBOMItems
annotate Myservice.SalesOrderBOM.BOMItems with @(
    Capabilities.SearchRestrictions: { false },
    Capabilities.DeleteRestrictions: {
        $Type: 'Capabilities.DeleteRestrictionsType',
        Deletable: false
    },
    UI.PresentationVariant: {
        $Type: 'UI.PresentationVariantType',
        Visualizations: ['@UI.LineItem']
    },
    UI.LineItem: [
        { $Type: 'UI.DataField', Label: 'Bill Of Material Item Node Number', Value: BillOfMaterialItemNodeNumber },
        { $Type: 'UI.DataField', Label: 'Material', Value: Material },
        { $Type: 'UI.DataField', Label: 'Plant', Value: Plant },
        { $Type: 'UI.DataField', Label: 'BOM Item Internal Change Count', Value: BOMItemInternalChangeCount },
        { $Type: 'UI.DataField', Label: 'Inherited Node Number For BOM Item', Value: InheritedNodeNumberForBOMItem },
        { $Type: 'UI.DataField', Label: 'Bill Of Material Component', Value: BillOfMaterialComponent },
        { $Type: 'UI.DataField', Label: 'Bill Of Material Item Category', Value: BillOfMaterialItemCategory },
        { $Type: 'UI.DataField', Label: 'Bill Of Material Item Number', Value: BillOfMaterialItemNumber },
        { $Type: 'UI.DataField', Label: 'Bill Of Material Item Unit', Value: BillOfMaterialItemUnit },
        { $Type: 'UI.DataField', Label: 'Bill Of Material Item Quantity', Value: BillOfMaterialItemQuantity },
        { $Type: 'UI.DataField', Label: 'Identifier BOM Item', Value: IdentifierBOMItem },
        { $Type: 'UI.DataField', Label: 'Component Description', Value: ComponentDescription },
        { $Type: 'UI.DataField', Label: 'Object Type', Value: ObjectType }
    ]
);

annotate Myservice.SalesOrderBOM.BOMItems with @(
    UI.FieldGroup#SalesOrderBOMItemsInformation: {
        $Type: 'UI.FieldGroupType',
        Data: [
            { $Type: 'UI.DataField', Label: 'Bill Of Material Item Node Number', Value: BillOfMaterialItemNodeNumber },
            { $Type: 'UI.DataField', Label: 'Material', Value: Material },
            { $Type: 'UI.DataField', Label: 'Plant', Value: Plant },
            { $Type: 'UI.DataField', Label: 'BOM Item Internal Change Count', Value: BOMItemInternalChangeCount },
            { $Type: 'UI.DataField', Label: 'Inherited Node Number For BOM Item', Value: InheritedNodeNumberForBOMItem },
            { $Type: 'UI.DataField', Label: 'Bill Of Material Component', Value: BillOfMaterialComponent },
            { $Type: 'UI.DataField', Label: 'Bill Of Material Item Category', Value: BillOfMaterialItemCategory },
            { $Type: 'UI.DataField', Label: 'Bill Of Material Item Number', Value: BillOfMaterialItemNumber },
            { $Type: 'UI.DataField', Label: 'Bill Of Material Item Unit', Value: BillOfMaterialItemUnit },
            { $Type: 'UI.DataField', Label: 'Bill Of Material Item Quantity', Value: BillOfMaterialItemQuantity },
            { $Type: 'UI.DataField', Label: 'Identifier BOM Item', Value: IdentifierBOMItem },
            { $Type: 'UI.DataField', Label: 'Component Description', Value: ComponentDescription },
            { $Type: 'UI.DataField', Label: 'Object Type', Value: ObjectType }
        ]
    },
    UI.Facets: [
        {
            $Type: 'UI.ReferenceFacet',
            ID: 'SalesOrderBOMItemsInfoFacet',
            Label: 'SalesOrderBOMItems Information',
            Target: '@UI.FieldGroup#SalesOrderBOMItemsInformation'
        }
    ]
);


