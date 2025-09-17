sap.ui.define(['sap/fe/test/ObjectPage'], function(ObjectPage) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ObjectPage(
        {
            appId: 'featureshowcase2nd',
            componentId: 'RootEntitiesObjectPage',
            contextPath: '/RootEntities'
        },
        CustomPageDefinitions
    );
});