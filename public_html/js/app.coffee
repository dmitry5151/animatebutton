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

  butWidth       = 40 # Ширина кнопки - нужно для расчета итераций прохода шторки и задания принудительной ширины самой кнопки

  timerValue     = 6  # Время ожидания, оно же время на анимацию кнопки
  #timerIteration = 100 # Время одной итерации в миллисекундах

  # Настраиваемые стили приложения

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
      $scope.wait.transparent = ""
      $scope.styles.shutter.left = "#{butWidth}px" # Взводим шторку
      #clearInterval $scope.intID
    else # изначально false
      $scope.wait.timer = timerValue
      $scope.wait.active = true
      $scope.wait.transparent = "transparent"
      $scope.app = "Таймер запущен"

      mSec = timerValue*1000 # Время таймера в миллисекундах (5000)
      # Всего итераций - по кол-ву пикселей в ширине кнопки
      # нужно получить время на один сдвиг в мсек
      if mSec%butWidth == 0
        iteration = mSec/butWidth # Получаем время одной итерации по кол-ву пикселей в ширине кнопки
      else
        alert "Ошибка расчета таймера отложенного удаления пользователя: время таймера (текущее: #{mSec}мс) должно быть кратно ширине кнопки (текущая: #{butWidth}px), т.к. анимация рассчитывается попиксельно. Для исправления ошибки измените настройки кнопки и обновите страницу"
        return
      pixShift = butWidth/iteration    # Разовый сдвиг шторки в пикселях

      c = mSec
      #timerVal = timerValue
      shift = butWidth


      myTimer = ->
        #console.log c
        if c == 0
          console.log "Время вышло!"
          # Запускаем процедуру удаления пользователя

          return
        # Опускаем шторку
        $scope.styles.shutter.left = "#{shift}px"
        shift--
        # Обновляем счетчик на кнопке
        if c%1000 == 0
          $scope.wait.timer = c/1000 # Переписать - не считаются некоторые значения секунд
        c -= iteration # Проверять, чтобы время таймера и размер итерации были кратны (делились без остатка)
        $scope.pr = $timeout ->
          do myTimer
          return
        , iteration #
        return

      # Вызываем таймер
      do myTimer

    return



  return
