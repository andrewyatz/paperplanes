'use strict';

var services = angular.module('PaperPlanesApp.services', ['ngResource']);

var servicesList = ['AgencyFactory', 'TeamFactory', 'ProjectFactory', "PersonFactory"];
var targets = ["agency", "team", "project", "person"];

for (var index = 0; index < targets.length; index++) {
  var entry = targets[index];
  var serv = servicesList[index];

  // Create a factory for each type of basic service and add a PUT method to each
  var func = function(localEntry, localServ) {
    var url = entry + '/:id.json';
    var idLookup = '@' + entry + '_id';
    services.factory(localServ, ['$resource', function($resource) {
      return $resource(url, {
        id: idLookup
      }, {
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
    data.finish = new Date(data.finish);
    return data;
  };
  return $resource('award/:id.json', {
    id: '@award_id'
  }, {
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

services.factory('PaperFactory', ['$resource', function($resource) {
  return $resource('paper/:id.json', {
    id: '@paper_id'
  }, {
    update: {
      method: 'PUT'
    },
    get: {
      method: "GET"
    },
    save: {
      method: "POST"
    }
  });
}]);


services.factory('Routes', ['$location', function($location) {
  var routes = {};

  // Create the basic CRUD URLs, which expand 
  // to /XXXXX-list, /XXXXX-create and /XXXXX-edit/ID
  // mapped under list, create and edit respectively


  for (var index = 0; index < targets.length; index++) {
    var entry = targets[index];
    var func = function(localEntry) {
      routes[localEntry] = {
        "list": function() {
          $location.path('/' + localEntry + '-list');
        },
        "create": function() {
          $location.path('/' + localEntry + '-create');
        },
        "edit": function(id) {
          $location.path('/' + localEntry + '-edit/' + id);
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
      $location.path('/award-edit/' + id)
    }
  };

  routes['paper'] = {
    search: function() {
      $location.path('/search-papers');
      $location.url($location.path());
    },
    list: function(doi) {
      $location.path('/paper-list');
      $location.url($location.path());
    },
    edit: function(id) {
      $location.path('/paper-edit/' + id)
    },
    create: function(id) {
      $location.path('/paper-create/' + id)
    }
  };

  return routes;
}]);

services.factory('AuthorCycle', [function() {
  var cycle = function(author) {
    if (typeof(author.person_id) === "undefined") {
      author.info = {
        icon: 'glyphicon-question-sign',
        colour: 'text-warning',
        tooltip: 'Author not known to the system'
      };
    } else {
      if (author.ignore) {
        author.info = {
          icon: 'glyphicon-remove-sign',
          colour: 'text-danger',
          tooltip: 'Author ignored. Click to link this author'
        };
      } else {
        author.info = {
          icon: 'glyphicon-ok-sign',
          colour: 'text-success',
          tooltip: 'Author will be linked. Click to ignore the link'
        };
      }
    }
  };
  
  var cycleIgnore = function(author) {
    if (typeof(author.person_id) !== undefined) {
      author.ignore = (author.ignore) ? false : true;
    }
    cycle(author);
  };
  
  var function(author) {
    var original = author.originalObject;
    var alreadyThere = false;
    $scope.matchedAuthors.forEach(function(element) {
      if( original.person_id === element.person_id ) {
        alreadyThere = true;
      }
    });
    if(! alreadyThere) {
      var clone = JSON.parse(JSON.stringify(original));
      clone.initals = original.first_name.charAt(0);
      clone.split_initals = [clone.initals];
      clone.position = 0;
      clone.team = original.default_team;
      clone.project = original.default_project;
      clone.ignore = false;
      $scope.setAuthorIconText(clone);
      $scope.matchedAuthors.unshift(clone);
    }
  };

  return {
    "cycle" : cycle,
    "cycleIgnore" : cycleIgnore,
  };
}]);
