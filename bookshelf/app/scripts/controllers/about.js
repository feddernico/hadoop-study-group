'use strict';

/**
 * @ngdoc function
 * @name bookshelfApp.controller:AboutCtrl
 * @description
 * # AboutCtrl
 * Controller of the bookshelfApp
 */
angular.module('bookshelfApp')
  .controller('AboutCtrl', function ($scope) {
    $scope.awesomeThings = [
      'HTML5 Boilerplate',
      'AngularJS',
      'Karma'
    ];
  });
