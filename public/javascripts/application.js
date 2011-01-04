// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(document).ajaxSend(function(event, request, settings) {	
  	if (typeof(AUTH_TOKEN) == "undefined") return;
	if (/authenticity_token=/.test(settings.data)) return;
	settings.data = settings.data || "";
	settings.data += (settings.data ? "&" : "") + "authenticity_token=" + encodeURIComponent(AUTH_TOKEN);
});


$.ajaxSetup({ 
  beforeSend: function(xhr) { xhr.setRequestHeader("Accept", "text/javascript"); } 
});

// Attach all javascript functionality when the DOM is ready
jQuery(document).ready(function() {
/*	jQuery('ul.sf-menu').superfish();
	jQuery('a[rel*=facebox]').facebox();

	$(".add_attendee").attach(AddAttendeeHandler);
	$(".remove_attendee").attach(RemoveAttendeeHandler);
	
	$(".character_raid").attach(CharacterRaidHandler);

	$(".toggle_attendee_waitlist").attach(ToggleAttendeeWaitlistHandler);
	$(".item").attach(AttendeeActions);
	$(".destroy_item").attach(DestroyItemHandler);
	
	$(".characters.show .adjustment").attach(AdjustmentToggleHandler);
	$("form input#adjustment_amount").attach(AdjustmentTextBlurHandler);
	$("form.character_adjustment").attach(CharacterAdjustmentFormHandler);
	$("form.new_drop").attach(RaidAddDropFormHandler);
	
	*/
	$("#add_attendee").click(function() {
		$("#attendees_add").slideToggle('slow');
		return false;
	});
	
	/*
	$("#add_item_button").click(function() {
		$("#items_add").slideToggle('slow');
		return false;
	});
	*/
});

/*RaidAddDropFormHandler = $.klass({
	onsubmit: function(submit) {
		var data = this.element.serializeArray();
		var $this_form = this.element;
		
		$.ajax({
			url: this.element.attr("action"),
			type: this.element.attr("method") || "GET",
			data: data,
			
			success: function(data, textStatus) {
				$this_form.clearForm();
			}
		});
		
		console.info("Submit form");
		return false;
	}
})

CharacterAdjustmentFormHandler = $.klass({
	onsubmit: function(submit) {
		var data = this.element.serializeArray();
		
		$.ajax({
			url: this.element.attr("action"),
			type: this.element.attr("method") || "GET",
			data: data,
			
			success: function(data, textStatus) {
				$("h2.adjustment span.value").text(data);
				$("form.character_adjustment #adjustment_amount").blur();
			}
		});
		return false;
	}
});

AdjustmentTextBlurHandler = $.klass({
	onblur: function() {
		$("form.character_adjustment").toggle();
		$("h2.adjustment").toggle();
	}
});

AdjustmentToggleHandler = $.klass({
	onclick: function() {
		this.element.toggle();
		$("form.character_adjustment").toggle();
		$("#adjustment_amount").focus();
	}
});

CharacterRaidHandler = $.klass({
	onclick: function() {
		character_id = this.element.parents(".attendee").attr("id").split("_")[1];
		
		if (this.element.parents(".attendee").hasClass("present")) {
			$("#raid_attendees").val($("#raid_attendees").val().replace(character_id + ", ", ""));
		} else {
			$("#raid_attendees").val(character_id + ", " + $("#raid_attendees").val());
		}
		
		this.element.parents(".attendee").toggleClass("present");
		this.element.parents(".attendee").toggleClass("wait_listed");
		
		return false;
	}
});

ToggleAttendeeWaitlistHandler = $.klass({	
	onclick: function() {
		url = this.element.attr("href");
		$attendee_element = this.element.parents(".item");
		
		$.ajax({
			data: '_method=put',
			type: 'PUT',
			url: url,
			
			success: function(data, textStatus) {
				if ($attendee_element.hasClass("present"))
					$attendee_element.toggleClass("present").addClass("wait_listed");
				else
					$attendee_element.toggleClass("wait_listed").addClass("present");
			}
		});
		return false;
	}
});

DestroyItemHandler = $.klass({
	onclick: function() {
		url = this.element.attr("href");
		$item_row = this.element.parents("tr");

		$.ajax({
			data: '_method=delete',
			type: 'DELETE',
			url: url,
			
			success: function(data, textStatus) {
				$item_row.fadeOut();
			}
		});

		return false;
	}
});

AddAttendeeHandler = $.klass({
	initialize: function(options) {
	},
	
	onclick: function() {
		url = this.element.attr("href");
		attendee_element = this.element.parents(".attendee");

		$.ajax({
			data: '_method=post',
			type: 'POST',
			url: url,
			
			success: function(data, textStatus) {
				attendee_element.fadeOut();
				$("#attendees_list").append(data);
			}
		});
		
		return false;
	}
});

RemoveAttendeeHandler = $.klass({
	initialize: function(options) {
		this.attendee_element = this.element.parents(".attendee");
	},
	
	onclick: function(a) {
		url = this.element.attr("href");
		attendee_element = this.attendee_element;

		$.ajax({
			data: '_method=delete',
			type: 'DELETE',
			url: url,
			
			success: function(data, textStatus) {
				attendee_element.fadeOut();
				$("#attendees_add").append(data);
			}
		});

		return false;
	}
});

AttendeeActions = $.klass({
	onmouseover: function() {
		this.element.children('.actions').show();
	},
	
	onmouseout: function() {
		this.element.children('.actions').hide();
	}
	
});
*/