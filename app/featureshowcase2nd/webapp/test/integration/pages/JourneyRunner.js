sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"featureshowcase2nd/test/integration/pages/RootEntitiesList",
	"featureshowcase2nd/test/integration/pages/RootEntitiesObjectPage"
], function (JourneyRunner, RootEntitiesList, RootEntitiesObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('featureshowcase2nd') + '/test/flpSandbox.html#featureshowcase2nd-tile',
        pages: {
			onTheRootEntitiesList: RootEntitiesList,
			onTheRootEntitiesObjectPage: RootEntitiesObjectPage
        },
        async: true
    });

    return runner;
});

