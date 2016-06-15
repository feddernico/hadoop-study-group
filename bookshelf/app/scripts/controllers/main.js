'use strict';

/**
 * @ngdoc function
 * @name bookshelfApp.controller:MainCtrl
 * @description
 * # MainCtrl
 * Controller of the bookshelfApp
 */
angular.module('bookshelfApp')
  .controller('MainCtrl', function ($scope) {
    $scope.awesomeThings = [
      'HTML5 Boilerplate',
      'AngularJS',
      'Karma'
    ];
  });
