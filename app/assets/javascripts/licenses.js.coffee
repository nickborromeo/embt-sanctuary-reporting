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
	$('#retrieve_error').hide()
	$('#loading').hide()
	
	$('a#set_date_range').click (e) ->
		e.preventDefault()
		$('div#date_range').show()
		$('div#company_filter').hide()
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
	
	$('button#start_search').click (e) ->
		e.preventDefault
		sDate = $('input#start_date').val()
		eDate = $('input#end_date').val()
		aName = $('input#account_name').val()
		pFamily = $("input[name='prod_family']").val()
		
		$('#license_data').hide()

		$.ajax 'licenses/get_licenses',
			type: 'POST'
			data: 
				start_date: sDate,
				end_date: eDate,
				account_name: aName,
				prod_family: pFamily
			cache: false
			beforeSend: ->
				$('#loading').show()
				$('#retrieve_error').hide()
			loading: ->
				$('#loading').show()			
			complete: (result) ->
				$('#loading').hide()
			error: (jqXHR, textStatus, errorThrown) ->
				if(textStatus !=  'abort')
					$('#retrieve_error').show()			
			success: (data) ->
				$('#license_data').html(data)
				$('#license_data').show()
				
				