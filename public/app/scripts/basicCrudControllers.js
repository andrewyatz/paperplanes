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
      $scope.list = PersonFactory.query();
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

// ----------- AWARD

app.controller('AwardCtrl', ['$scope', '$window', 'AwardFactory', 'Routes', function($scope, $window, AwardFactory, Routes) {

  $scope.edit = Routes.award.edit;
  $scope.create = Routes.award.create;
  $scope.cancel = Routes.award.list;
  
  $scope.delete = function(id, name) {
    if($window.confirm('Are you sure you want to delete '+name+'?')) {
      AwardFactory.delete({id: id});
      $scope.list = AwardFactory.query();
    }
  };
  
  $scope.list = AwardFactory.query();
}]);

app.controller('AwardEditCtrl', ['$scope', 'AwardFactory', 'AgencyFactory', 'Routes', '$routeParams', function($scope, AwardFactory, AgencyFactory, Routes, $routeParams) {
  $scope.cancel = Routes.award.list;
  
  $scope.submit = function() {
    $scope.obj.$update(function() {
      Routes.award.list();
    });
  };
  
  $scope.obj = AwardFactory.get({id: $routeParams.id});
  
  $scope.agencies = AgencyFactory.query();
}]);

app.controller('AwardCreateCtrl', ['$scope', 'AwardFactory', 'AgencyFactory', 'Routes', function($scope, AwardFactory, AgencyFactory, Routes) {
  $scope.obj = new AwardFactory();
  
  $scope.cancel = Routes.award.list;
  
  $scope.submit = function() {
    $scope.obj.$save(function() {
      Routes.award.list();
    });
  };
  
  $scope.agencies = AgencyFactory.query();
}]);

// ----------- PAPER

app.controller('PaperCtrl', ['$scope', '$window', 'PaperFactory', 'Routes', function($scope, $window, PaperFactory, Routes) {

  $scope.edit = Routes.paper.edit;
  $scope.create = Routes.paper.search;
  $scope.cancel = Routes.paper.list;
  
  $scope.delete = function(id, name) {
    if($window.confirm('Are you sure you want to delete the paper "'+name+'" and all associations?')) {
      PaperFactory.delete({id: id});
      $scope.papers = PaperFactory.query();
    }
  };
  
  $scope.papers = PaperFactory.query();
}]); 

app.controller('PaperEditCtrl', ['$scope', 'PaperFactory', 'AuthorCycle', 'ProjectFactory', 'TeamFactory', 'AwardFactory', 'PersonFactory', 'Routes', '$routeParams', function($scope, PaperFactory, AuthorCycle, ProjectFactory, TeamFactory, AwardFactory, PersonFactory, Routes, $routeParams) {
  $scope.cancel = Routes.award.list;
  $scope.cycleIgnore = AuthorCycle.cycleIgnore;
  
  $scope.projects = ProjectFactory.query();
  $scope.teams = TeamFactory.query();
  $scope.awards = AwardFactory.query();
  $scope.authors = PersonFactory.query();
  
  $scope.submit = function() {
    $scope.obj.$update(function() {
      Routes.paper.list();
    });
  };
  
  PaperFactory.get({id: $routeParams.id}).$promise.then(function(paper) {
    $scope.selectedAwards = [];
    $scope.matchedAuthors = [];
    
    paper.paper_awards.forEach(function(element){
      $scope.selectedAwards.push({
        "award_id" : element.award_id,
        
      });
    });
    paper.paper_people.forEach(function(element){
      var author = {
        "person_id" : element.person_id,
        "position" : element.person_order,
        "last_name" : element.person.last_name,
        "last_name" : element.person.last_name,
      };
      AuthorCycle.cycle(author);
      $scope.matchedAuthors.push(author);
    });
    
    $scope.paper = {
      "paper_id" : paper.paper_id,
      "doi" : paper.doi,
      "title" : paper.title,
      "author_count" : paper.author_count,
      "authorString" : paper.author_string,
      "journalTitle" : paper.journal,
      "pubYear" : paper.pub_year
    };
  });
}]);

