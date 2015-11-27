var fridgeApp = {};

fridgeApp.bindEvents = function() {
  $(document).ready(function() {
    $('.toggle-button-text').on('click', function(e) {
      $(this).toggleClass('is-toggled');
    });

    $('.js-bar-toggle').on('click', function(e) {
      tempList = $(this).siblings('.temperature-list');
      tempList.toggleClass('has-bar-toggled');
    });

    $('.sidebar-extender-overlay').on('click', function(e) {
      e.stopPropagation();
      e.preventDefault();
      $('.body-container').addClass('is-expanded');

      $('.sidebar').one('click', function(e) {
        $('.body-container').removeClass('is-expanded');
      });
    });

    $('.js-change-filter').on('click', function(e) {
      $('.overlay-filters').addClass('is-visible');
    });

    $('.js-filter-submit, .overlay-filters-close').on('click', function(e) {
      $('.overlay-filters').removeClass('is-visible');
    });
  });
}

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

fridgeApp.getBarHeightString = function(temperature) {
  var heightPerCent = 0;

  if (temperature >= 45) {
    heightPerCent = 100;
  } else if (temperature <= 25) {
    heightPerCent = 5;
  } else {
    heightPerCent = (temperature - 24) * 5;
  }

  return {height: (100 - heightPerCent).toString() + "%"};
}

fridgeApp.interval = {
  TIME_INTERVAL: 10,
  list: [],
  temperatures: []
};

// Step through the given date by 10 minutes intervals and
// see if a temperature has been recorded during that interval
// Create an array of these 10 minute intervals with the associated temperature data
fridgeApp.interval.getTemps = function(date, temperatures) {
  fridgeApp.interval.list = [];
  fridgeApp.interval.temperatures = temperatures;
  fridgeApp.interval.createArray(date);
  fridgeApp.interval.addTemperatures(fridgeApp.interval.list);
  return fridgeApp.interval.list;
}

fridgeApp.interval.createArray = function(date) {
  var startDate = moment(date).startOf('day'),
    endDate = moment(date).endOf('day'),
    TIME_INTERVAL = fridgeApp.interval.TIME_INTERVAL;

  if (endDate > moment()) {
    endDate = moment().add(1, 'm');
  }

  while (startDate < endDate) {
    startDate.add(TIME_INTERVAL, 'm');

    fridgeApp.interval.list.push(
      {
        interval: startDate.format("YYYY-MM-DD h:mm:ss a"),
        temperature: { gap: TIME_INTERVAL, created_at: startDate.format("YYYY-MM-DD h:mm:ss a") }
      }
    );
  }

  return fridgeApp.interval.list;
}

fridgeApp.interval.addTemperatures = function() {
  var objs = fridgeApp.interval.list,
    temp;

  if (fridgeApp.interval.temperatures.length <= 0) {
    return;
  }

  for (var i = 0; i < objs.length; i++) {
    if (temp = fridgeApp.interval.findTemperatures(objs[i])) {
      objs[i].temperature = temp;
    }
  }

  fridgeApp.interval.list = objs;
}

fridgeApp.interval.findTemperatures = function(intervalObj) {
  var temps = fridgeApp.interval.temperatures,
    chosenTemp = false,
    intervalTime = moment(intervalObj.interval);

  for (var i = 0; i < temps.length; i++) {
    var time = moment(temps[i].created_at);

    if (time < intervalTime) {
      chosenTemp = temps[i];
      // Remove the temperature from the original array
      temps.splice(i, 1);
      // Step back an index so as not to skip over any items in the temperatures array
      i--;
    }
  }

  return chosenTemp;
}

// fridgeApp.appendNewData = function(newData, currentData) {
//   var key = newData["temps"];

//   for (var key in newData["temps"]) {
//     if (currentData.hasOwnProperty(key)) {
//       currentData[key]
//     }
//   }

//   return currentData;
// }
