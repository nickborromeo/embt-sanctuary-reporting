# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
	
	$('table#license_table').dataTable
		sPaginationType: 'full_numbers'
		sScrollX: "100%"
		bRetrieve: true
		bDestroy: true
		aoColumnDefs:[
			sWidth: '350px'
			aTargets: [1]
		]
	
	$('div#date_range').show()
	$('div#company_filter').hide()
	$('#retrieve_error').hide()
	$('#loading').hide()
	
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
		
	fetchingLicenses = null
	
	$('input#start_search').click (e) ->
		e.preventDefault
		sDate = $('input#start_date').val()
		eDate = $('input#end_date').val()
		
		$('#license_data').hide()
		
		if(fetchingLicenses)
			fetchingLicenses.abort()
		
		fetchingLicenses = $.ajax 'licenses/get_licenses',
			type: 'POST'
			data: 
				start_date: sDate,
				end_date: eDate
			cache: false
			beforeSend: ->
				$('#loading').show()
				$('#retrieve_error').hide()			
			complete: (result) ->
				$('#loading').hide()
				fetchingLicenses = null
			error: (jqXHR, textStatus, errorThrown) ->
				if(textStatus !=  'abort')
					$('body').append "AJAX Error #{textStatus}" 
			success: (data, textStatus, jqXHR) ->
				$('#license_data').empty().append "#{data}"
				$('#license_data').show()
				
				
				