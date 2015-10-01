'use strict';

/* Controllers */

var app = angular.module('PaperPlanesApp.navControllers', []);

app.controller('HeaderCtrl', ['$scope', '$location', function($scope, $location) {
  
  $scope.isActive = function (viewLocation) { 
    return $location.path().indexOf(viewLocation) == 0;
  };
  
  $scope.isActiveEqual = function (viewLocation) {
    return $location.path === viewLocation;
  }
  
}]);
