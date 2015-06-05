app = require '../app'

app.controller 'InputCtrl', ($scope, $calc) ->

  $scope.input = (n) ->
    $calc.input n
    $scope.$parent.$broadcast 'newInput', n

  $scope.calculate = ->
    $calc.doMath()
    $scope.$parent.$broadcast 'result'
