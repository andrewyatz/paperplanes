'use strict';

angular.module('PaperPlanesApp', [
  'ngRoute',
  'PaperPlanesApp.services',
  'PaperPlanesApp.basicCrudControllers',
  'PaperPlanesApp.directives'
  ])
.config(function ($routeProvider, $httpProvider) {
  
  var servicesList = ['AgencyFactory', 'TeamFactory', 'ProjectFactory', "PersonFactory"];
  var targets = ["agency", "team", "project", "person"];
  
  $routeProvider.when('/agency-list', {templateUrl: 'app/views/agency-list.html', controller: 'AgencyCtrl'});
  $routeProvider.when('/agency-edit/:id', {templateUrl: 'app/views/agency-edit.html', controller: 'AgencyEditCtrl'});
  $routeProvider.when('/agency-create', {templateUrl: 'app/views/agency-create.html', controller: 'AgencyCreateCtrl'});
  
  $routeProvider.when('/project-list', {templateUrl: 'app/views/project-list.html', controller: 'ProjectCtrl'});
  $routeProvider.when('/project-edit/:id', {templateUrl: 'app/views/project-edit.html', controller: 'ProjectEditCtrl'});
  $routeProvider.when('/project-create', {templateUrl: 'app/views/project-create.html', controller: 'ProjectCreateCtrl'});
  
  $routeProvider.when('/team-list', {templateUrl: 'app/views/team-list.html', controller: 'TeamCtrl'});
  $routeProvider.when('/team-edit/:id', {templateUrl: 'app/views/team-edit.html', controller: 'TeamEditCtrl'});
  $routeProvider.when('/team-create', {templateUrl: 'app/views/team-create.html', controller: 'TeamCreateCtrl'});
  
  $routeProvider.when('/person-list', {templateUrl: 'app/views/person-list.html', controller: 'PersonCtrl'});
  $routeProvider.when('/person-edit/:id', {templateUrl: 'app/views/person-edit.html', controller: 'PersonEditCtrl'});
  $routeProvider.when('/person-create', {templateUrl: 'app/views/person-create.html', controller: 'PersonCreateCtrl'});
  
  $routeProvider.otherwise({redirectTo: '/'});

  /* CORS... */
  /* http://stackoverflow.com/questions/17289195/angularjs-post-data-to-external-rest-api */
  // $httpProvider.defaults.useXDomain = true;
  // delete $httpProvider.defaults.headers.common['X-Requested-With'];
});