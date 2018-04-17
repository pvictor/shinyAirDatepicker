
// airDatepicker bindings //
// by Vic //


var exportsAirPicker = window.Shiny = window.Shiny || {};
var $escapeAirPicker = exportsAirPicker.$escape = function(val) {
  return val.replace(/([!"#$%&'()*+,.\/:;<=>?@\[\\\]^`{|}~])/g, '\\$1');
};

var AirPickerInputBinding = new Shiny.InputBinding();
$.extend(AirPickerInputBinding, {
  initialize: function initialize(el) {
    var options = {};
		if ($(el).attr('data-start-date')) {
			options.startDate = new Date(JSON.parse($(el).attr('data-start-date')));
			$(el).removeAttr('data-start-date');
		}
		options.onSelect = function(formattedDate, date, inst) {
      $(el).trigger('change');
    };
    var dp = $(el).datepicker(options).data('datepicker');
    dp.selectDate(options.startDate);
  },
  find: function(scope) {
  	return $(scope).find('.sw-air-picker');
  },
  getId: function(el) {
  	//return InputBinding.prototype.getId.call(this, el) || el.name;
  	return $(el).attr('id');
  },
  getType: function(el) {
    return 'air.datepicker';
  },
  getValue: function(el) {
  	//return el.value;
  	var sd = $(el).datepicker().data('datepicker').selectedDates;
  	if (sd.length > 0) {
  	  // console.log(sd);
  	  var res = sd.map(function(e) { 
  	    //console.log(e);
        return e.yyyymmdd();
      });
  	  return res;
  	}
  	
  },
  setValue: function(el, value) {
  	$('#' + $escapeAirPicker(el.id)).selectDate(value);
  },
  subscribe: function(el, callback) {
   $(el).on('change', function(event) {
     callback();
   });
  },
  unsubscribe: function(el) {
  	$(el).off('.AirPickerInputBinding');
  },
  receiveMessage: function(el, data) {
  	if (data.hasOwnProperty('value')) this.setValue(el, data.value);

    if (data.hasOwnProperty('label')) {
      // console.log(el);
      $(el).parent().find('label[for="' + data.id + '"]').text(data.label);
    }

    if (data.hasOwnProperty('placeholder')) {
      // why [0] ??
      $('#se' + data.id)[0].placeholder = data.placeholder;
    }

    $(el).trigger('change');
  }
});
Shiny.inputBindings.register(AirPickerInputBinding, 'shiny.AirPickerInput');

function parse_date(date) {
  return date.getUTCFullYear() + '-' + date.getUTCMonth() + '-' + date.getUTCDate();
}

Date.prototype.yyyymmdd = function() {
  var mm = this.getMonth() + 1; // getMonth() is zero-based
  var dd = this.getDate();

  return [this.getFullYear(),
          (mm>9 ? '' : '0') + mm,
          (dd>9 ? '' : '0') + dd
         ].join('-');
};
