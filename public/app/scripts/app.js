'use strict';

angular.module('PaperPlanesApp', [
  'ngRoute',
  'PaperPlanesApp.navControllers',
  'PaperPlanesApp.services',
  'PaperPlanesApp.basicCrudControllers',
  'PaperPlanesApp.directives'
  ])
.config(function ($routeProvider, $httpProvider) {
  
  var controllerPrefixes = ['Agency', 'Team', 'Project', "Person", "Award"];
  var targets = ["agency", "team", "project", "person", "award"];
  
  for(var i = 0; i < targets.length; i++) {
    var target = targets[i];
    var prefix = controllerPrefixes[i];
    
    $routeProvider.when('/'+target+'-list', {templateUrl: 'app/views/'+target+'-list.html', controller: prefix+'Ctrl'});
    $routeProvider.when('/'+target+'-edit/:id', {templateUrl: 'app/views/'+target+'-edit.html', controller: prefix+'EditCtrl'});
    $routeProvider.when('/'+target+'-create', {templateUrl: 'app/views/'+target+'-create.html', controller: prefix+'CreateCtrl'});
    
  }
  
  $routeProvider.otherwise({redirectTo: '/'});

  /* CORS... */
  /* http://stackoverflow.com/questions/17289195/angularjs-post-data-to-external-rest-api */
  // $httpProvider.defaults.useXDomain = true;
  // delete $httpProvider.defaults.headers.common['X-Requested-With'];
});