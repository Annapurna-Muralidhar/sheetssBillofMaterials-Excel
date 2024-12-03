sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/m/MessageToast",
    "sap/ui/model/json/JSONModel",
    "salesorderbom/libs/style"
], function (Controller, MessageToast, JSONModel, style) {
    "use strict";

    return Controller.extend("salesorderbom.controller.UploadData", {

        onUploadDialogPress: function () {
            var oFileUploader = this.byId("fileUploader");
            var oFileUploaderInput = document.getElementById(oFileUploader.getId() + "-fu");
            var file = oFileUploaderInput.files[0];
            var that = this;

            if (file) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    var data = e.target.result;
                    var workbook = XLSX.read(data, { type: 'binary' });

                   
                    var sheet1 = workbook.Sheets[workbook.SheetNames[0]];
                    var salesOrderBOMData = XLSX.utils.sheet_to_json(sheet1, { header: 1 }).slice(1).map(row => ({
                       
                        ref_id: String(row[0]) || '',
                        BillOfMaterialCategory: String(row[1]) || '',
                        BillOfMaterialVariant: String(row[2]) || '',
                        Material: String(row[3]) || '',
                        Plant: String(row[4]) || '',
                        SalesOrder: String(row[5]) || '',
                        SalesOrderItem: String(row[6]) || '',
                        BillOfMaterialVariantUsage: String(row[7]) || '',
                        BOMHeaderInternalChangeCount: String(row[8]) || '',
                        BOMHeaderText: String(row[9]) || '',
                        BillOfMaterialStatus: String(row[10]) || '',
                        BOMHeaderBaseUnit: String(row[11]) || '',
                        BOMHeaderQuantityInBaseUnit: String(parseFloat(row[12])) || 0,
                        BOMItems: [] 
                    }));

                  
                    var sheet2 = workbook.Sheets[workbook.SheetNames[1]];
                    var bomItemsData = XLSX.utils.sheet_to_json(sheet2, { header: 1 }).slice(1).map(row => ({
                        ref_id: String(row[0]) || '',
                        BillOfMaterialItemNodeNumber: String(row[1]) || '',
                        Material: String(row[2]) || '',
                        Plant: String(row[3]) || '',
                        BOMItemInternalChangeCount: String(row[4]) || '',
                        InheritedNodeNumberForBOMItem: String(row[5]) || '',
                        BillOfMaterialComponent: String(row[6]) || '',
                        BillOfMaterialItemCategory: String(row[7]) || '',
                        BillOfMaterialItemNumber: String(row[8]) || '',
                        BillOfMaterialItemUnit: String(row[9]) || '',
                        BillOfMaterialItemQuantity: String(parseFloat(row[10])) || 0,
                        IdentifierBOMItem: String(row[11]) || '',
                        ComponentDescription: String(row[12]) || '',
                        ObjectType: String(row[13]) || '',
                        BOMItemIsCostingRelevant: String(row[14]) || ''
                    }));

                    // Map BOMItems to their parent SalesOrderBOM using ref_id
                    salesOrderBOMData.forEach(bom => {
                        // Ensure BOMItems is an array and populated
                        const items = bomItemsData.filter(item => item.ref_id === bom.ref_id);
                        if (items.length > 0) {
                            bom.BOMItems = items;
                        }
                    });

                    var payload = {
                        sales: salesOrderBOMData.map(bom => ({
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
                          BOMHeaderQuantityInBaseUnit: parseFloat(bom.BOMHeaderQuantityInBaseUnit) || 0,
                          BOMItems: bom.BOMItems.map(item => ({
                            BillOfMaterialItemNodeNumber: item.BillOfMaterialItemNodeNumber,
                            Material: item.Material,
                            Plant: item.Plant,
                            BOMItemInternalChangeCount: item.BOMItemInternalChangeCount,
                            InheritedNodeNumberForBOMItem: item.InheritedNodeNumberForBOMItem,
                            BillOfMaterialComponent: item.BillOfMaterialComponent,
                            BillOfMaterialItemCategory: item.BillOfMaterialItemCategory,
                            BillOfMaterialItemNumber: item.BillOfMaterialItemNumber,
                            BillOfMaterialItemUnit: item.BillOfMaterialItemUnit,
                            BillOfMaterialItemQuantity: parseFloat(item.BillOfMaterialItemQuantity) || 0,
                            IdentifierBOMItem: item.IdentifierBOMItem,
                            ComponentDescription: item.ComponentDescription,
                            ObjectType: item.ObjectType,
                            BOMItemIsCostingRelevant: item.BOMItemIsCostingRelevant
                          }))
                        }))
                      };

        console.log(payload);

        $.ajax({
            url: "/odata/v4/Myservice/SalesOrderBOMData",
            method: "POST",
            contentType: "application/json",
            data: JSON.stringify(payload),
            success: function (response) {
                MessageToast.show("Data imported successfully!");
                console.log(response);
                var oDialog = that.byId("upload");
                if (oDialog) {
                    oDialog.close();
                }
                window.location.reload();
            },
            error: function (error) {
                console.error("Error importing data: ", error);
                MessageToast.show("Error importing data.");
            }
        });

                        };
                        reader.readAsBinaryString(file);
                    } else {
                        MessageToast.show("Please choose a file first.");
                    }
                }
    });
});
