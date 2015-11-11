var fridgeApp = {
  TIME_INTERVAL: 10
};

fridgeApp.getTemperatureItemClass = function(temperature) {
  var color = "";

  if (temperature >= 32 && temperature <= 40) {
    color = "green";
  } else if (temperature < 32) {
    color = "blue";
  } else if (temperature > 40 && temperature <= 45) {
    color = "orange";
  } else {
    color = "red";
  }

  return "temperature-item temperature-" + color;
}

fridgeApp.getTimeIntervalTemps = function(date, temperatures) {
  var intervalDate = moment(date);
}
