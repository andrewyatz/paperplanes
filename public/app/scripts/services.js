'use strict';

var services = angular.module('PaperPlanesApp.services', ['ngResource']);

var servicesList = ['AgencyFactory', 'TeamFactory', 'ProjectFactory', "PersonFactory"];
var targets = ["agency", "team", "project", "person"];

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

services.factory('AwardFactory', ['$resource', function($resource) {
  var responseTransform = function(data, headers) {
    data = angular.fromJson(data);
    data.start = new Date(data.start);
    data.end = new Date(data.end);
    return data;
  };
  return $resource('award/:id.json', {id: '@award_id'}, {
    update: {
      method: 'PUT',
      transformResponse: responseTransform
    },
    get: {
      method: "GET",
      transformResponse: responseTransform
    },
    save: {
      method: "POST",
      transformResponse: responseTransform
    }
  });
}]);


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
  
  routes['award'] = {
    list: function() {
      $location.path('/award-list')
    },
    create: function() {
      $location.path('/award-create')
    },
    edit: function(id) {
      $location.path('/award-edit/'+id)
    }
  };
  
  routes['paper'] = {
    create: function(doi) {
      $location.path('/paper-create/'+doi);
      $location.url($location.path());
    }
  };
  
  return routes;
}]);


