sap.ui.define(['sap/fe/test/ObjectPage'], function(ObjectPage) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ObjectPage(
        {
            appId: 'salesorderbom',
            componentId: 'SalesOrderBOMItemsObjectPage',
            contextPath: '/SalesOrderBOM/BOMItems'
        },
        CustomPageDefinitions
    );
});