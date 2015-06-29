# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
	$(".job_role_search").click ->
	    ## Add job role id in hidden field.
	    job_role_id = $(this).attr("id")
	    $("#job_role_id").val(job_role_id)
	    $("#job_seeker_role_id").val(job_role_id)

	    ## Show selected role name and icon.
	    role_name = $(this).attr("name")
	    $(".job-role-lable").attr('class','job-role-lable ' + role_name)
	    $(".job-role-lable").text($(this).text())

	    $('#job_role_dropdown').dropdown 'toggle'
	    false

	$("#distance").change ->
		$("#distance_value").html($(this).val())
		return

	$("#hourly_rate").change ->
		$("#hourly_rate_value").html($(this).val())
		return