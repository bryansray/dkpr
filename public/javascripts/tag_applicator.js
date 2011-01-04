jQuery(document).ready(function() {
/*	$("#taggings_form").ajaxForm({ success: show_response });*/

/*	$('.manage-tags').bind('click', function() { alert('click'); });*/
	$('.manage-tags').click(RemoveTaggingHandler);
/*	$(".manage-tags").attach(ManageTagsHandler);
	$(".remove-tag").attach(RemoveTaggingHandler);*/
});

function show_response(responseText, statusText) {
	$("#tags-container").replaceWith(responseText);
}

RemoveTaggingHandler = function(a, b) {
	$(".tag-editor-inputs").slideToggle(1000, function() {

	});
};

/*RemoveTaggingHandler = $.klass({
	onclick: function(event) {
		url = this.element.attr("href");
		tag_element = this.element.parent();
		
		$.ajax({
			type: 'DELETE',
			data: '_method=delete',
			url: url,
			
			success: function(data, textStatus) {
				tag_element.fadeOut();
			}
		});
		return false;
	}
});
*/

ManageTagsHandler = function() {
	alert('clicked');
};
/*
ManageTagsHandler = $.klass({
	onclick: function(event) {
		// $("#tag_list").toggle();
		$(".tag-editor-inputs").slideToggle(1000, function() {

		});
		return false;
	}
});*/