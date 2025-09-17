using service1 from '../../srv/service';

annotate service1.RootEntities with @odata.draft.enabled; //Search-Term: #Draft

annotate service1.RootEntityVariants with @odata.draft.enabled; //Annotation has to exists, without no entites would be visible on view with other entity set of List Report 

// /*
annotate service1.RootEntities with @(  Capabilities.DeleteRestrictions : { Deletable   : deletePossible, },
                                        UI.UpdateHidden : updateHidden,
                                        UI.CreateHidden: { $edmJson: { $Path: '/service1.EntityContainer/Singleton/createHidden' } },
                                        Capabilities.FilterRestrictions : { FilterExpressionRestrictions : [{ Property : 'validFrom', AllowedExpressions : 'SingleRange' }, ], },
                                    ) { validTo @UI.DateTimeStyle : 'short' };
// */

// /*
annotate service1 with @( Capabilities.FilterFunctions : [ 'tolower' ], );
// */

// /*
annotate service1.ChartDataEntities with @(
    //Search-Term: #ChartSection
    Aggregation.ApplySupported : {  Transformations : [ 'aggregate', 'topcount', 'bottomcount', 'identity', 'concat', 'groupby', 'filter', 'expand', 'top', 'skip', 'orderby', 'search' ],
                                    Rollup          : #None,
                                    PropertyRestrictions : true,
                                    GroupableProperties : [ dimensions, criticality_code ],
                                    AggregatableProperties : [ {Property : integerValue}, ], } );
// */

// /*
annotate service1.ChartDataEntities with {
    criticality @( UI.ValueCriticality   :  [   { Value : 0, Criticality : #Neutral },
                                                { Value : 1, Criticality : #Negative },
                                                { Value : 2, Criticality : #Critical },
                                                { Value : 3, Criticality : #Positive } ] );

    integerValue @( Measures.ISOCurrency : uom_code, Core.Immutable       : true, ); };
// */