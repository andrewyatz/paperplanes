'use strict';

var services = angular.module('PaperPlanesApp.services', ['ngResource']);

var servicesList = ['AgencyFactory', 'TeamFactory', 'ProjectFactory'];
var targets = ["agency", "team", "project"];

for(var index = 0; index < targets.length; index++) {
  var entry = targets[index];
  var serv = servicesList[index];
  
  // Create a factory for each type of basic service and add a PUT method to each
  var func = function (localEntry, localServ) {
    var url = entry+'/:id.json';
    var idLookup = '@'+entry+'_id';
    services.factory(localServ, ['$resource', function($resource){
      return $resource(url, { id: idLookup }, {
          update: {
            method: 'PUT'
          }
        });
    }]);
  };
  func(entry, serv);
}

services.factory('Routes', ['$location', function($location) {
  var routes = {};
  
  // Create the basic CRUD URLs, which expand 
  // to /XXXXX-list, /XXXXX-create and /XXXXX-edit/ID
  // mapped under list, create and edit respectively
  
  
  for(var index = 0; index < targets.length; index++) {
    var entry = targets[index];
    var func = function (localEntry) {
      routes[localEntry] = {
        "list" : function() {
          $location.path('/'+localEntry+'-list');
        },
        "create" : function() {
          $location.path('/'+localEntry+'-create');
        },
        "edit" : function(id) {
          $location.path('/'+localEntry+'-edit/'+id);
        }
      };
    };
    func(entry);
  }
  
  return routes;
}]);