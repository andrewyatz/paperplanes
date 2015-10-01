'use strict';

/* Controllers */

var app = angular.module('PaperPlanesApp.basicCrudControllers', []);

app.controller('AgencyCtrl', ['$scope', '$window', 'AgencyFactory', 'Routes', function($scope, $window, AgencyFactory, Routes) {

  $scope.edit = Routes.agency.edit;
  $scope.create = Routes.agency.create;
  $scope.cancel = Routes.agency.list;
  
  $scope.delete = function(id, name) {
    if($window.confirm('Are you sure you want to delete '+name+'?')) {
      AgencyFactory.delete({id: id});
      $scope.agencies = AgencyFactory.query();
    }
  };
  
  $scope.agencies = AgencyFactory.query();
}]);

app.controller('AgencyEditCtrl', ['$scope', 'AgencyFactory', 'Routes', '$routeParams', function($scope, AgencyFactory, Routes, $routeParams) {
  $scope.cancel = Routes.agency.list;
  
  $scope.submit = function() {
    $scope.agency.$update(function() {
      Routes.agency.list();
    });
  };
  
  $scope.agency = AgencyFactory.get({id: $routeParams.id});
}]);

app.controller('AgencyCreateCtrl', ['$scope', 'AgencyFactory', 'Routes', function($scope, AgencyFactory, Routes) {
  $scope.agency = new AgencyFactory();
  
  $scope.cancel = function() {
    Routes.agency.list();
  };
  
  $scope.submit = function() {
    $scope.agency.$save(function() {
      Routes.agency.list();
    });
  };
}]);

//------------- PROJECT WORK

app.controller('ProjectCtrl', ['$scope', '$window', 'ProjectFactory', 'Routes', function($scope, $window, ProjectFactory, Routes) {

  $scope.edit = Routes.project.edit;
  $scope.create = Routes.project.create;
  $scope.cancel = Routes.project.list;
  
  $scope.delete = function(id, name) {
    if($window.confirm('Are you sure you want to delete '+name+'?')) {
      ProjectFactory.delete({id: id});
      $scope.projects = ProjectFactory.query();
    }
  };
  
  $scope.projects = ProjectFactory.query();
}]);

app.controller('ProjectEditCtrl', ['$scope', 'ProjectFactory', 'Routes', '$routeParams', function($scope, ProjectFactory, Routes, $routeParams) {
  $scope.cancel = Routes.project.list;
  
  $scope.submit = function() {
    $scope.project.$update(function() {
      Routes.project.list();
    });
  };
  
  $scope.project = ProjectFactory.get({id: $routeParams.id});
}]);

app.controller('ProjectCreateCtrl', ['$scope', 'ProjectFactory', 'Routes', function($scope, ProjectFactory, Routes) {
  $scope.project = new ProjectFactory();
  
  $scope.cancel = Routes.project.list;
  
  $scope.submit = function() {
    $scope.project.$save(function() {
      Routes.project.list();
    });
  };
}]);

//------------ TEAM WORK

app.controller('TeamCtrl', ['$scope', '$window', 'TeamFactory', 'Routes', function($scope, $window, TeamFactory, Routes) {

  $scope.edit = Routes.team.edit;
  $scope.create = Routes.team.create;
  $scope.cancel = Routes.team.list;
  
  $scope.delete = function(id, name) {
    if($window.confirm('Are you sure you want to delete '+name+'?')) {
      TeamFactory.delete({id: id});
      $scope.teams = TeamFactory.query();
    }
  };
  
  $scope.teams = TeamFactory.query();
}]);

app.controller('TeamEditCtrl', ['$scope', 'TeamFactory', 'Routes', '$routeParams', function($scope, TeamFactory, Routes, $routeParams) {
  $scope.cancel = Routes.team.list;
  
  $scope.submit = function() {
    $scope.team.$update(function() {
      Routes.team.list();
    });
  };
  
  $scope.team = TeamFactory.get({id: $routeParams.id});
}]);

app.controller('TeamCreateCtrl', ['$scope', 'TeamFactory', 'Routes', function($scope, TeamFactory, Routes) {
  $scope.team = new TeamFactory();
  
  $scope.cancel = Routes.team.list;
  
  $scope.submit = function() {
    $scope.team.$save(function() {
      Routes.team.list();
    });
  };
}]);

// ----------- PEOPLE

app.controller('PersonCtrl', ['$scope', '$window', 'PersonFactory', 'Routes', function($scope, $window, PersonFactory, Routes) {

  $scope.edit = Routes.person.edit;
  $scope.create = Routes.person.create;
  $scope.cancel = Routes.person.list;
  
  $scope.delete = function(id, name) {
    if($window.confirm('Are you sure you want to delete '+name+'?')) {
      PersonFactory.delete({id: id});
      $scope.teams = PersonFactory.query();
    }
  };
  
  $scope.list = PersonFactory.query();
}]);

app.controller('PersonEditCtrl', ['$scope', 'PersonFactory', 'TeamFactory', 'ProjectFactory', 'Routes', '$routeParams', function($scope, PersonFactory, TeamFactory, ProjectFactory, Routes, $routeParams) {
  $scope.cancel = Routes.person.list;
  
  $scope.submit = function() {
    $scope.obj.$update(function() {
      Routes.person.list();
    });
  };
  
  $scope.obj = PersonFactory.get({id: $routeParams.id});
  $scope.teams = TeamFactory.query();
  $scope.projects = ProjectFactory.query();
}]);

app.controller('PersonCreateCtrl', ['$scope', 'PersonFactory', 'TeamFactory', 'ProjectFactory', 'Routes', function($scope, PersonFactory, TeamFactory, ProjectFactory, Routes) {
  $scope.obj = new PersonFactory();
  
  $scope.cancel = Routes.person.list;
  
  $scope.submit = function() {
    $scope.obj.$save(function() {
      Routes.person.list();
    });
  };
  
  $scope.teams = TeamFactory.query();
  $scope.projects = ProjectFactory.query();
}]);
