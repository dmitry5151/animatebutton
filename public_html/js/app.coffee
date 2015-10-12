defferredActions = angular.module 'defferredActions', []

defferredActions.controller 'waitTimer', ($scope, $timeout) ->
  $scope.app = "Приложение работает!"
  $scope.wait = {}
  $scope.wait.active = false
  $scope.wait.timerVal = 5

  $scope.intID = 0 # id таймера
  $scope.pr = 0
  #$scope.wait.width = angular.element('#wt-base').width()

  # Анимация кнопки

  $scope.animate = ->
    # Показываем или скрываем прогресс-бар
    if $scope.wait.active
      $scope.wait.active = false
      $timeout.cancel $scope.pr
      #clearInterval $scope.intID
    else
      $scope.wait.timer = $scope.wait.timerVal = 5
      $scope.wait.active = true
      $scope.app = "Таймер запущен"

      c = $scope.wait.timerVal

      myTimer = ->

        if c == 0
          console.log "Время вышло!"
          return
        $scope.wait.timer = c
        c--
        $scope.pr = $timeout ->
          do myTimer
          return
        , 1000
        #console.log pr
        return

      do myTimer

    return

  $scope.setTime = (t) ->
    $scope.wait.timer = t
    return


  return
