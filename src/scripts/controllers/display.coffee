app = require '../app'

app.controller 'DisplayCtrl', ($scope, $calc) ->

  $scope.display = ''
  $scope.bottomDisplay = ''

  $scope.$on 'newInput', ($e, n) ->
    $scope.display = $calc.display()
    console.log $e, n
    $scope.bottomDisplay = $calc.getMath() unless $calc.isOperator n

  $scope.$on 'result', ->
    $scope.display = $calc.display()
    $scope.bottomDisplay = ''
