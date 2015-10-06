'use strict';

var directives = angular.module('PaperPlanesApp.directives', []);

directives.directive('focus',
	function($timeout) {
		return {
			scope : {
				trigger : '@focus'
			},
			link : function(scope, element) {
				scope.$watch('trigger', function(value) {
					if (value === "true") {
						$timeout(function() {
							element[0].focus();
						});
					}
				});
			}
		};
	}
); 

var ORCID_REGEXP = /^\d{4}-\d{4}-\d{4}-\d{4}$/;
directives.directive('orcid', function($q, $timeout) {
  return {
    require: 'ngModel',
    link: function(scope, elm, attrs, ctrl) {
      ctrl.$validators.orcid = function(modelValue, viewValue) {
        if (ctrl.$isEmpty(modelValue)) {
          return true;
        }
        if (ORCID_REGEXP.test(viewValue)) {
          return true;
        }
        return false;
      };
    }
  };
});