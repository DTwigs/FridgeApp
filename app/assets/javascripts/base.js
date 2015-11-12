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
  var startDate = moment(date).startOf('day'),
    endDate = moment(date).endOf('day'),
    intervalTemps = [];


  if (endDate > moment()) {
    endDate = moment();
  }

  // Each iteration represents a 10 minute interval of time
  while (startDate < endDate) {

    var temporary = [];
    startDate.add(10, 'm'); // now start date is 10 minutes ahead of previous start date

    // Loop through all of the temperatures from the DB
    for (var i = 0; i < temperatures.length; i++) {
      var time = moment(temperatures[i].created_at);

      if (time < startDate) {
        temporary.push(temperatures[i]);
        // Remove the temperature from the original array
        temperatures.splice(i, 1);
        // Step back an index so as not to skip over any items in the temperatures array
        i--;
      }
    }

    // If no temperatures found, add a gap
    if (temporary.length <= 0) {
      temporary = [{ gap: 10, created_at: startDate.format("dddd, MMMM Do YYYY, h:mm:ss a") }]
    }
    // Push the last item from the temporary array into the final interval Temps array
    intervalTemps.push(temporary[temporary.length - 1]);
  }

  return intervalTemps;
}
