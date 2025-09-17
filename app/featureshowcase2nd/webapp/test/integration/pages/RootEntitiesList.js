sap.ui.define(['sap/fe/test/ListReport'], function(ListReport) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ListReport(
        {
            appId: 'featureshowcase2nd',
            componentId: 'RootEntitiesList',
            contextPath: '/RootEntities'
        },
        CustomPageDefinitions
    );
});