defferredActions = angular.module 'defferredActions', []

defferredActions.controller 'waitTimer', ($scope, $timeout) ->
  $scope.app = "Приложение работает!"
  $scope.wait = {}
  $scope.wait.active = false
  #$scope.wait.timerVal = 5

  $scope.intID = 0 # id таймера
  $scope.pr = 0
  #$scope.wait.width = angular.element('#wt-base').width()

  # Настройки приложения

  timerValue = 5 # Время ожидания, оно же время на анимацию кнопки

  # Настраиваемые стили приложения

  butWidth = 40
  $scope.styles =
    "progressButton":
      "width": "#{butWidth}px"
    "shutter":
      "left": "#{butWidth}px"


  # Анимация кнопки

  $scope.animate = ->
    # Показываем или скрываем прогресс-бар
    if $scope.wait.active
      $scope.wait.active = false
      $timeout.cancel $scope.pr
      #clearInterval $scope.intID
    else # изначально false
      $scope.wait.timer = timerValue
      $scope.wait.active = true
      $scope.wait.transparent = "transparent"
      $scope.app = "Таймер запущен"

      c = timerValue

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



  return
