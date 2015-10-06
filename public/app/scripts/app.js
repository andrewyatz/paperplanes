'use strict';

angular.module('PaperPlanesApp', [
  'ngRoute',
  // 'ui.bootstrap.datetimepicker',
  // 'angucomplete-alt',
  'ui.bootstrap',
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
  
  $routeProvider.when('/paper', { templateUrl: 'app/views/paper.html', controller: 'PaperCtrl'});
  $routeProvider.when('/paper-create/:doi*', { templateUrl: 'app/views/paper-create.html', controller: 'PaperCreateCtrl'});

  // $routeProvider.otherwise({redirectTo: '/'});

  /* CORS... */
  /* http://stackoverflow.com/questions/17289195/angularjs-post-data-to-external-rest-api */
  $httpProvider.defaults.useXDomain = true;
  $httpProvider.defaults.withCredentials = true;
  delete $httpProvider.defaults.headers.common['X-Requested-With'];
  $httpProvider.defaults.headers.common["Accept"] = "application/json";
  $httpProvider.defaults.headers.common["Content-Type"] = "application/json";
});