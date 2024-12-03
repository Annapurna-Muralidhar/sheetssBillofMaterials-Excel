sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'salesorderbom/test/integration/FirstJourney',
		'salesorderbom/test/integration/pages/SalesOrderBOMList',
		'salesorderbom/test/integration/pages/SalesOrderBOMObjectPage',
		'salesorderbom/test/integration/pages/SalesOrderBOMItemsObjectPage'
    ],
    function(JourneyRunner, opaJourney, SalesOrderBOMList, SalesOrderBOMObjectPage, SalesOrderBOMItemsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('salesorderbom') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheSalesOrderBOMList: SalesOrderBOMList,
					onTheSalesOrderBOMObjectPage: SalesOrderBOMObjectPage,
					onTheSalesOrderBOMItemsObjectPage: SalesOrderBOMItemsObjectPage
                }
            },
            opaJourney.run
        );
    }
);