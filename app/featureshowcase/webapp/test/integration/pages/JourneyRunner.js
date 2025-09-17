sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"featureshowcase/test/integration/pages/RootEntitiesList",
	"featureshowcase/test/integration/pages/RootEntitiesObjectPage"
], function (JourneyRunner, RootEntitiesList, RootEntitiesObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('featureshowcase') + '/test/flpSandbox.html#featureshowcase-tile',
        pages: {
			onTheRootEntitiesList: RootEntitiesList,
			onTheRootEntitiesObjectPage: RootEntitiesObjectPage
        },
        async: true
    });

    return runner;
});

