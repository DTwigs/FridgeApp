var fridgeApp = {};

fridgeApp.indicateCurrentTime = function() {
  $(document).ready(function() {
    var minutes = moment.duration(moment()).asMinutes(),
      intervals = Math.ceil(minutes / 10);

      $('.timeline-item').removeClass('is-current-time');

      timelineItem = $('.timeline-item:nth-child(' + intervals + ')')
      timelineItem
        .addClass('is-current-time')
        .html("<div class='timeline-item-clock'>" + moment().format('h:mm a') + "</div>");
  });

}

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
  setInterval(this.indicateCurrentTime, 15000);
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
  fridgeApp.interval.addTemperatures();
  return fridgeApp.interval.list;
}

fridgeApp.interval.createArray = function(date) {
  var startDate = moment(date).startOf('day'),
    endDate = moment(date).endOf('day');

  // if end date is in the future, set it to the current time
  if (endDate > moment()) {
    endDate = moment().add(1, 'm');
  }

  return fridgeApp.interval.addTimeGaps(startDate, endDate);
}

// Add a time gape for every 10 minute interval in time between
// the start and end date
fridgeApp.interval.addTimeGaps = function(startDate, endDate) {
  var TIME_INTERVAL = fridgeApp.interval.TIME_INTERVAL;

  while (startDate < endDate) {
    startDate.add(TIME_INTERVAL, 'm');

    // add a time gap for every interval in the list
    // this time gap will get replaced with data in #addTemperatures if a temperature exists
    fridgeApp.interval.list.push(
      {
        interval: startDate.format("YYYY-MM-DD h:mm:ss a"),
        temperature: { gap: TIME_INTERVAL, created_at: startDate.format("YYYY-MM-DD h:mm:ss a") }
      }
    );
  }

  return fridgeApp.interval.list;
}

// This method is used for appending new time gaps to the end of an
// existing list of intervals
fridgeApp.interval.addNewTimeIntervals = function(date, currentData) {
  var intervals = currentData[date],
    lastInterval = intervals[intervals.length - 1],
    startDate = moment(lastInterval.interval),
    endDate = moment().add(1, 'm');

  fridgeApp.interval.list = intervals;

  return fridgeApp.interval.addTimeGaps(startDate, endDate);
}

// Find and Add a temperature to each time interval in the array
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

// Find a temperature that fits in the interval block
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

fridgeApp.appendNewData = function(newData, currentData) {
  for (var key in newData["temps"]) {
    fridgeApp.interval.temperatures = newData["temps"][key];
    if (currentData.hasOwnProperty(key)) {
      fridgeApp.interval.addNewTimeIntervals(key, currentData);
      fridgeApp.interval.addTemperatures();
    } else {
      fridgeApp.interval.getTemps(key, newData["temps"][key]);
    }
  }

  return currentData;
}
