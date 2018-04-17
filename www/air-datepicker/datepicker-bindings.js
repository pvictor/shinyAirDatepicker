
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
  getValue: function(el) {
  	//return el.value;
  	return $('#' + $escapeAirPicker(el.id)).selectedDates;
  },
  setValue: function(el, value) {
  	$('#se' + $escapeAirPicker(el.id)).selectDate(value);
  },
  subscribe: function(el, callback) {
   $('#' + $escapeAirPicker(el.id)).on('change', function(event) {
     callback();
   });
   $('#' + $escapeAirPicker(el.id) + '_AirPicker').on('click', function(event) { // on click
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
  },
  getState: function(el) {
  	return {
    	//label: $(el).parent().find('label[for=' + el.id + ']').text(),
    	value: this.getValue(el)//el.value
  	};
  }
});
Shiny.inputBindings.register(AirPickerInputBinding, 'shiny.AirPickerInput');