app.controller('PaperSearchCtrl', ['$scope', '$http', '$filter', '$location', 'Routes', '$routeParams', function($scope, $http, $filter, $location, Routes, $routeParams) {
  
  $scope.itemOptions = [
    { number: 3, label: "View 3 per page"},
    { number: 5, label: "View 5 per page"},
    { number: 10, label: "View 10 per page"},
    { number: -1, label: "View all"},
  ];
  
  $scope.currentPage = 1;
  $scope.itemsPerPage = $scope.itemOptions[2].number;
  $scope.maxSize = 100;
  $scope.numPages = 10;
  $scope.filteredResults = [];
  $scope.results = [];
  
  $scope.authorLimit = 50;

  $scope.$watch('results + currentPage + itemsPerPage + sortType + sortReverse', function() {
    if($scope.results.length === 0) {
      return;
    }
    var begin = (($scope.currentPage - 1) * $scope.itemsPerPage);
    var end = begin + $scope.itemsPerPage;
    if($scope.sortType) {
      $scope.results = $filter('orderBy')($scope.results, $scope.sortType, $scope.sortReverse);
    }
    $scope.filteredResults = $scope.results.slice(begin, end);
  });
  
  $scope.search = function() {
    $scope.searching = true;
    $scope.filteredResults = [];
    $scope.results = [];
    $scope.sortType = undefined;
    $location.search('query', $scope.searchText);    
    $http.get('/searchpmc.json?q='+$scope.searchText, {responseType: "json"}).then(function (response) {
      $scope.searching = false;
      $scope.currentPage = 1;
      $scope.results = response.data.results;
    });
  };
  
  if($routeParams.query) {
    $scope.searchText = $routeParams.query;
    $scope.search();
  }
    
  $scope.selectPaper = Routes.paper.create;
}]);

app.controller('PaperCreateCtrl', ['$scope', '$http', '$window', 'Routes', '$routeParams', 'ProjectFactory', 'TeamFactory', 'AwardFactory', 'PersonFactory', 'PaperFactory', 'AuthorCycle', function($scope, $http, $window, Routes, $routeParams, ProjectFactory, TeamFactory, AwardFactory, PersonFactory, PaperFactory, AuthorCycle) {

  $scope.projects = ProjectFactory.query();
  $scope.teams = TeamFactory.query();
  $scope.awards = AwardFactory.query();
  $scope.authors = PersonFactory.query();
  
  $scope.setAuthorIconText= AuthorCycle.cycle;
  $scope.cycleIgnore = AuthorCycle.cycleIgnore;
  
  //Do we need to check if we have this paper already?
  //Save in the database (plus write the schema to handle this)
  $scope.$watch('paper', function() {
    if(typeof($scope.paper) === 'undefined') {
      return;
    }
    
    $http.post('/paper/matchauthors', $scope.paper.authors).then(function(response) {
      response.data.results.forEach($scope.setAuthorIconText);
      $scope.matchedAuthors = response.data.results;
    });
  });
  
  $http.get('/searchpmc.json?resultstype=core&q=DOI:'+$routeParams.doi).then(function(response) {
    $scope.paper = response.data.results[0];
  });
  
  $scope.selectedAwards = [];
  $scope.addAward = function() {
    $scope.selectedAwards.push({ });
  };
  $scope.removeAward = function(row) {
    $scope.selectedAwards.splice(row, 1);
  };
  
  $scope.addAutocompleteAward = function(award) {
    var original = award.originalObject;
    var alreadyThere = false;
    $scope.selectedAwards.forEach(function(element) {
      if(original.name === element.name) {
        alreadyThere = true;
      }
    });
    
    if(! alreadyThere) {
      $scope.selectedAwards.push(original);
    }
  };
  
  $scope.addAutocompleteAuthor = function(author) {
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
  
  $scope.cancel = function() {
    $window.history.back()
  };
  
  $scope.submit = function() {
    var obj = new PaperFactory({
      "title" : $scope.paper.title,
      "journal" : $scope.paper.journalTitle,
      "pub_year" : $scope.paper.pubYear,
      "doi" : $scope.paper.doi,
      "paper_people" : [],
      "paper_projects" : []
    });
    $scope.matchedAuthors.forEach(function(element) {
      if(typeof(element.person_id) !== undefined ) {
        obj.paper_people.push({"person_id" : element.person_id, "person_order" : element.position });
      }
    });
    $scope.selectedAwards.forEach(function(element) {
      if(typeof(element) !== undefined ) {
        obj.paper_project.push({"award_id" : element.award_id});
      }
    });
    
    obj.$save(function() {
      Routes.paper.list();
    });
  };
  
}]);