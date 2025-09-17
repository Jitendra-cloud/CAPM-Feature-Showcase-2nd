using service1                      as service          from '../../srv/service';
using service1.ChartDataEntities    as chartEntities    from './layouts_ChartDataEntities';
using service1.ChildEntities1       as childEntities1   from './layouts_ChildEntities1';
using service1.ChildEntities2       as association2one  from './layouts_ChildEntities2';
using service1.ChildEntities3       as childEntities3   from './layouts_ChildEntities3';
using service1.Contacts             as contact          from './layouts_contacts';

/**
    UI.Identification (Actions on Object Page) & Semantic Key
 */
annotate service.RootEntities with @(
    //Search-Term: #SemanticKey
    //field in bold, editing status displayed, when possible and it effects navigation
    Common.SemanticKey  : [stringProperty],                  
    UI.Identification   : [ { $Type : 'UI.DataFieldForAction', Action : 'service1.changeCriticality', Label : '{i18n>changeCriticality}', Criticality : criticality_code, CriticalityRepresentation : #WithIcon, },       //Has no effect
                            { $Type : 'UI.DataFieldForAction', Action : 'service1.changeCriticality', Label : '{i18n>changeCriticality}', Determining : true, Criticality : criticality_code, }, ], );
/**
    UI.LineItem
 */
annotate service.RootEntities with @(
    UI.LineItem : [ { $Type : 'UI.DataField', Value : imageUrl, ![@UI.Importance] : #High, },
                    { $Type : 'UI.DataField', Value : stringProperty, ![@UI.Importance] : #High, },
                    { $Type : 'UI.DataField', Value : fieldWithPrice, ![@UI.Importance] : #High, },
                    { $Type : 'UI.DataFieldForAnnotation', Target : '@UI.DataPoint#fieldWithTooltip', Label : '{i18n>fieldWithToolTip}', },
                    { $Type : 'UI.DataField', Value : fieldWithUoM, ![@UI.Importance] : #Low, },
                    { $Type : 'UI.DataField', Value : fieldWithCriticality, Criticality : criticality_code, CriticalityRepresentation : #WithIcon, ![@UI.Importance] : #Low, },   //Supported values 0,1,2,3,5
                    { $Type : 'UI.DataFieldForAnnotation', Label : '{i18n>progressIndicator}', Target : '@UI.DataPoint#progressIndicator', ![@UI.Importance] : #Low, }, //Added progress indicator to table
                    { $Type : 'UI.DataFieldForAnnotation', Label : '{i18n>ratingIndicator}', Target : '@UI.DataPoint#ratingIndicator', ![@UI.Importance] : #Low, }, //Added rating indicator to table
                    { $Type : 'UI.DataFieldForAnnotation', Label : '{i18n>bulletChart}', Target : '@UI.Chart#bulletChart', ![@UI.Importance] : #High, },
                    { $Type : 'UI.DataField', Value : association2one_ID, Label : '{i18n>ChildEntity2}', ![@UI.Importance] : #High, },
                    { $Type : 'UI.DataFieldForAnnotation', Target : '@UI.FieldGroup#AdminData', Label : '{i18n>adminData}', ![@UI.Importance] : #High, },
                    { $Type : 'UI.DataFieldForAnnotation', Target : '@UI.Chart#radialChart', Label : '{i18n>radialChart}', },
                    { $Type : 'UI.DataFieldForAnnotation', Target : 'contact/@Communication.Contact', Label : '{i18n>contactQuickView}' },
                    { $Type : 'UI.DataFieldForAction', Action : 'service1.changeCriticality', Label : '{i18n>changeCriticality}', }, //Reference to the action of the CAP service
                    { $Type : 'UI.DataFieldForAction', Action : 'service1.changeProgress', Label : '{i18n>changeProgess}', IconUrl : 'sap-icon://command-line-interfaces', Inline : true, },
                    { $Type : 'UI.DataFieldForIntentBasedNavigation', Label : '{i18n>inboundNavigation}', SemanticObject : 'FeatureShowcaseChildEntity2', Action : 'manage', RequiresContext : true, Inline : true, IconUrl : 'sap-icon://cart',
                      Mapping : [ { $Type : 'Common.SemanticObjectMappingType',
                                    LocalProperty : integerValue,
                                    SemanticObjectProperty : 'integerProperty', },
                                ],
                      ![@UI.Importance] : #High,
                    },
                    { $Type : 'UI.DataFieldForAction', Action : 'service1.EntityContainer/unboundAction', Label : '{i18n>unboundAction}', }, //Unbound actions need to be referenced through the entity container (Action import)   
                    { $Type : 'UI.DataFieldForAction', Action : 'service1.EntityContainer/criticalAction', Label : '{i18n>criticalAction}', }, //Unbound actions need to be referenced through the entity container (Action import)
                    { $Type : 'UI.DataFieldForAction', Action : 'service1.resetEntities(service1.RootEntities)', Label : '{i18n>resetEntities}', }, //Static action
                    { $Type : 'UI.DataFieldWithUrl', Url : fieldWithURL, //Target, when pressing the text
                       Value : fieldWithURLtext, Label : '{i18n>dataFieldWithURL}', ![@UI.Importance] : #Medium, }, //Visible text              
    ],

    UI.LineItem.@UI.Criticality : criticality_code, // Annotation, so that the row has a criticality

    UI.LineItem #simplified : [ { $Type : 'UI.DataField', Value : stringProperty, ![@UI.Importance] : #High, },
                                { $Type : 'UI.DataField', Value : fieldWithPrice, ![@UI.Importance] : #High, },
                                { $Type : 'UI.DataField', Value : fieldWithUoM, ![@UI.Importance] : #High, },
                                { $Type : 'UI.DataField', Value : fieldWithCriticality, Criticality : criticality_code, ![@UI.Importance] : #High, },
    ],
);

/**
    UI.FieldGroup
 */
annotate service.RootEntities with @(
    UI.FieldGroup #AdminData : { 
        Data : [ {Value : createdAt},
                 {Value : createdBy},
                 {Value : modifiedAt},
                 {Value : modifiedBy}, ] },

    UI.FieldGroup #Section : {
        Data : [ { $Type : 'UI.DataFieldForAnnotation', Target : '@UI.ConnectedFields#ConnectedDates', },
                 { Value   : description},
                 { Value   : description_customGrowing},
                 { $Type : 'UI.DataFieldForIntentBasedNavigation', Label : '{i18n>inboundNavigation}', SemanticObject : 'FeatureShowcaseChildEntity2', Action : 'manage', RequiresContext : true, IconUrl : 'sap-icon://cart', Mapping : [ {$Type : 'Common.SemanticObjectMappingType', LocalProperty : integerValue, SemanticObjectProperty : 'integerProperty', }, ], ![@UI.Importance] : #High, },
                 { $Type : 'UI.DataFieldForAction', Action : 'service1.EntityContainer/unboundAction', Label : '{i18n>formActionEmphasized}', ![@UI.Emphasized] : true, }, //Button is highlighted
                 { $Type : 'UI.DataFieldForAction', Action : 'service1.changeProgress', Label : '{i18n>formAction}', Inline  : true, }, //Action in the Form toolbar instead of the section toolbar
                 { $Type : 'UI.DataField', Label : '{i18n>MultiInputField}', Value : childEntities1.field, } ] },

    UI.FieldGroup #ShowWhenInEdit : {
        Data : [ {Value : stringProperty},
                 {Value : fieldWithCriticality},
                 {Value : fieldWithUoM},
                 {Value : fieldWithPrice},
                 {Value : criticality_code},
                 {Value : contact_ID},
                 {Value : association2one_ID}, ] },

    UI.FieldGroup #chartData : {
        Data : [ {Value : integerValue},
                 {Value : targetValue},
                 {Value : forecastValue},
                 {Value : dimensions}, ] },

    UI.FieldGroup #advancedChartData    : {
        Data : [ {Value : sumIntegerValue},
                 {Value : sumTargetValue}, ] },

    UI.FieldGroup #HeaderData : {
        Data : [ {Value : stringProperty},
                 {Value : fieldWithCriticality, Criticality : criticality_code},
                 {Value : fieldWithUoM},
                 {Value : association2one_ID}, //Displaying a quick view facet
                 {$Type : 'UI.DataFieldForAnnotation', Target : 'contact/@Communication.Contact', Label : '{i18n>contact}', }, ] },
    
    UI.FieldGroup #location : {
        Data : [ {Value : country_code},
                 {Value : region_code},
                 {Value : regions.region_code, Label : '{i18n>MultiInputFieldWithVH}' } ] },
    
    UI.FieldGroup #communication : {
        Data : [ {Value : email},
                 {Value : telephone} ] },

    UI.FieldGroup #timeAndDate : {
        Data : [ {Value : validTo},
                 {Value : time},
                 {Value : timeStamp} ] },

    UI.FieldGroup #plainText : {
        Data : [ {Value : description} ] },
);

annotate service.RootEntities with @(
    UI.ConnectedFields #ConnectedDates : {
        Label       : '{i18n>connectedField}',
        Template    : '{integerValue} / {targetValue}',
        Data        :  {integerValue : { $Type : 'UI.DataField', Value : integerValue, },
                        targetValue  : { $Type : 'UI.DataField', Value : targetValue, }, },
},);

annotate service.RootEntities with @(
    UI.HeaderInfo :{ TypeName : '{i18n>RootEntities}',
                     TypeNamePlural : '{i18n>RootEntities.typeNamePlural}',
                     Title : { $Type : 'UI.DataField', Value : stringProperty, },
                     Description : { $Type : 'UI.DataField', Value : '{i18n>RootEntities}', },
                     ImageUrl : imageUrl,
                     TypeImageUrl : 'sap-icon://sales-order',
                     Initials : 'RE', //Up to two latin letters are displayed
}, );

annotate service.RootEntities with @(
    UI.HeaderFacets : [ { $Type : 'UI.ReferenceFacet', Target  : '@UI.DataPoint#fieldWithPrice', },
                        { $Type : 'UI.CollectionFacet',
                          Facets : [ { $Type : 'UI.ReferenceFacet', Target : '@UI.FieldGroup#HeaderData', Label : '{i18n>generalData}', },
                                     { $Type : 'UI.ReferenceFacet', Target : '@UI.Chart#bulletChart', }, ], },
                        { $Type : 'UI.CollectionFacet', ID : 'CollectionFacet1', 
                          Facets : [ { $Type : 'UI.ReferenceFacet', Target : '@UI.DataPoint#ratingIndicator', },
                                     { $Type : 'UI.ReferenceFacet', Target : '@UI.DataPoint#progressIndicator', },
                                     { $Type : 'UI.ReferenceFacet', Target : 'contact/@Communication.Address', Label : '{i18n>address}' }, ], },
                        { $Type : 'UI.CollectionFacet', ID : 'CollectionFacet2',
                          Facets : [ { $Type : 'UI.ReferenceFacet', Target : 'chartEntities/@UI.Chart#areaChart', },
                                     { $Type : 'UI.ReferenceFacet', Target : '@UI.Chart#radialChart', }, ], },
                        { $Type : 'UI.ReferenceFacet', Target : '@UI.FieldGroup#plainText', Label : '{i18n>plainText}' },
                        { $Type : 'UI.ReferenceFacet', Target : 'chartEntities/@UI.Chart#lineChart', },
                        { $Type : 'UI.ReferenceFacet', Target : 'chartEntities/@UI.Chart#columnChart', },
                        { $Type : 'UI.ReferenceFacet', Target : '@UI.Chart#harveyChart', },
                        { $Type : 'UI.ReferenceFacet', Target : 'chartEntities/@UI.Chart#stackedBarChart', },
                        { $Type : 'UI.ReferenceFacet', Target : 'chartEntities/@UI.Chart#comparisonChart', }, ], );

annotate service.RootEntities with @(
    UI.Facets :       [ { $Type : 'UI.CollectionFacet', ID : 'collectionFacetSection', Label : '{i18n>collectionSection}', 
                          Facets : [ { $Type : 'UI.ReferenceFacet', Target : '@UI.FieldGroup#Section', ID : 'SubSectionID', Label : '{i18n>subSection}', },
                                     { $Type   : 'UI.ReferenceFacet', Target  : '@UI.FieldGroup#location', Label   : '{i18n>locationSubSection}' },
                                     { $Type   : 'UI.ReferenceFacet', Target  : '@UI.FieldGroup#communication', Label   : '{i18n>communication}', },
                                     { $Type   : 'UI.ReferenceFacet', Target  : '@UI.FieldGroup#timeAndDate', Label   : '{i18n>timeAndDate}', }, ], },
                        { $Type : 'UI.ReferenceFacet', Target : '@UI.FieldGroup#ShowWhenInEdit', Label : '{i18n>showWhenInEdit}', ![@UI.Hidden] : IsActiveEntity, },
                        { $Type : 'UI.CollectionFacet', Label : '{i18n>chartDataCollection}', ID : 'chartDataCollection', //Used for Header Facet Navigation
                          Facets : [ { $Type   : 'UI.ReferenceFacet', Target  : '@UI.FieldGroup#chartData', Label   : '{i18n>chartData}', },
                                     { $Type   : 'UI.ReferenceFacet', Target  : '@UI.FieldGroup#advancedChartData', ID      : 'advancedChartData', Label   : '{i18n>advancedChartData}', ![@UI.PartOfPreview] : false }, ], },
                        { $Type   : 'UI.ReferenceFacet', Target  : 'childEntities1/@UI.PresentationVariant', ID      : 'childEntities1Section', Label   : '{i18n>childEntities1}', },
        
                        { $Type   : 'UI.ReferenceFacet', Target  : 'association2one/@UI.FieldGroup#data', Label   : '{i18n>ChildEntity2}', @UI.Hidden : {$edmJson: {$Not: {$Path : 'IsActiveEntity'}}} },
                        { $Type   : 'UI.ReferenceFacet', Target  : 'childEntities3/@UI.LineItem', Label   : '{i18n>childEntities3}', },
                        { $Type   : 'UI.ReferenceFacet', Target  : 'chartEntities/@UI.Chart', Label   : '{i18n>chart}' }, ],
);

annotate service.RootEntities with @(
    UI.PresentationVariant : { SortOrder       : [ { Property    : stringProperty, Descending  : false, }, ],
                               Visualizations  : ['@UI.LineItem'], }, );

annotate service.RootEntities with @(
    UI.FilterFacets : [ { Target  : '@UI.FieldGroup#chartData', Label   : '{i18n>chartData}', },
                        { Target  : '@UI.FieldGroup#location', Label   : '{i18n>location}', }, ], );

annotate service.RootEntities with @(
    UI.SelectionFields : [ stringProperty, validFrom, childEntities1.criticalityValue_code ], );

annotate service.RootEntities with @(
    UI.SelectionVariant #variant1 : { Text : '{i18n>SVariant1}',
                                      SelectOptions : [ { PropertyName : criticality_code, Ranges : [ { Sign : #I, High : 2, Option : #BT, Low : 0, }, ], }, ], },
    UI.SelectionVariant #variant2 : { Text : '{i18n>SVariant2}', 
                                      SelectOptions : [ { PropertyName : criticality_code, Ranges : [ { Sign : #I, Option : #EQ, Low : 3, }, ], }, ], }, );

annotate service.RootEntities with @(
    UI.SelectionPresentationVariant #SelectionPresentationVariant : {
        Text : '{i18n>SelectionPresentationVariant}',
        SelectionVariant : { SelectOptions : [ { PropertyName : criticality_code, Ranges : [ { Sign : #I, Option : #GT, Low : 0, }, ], }, ], },
        PresentationVariant : { SortOrder : [ { Property : fieldWithPrice, Descending : false, }, ],
                                Visualizations  : ['@UI.LineItem#simplified'], }, }, );

annotate service.RootEntities with @(
    UI.DataPoint #progressIndicator : { Value : integerValue,
                                        TargetValue : 100,
                                        Visualization : #Progress,
                                        Title : '{i18n>progressIndicator}', },

    UI.DataPoint #ratingIndicator : { Value : starsValue, //Amount of stars, which are filled. Values between x.25 and x.74 are displaced as a half star.
                                      TargetValue : 4, //Max amount of stars
                                      Visualization : #Rating,
                                      Title : '{i18n>ratingIndicator}',
                                      ![@Common.QuickInfo] : 'Tooltip via Common.QuickInfo', },
    UI.DataPoint #bulletChart : {   Value           : integerValue,           //horizontal bar in relation to the goal line
                                    TargetValue     : targetValue,      //visual goal line in the UI
                                    ForecastValue   : forecastValue,  //horizontal bar behind the value bar with, slightly larger with higher transparency
                                    Criticality     : criticality_code, //> optional criticality
                                    MinimumValue    : 0,     },          //Minimal value, needed for output rendering
                                
    UI.DataPoint #radialChart : {   Value           : integerValue,
                                    TargetValue     : targetValue,      //The relation between the value and the target value will be displayed as a percentage
                                    Criticality     : criticality_code, }, //> optional criticality
                                
    UI.DataPoint #harveyChart : {   Value           : fieldWithPrice,
                                    MaximumValue    : fieldWithUoM, //MaximumValue needs to be of type Decimal
                                    Criticality     : criticality_code },
                                
    UI.DataPoint #fieldWithPrice : { Value           : fieldWithPrice,
                                     Title           : '{i18n>fieldWithPrice}', },

    UI.DataPoint #fieldWithTooltip : {  Value           : dimensions,
                                        ![@Common.QuickInfo] : '{i18n>Tooltip}', }, //Can also be a dynamic property path
    
);

annotate service.RootEntities with @(
    UI.Chart #bulletChart : {   Title       : '{i18n>bulletChart}',
                                Description : '{i18n>ThisIsAMicroChart}',
                                ChartType   : #Bullet,
                                Dimensions  : [dimensions],
                                Measures    : [integerValue],
                                MeasureAttributes : [ { $Type       : 'UI.ChartMeasureAttributeType',
                                                        Measure     : integerValue,
                                                        Role        : #Axis1,
                                                        DataPoint   : '@UI.DataPoint#bulletChart', }, ], },
    
    UI.Chart #radialChart : {
                                Title       : '{i18n>radialChart}',
                                Description : '{i18n>ThisIsAMicroChart}',
                                ChartType   : #Donut,
                                Measures    : [integerValue],
                                MeasureAttributes : [ { $Type       : 'UI.ChartMeasureAttributeType',
                                                        Measure     : integerValue,
                                                        Role        : #Axis1,
                                                        DataPoint   : '@UI.DataPoint#radialChart', }, ], },
    
    UI.Chart #harveyChart : {   Title       : '{i18n>harveyChart}',
                                Description : '{i18n>ThisIsAMicroChart}',
                                ChartType   : #Pie,
                                Measures    : [fieldWithPrice],
                                MeasureAttributes : [ { $Type       : 'UI.ChartMeasureAttributeType',
                                                        Measure     : fieldWithPrice,
                                                        Role        : #Axis1,
                                                        DataPoint   : '@UI.DataPoint#harveyChart', } ] },
);