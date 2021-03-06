// Generated by CoffeeScript 1.10.0
var defferredActions;

defferredActions = angular.module('defferredActions', []);

defferredActions.controller('waitTimer', function($scope, $timeout) {
  var butWidth, timerValue;
  $scope.app = "Приложение работает!";
  $scope.wait = {};
  $scope.wait.active = false;
  $scope.intID = 0;
  $scope.pr = 0;
  butWidth = 40;
  timerValue = 6;
  $scope.styles = {
    "progressButton": {
      "width": butWidth + "px"
    },
    "shutter": {
      "left": butWidth + "px"
    }
  };
  $scope.animate = function() {
    var c, iteration, mSec, myTimer, pixShift, shift;
    if ($scope.wait.active) {
      $scope.wait.active = false;
      $timeout.cancel($scope.pr);
      $scope.wait.transparent = "";
      $scope.styles.shutter.left = butWidth + "px";
    } else {
      $scope.wait.timer = timerValue;
      $scope.wait.active = true;
      $scope.wait.transparent = "transparent";
      $scope.app = "Таймер запущен";
      mSec = timerValue * 1000;
      if (mSec % butWidth === 0) {
        iteration = mSec / butWidth;
      } else {
        alert("Ошибка расчета таймера отложенного удаления пользователя: время таймера (текущее: " + mSec + "мс) должно быть кратно ширине кнопки (текущая: " + butWidth + "px), т.к. анимация рассчитывается попиксельно. Для исправления ошибки измените настройки кнопки и обновите страницу");
        return;
      }
      pixShift = butWidth / iteration;
      c = mSec;
      shift = butWidth;
      myTimer = function() {
        if (c === 0) {
          console.log("Время вышло!");
          return;
        }
        $scope.styles.shutter.left = shift + "px";
        shift--;
        if (c % 1000 === 0) {
          $scope.wait.timer = c / 1000;
        }
        c -= iteration;
        $scope.pr = $timeout(function() {
          myTimer();
        }, iteration);
      };
      myTimer();
    }
  };
});
