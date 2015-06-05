# required modules
angular = require "angular"
require "angular-material"
require "angular-material-icons"

module.exports = angular.module "ngMaterialCalculator", [
    "ngMaterial"
    "ngMdIcons"
  ]

  # angular material config
  .config ($mdThemingProvider) ->
    $mdThemingProvider.theme "default"
      .primaryPalette "brown"
      .accentPalette "teal"
    return

# bootstrap angular app
angular.element(document).ready ->
  angular.bootstrap document, ['ngMaterialCalculator']
