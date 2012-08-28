# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
	$('div#date_range').show()
	$('div#company_filter').hide()
	
	$('a#set_date_range').click (e) ->
		e.preventDefault()
		$('div#date_range').show()
		$('div#company_filter').hide()
		false
	
	$('a#set_company_filter').click (e) ->
		e.preventDefault()
		$('div#date_range').hide()
		$('div#company_filter').show()
		false
		
	$('input#start_date').datepicker
		dateFormat: 'mm/dd/yy'
		showOn: 'button'
		buttonImage: '/assets/calendar.png'
		buttonImageOnly: true
	
	$('input#end_date').datepicker
		dateFormat: 'mm/dd/yy'
		showOn: 'button'
		buttonImage: '/assets/calendar.png'
		buttonImageOnly: true
		
	$('input#start_date_c').datepicker
		dateFormat: 'mm/dd/yy'
		showOn: 'button'
		buttonImage: '/assets/calendar.png'
		buttonImageOnly: true

	$('input#end_date_c').datepicker
		dateFormat: 'mm/dd/yy'
		showOn: 'button'
		buttonImage: '/assets/calendar.png'
		buttonImageOnly: true
		
	$('table#license_table').dataTable
		sPaginationType: 'full_numbers'
		sScrollX: "100%"
		aoColumnDefs:[
			sWidth: '350px'
			aTargets: [1]
		]
		
	$('input#start_search').click (e) ->
		e.preventDefault
		sDate = $('input#start_date').val()
		eDate = $('input#end_date').val()
		
		$.ajax 'licenses/get_licenses',
			type: 'POST'
			data: 
				start_date: sDate,
				end_date: eDate
			error: (jqXHR, textStatus, errorThrown) ->
				$('body').append "AJAX Error #{textStatus}" 
			success: (data, textStatus, jqXHR) ->
				$('section#data_content').append "#{data}"
		
		
		