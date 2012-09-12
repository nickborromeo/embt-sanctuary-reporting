# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
	
	$('div#date_range').show()
	$('#retrieve_error').hide()
	$('#loading').hide()
	$('#page_load').hide()
	
	$('table#license_table').tablesorter()
	
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
		
	$('#data_content.data_section #license_data.data_section div #paginator .pagination a').live 'click', ->
		
		move_page
		if $(@).attr('href').indexOf('page') is -1
			move_page = 1
		else
			move_page = $(@).attr('href').match(/page=([0-9]+)/)[1]
		
		$.ajax @href,
			type: 'POST'
			dataType: 'html'
			data: 
				start_date: $('input#start_date').val(),
				end_date: $('input#end_date').val(),
				account_name: $('input#account_name').val(),
				prod_family: $("input[name='prod_family']:checked").val()
				page: move_page
			cache: false
			beforeSend: ->
				$('#page_load').show()
			error: (jqXHR, textStatus, errorThrown) ->
				if(textStatus !=  'abort')
					$('#retrieve_error').show()			
			success: (data) ->
				$('#page_load').hide()
				$('#license_data').html(data)
				$('#license_data').show()
			
	$('button#start_search').click (e) ->
		e.preventDefault()
		
		$('#license_data').hide()

		$.ajax 'licenses/get_licenses',
			type: 'POST'
			dataType: 'html'
			data: 
				start_date: $('input#start_date').val(),
				end_date: $('input#end_date').val(),
				account_name: $('input#account_name').val(),
				prod_family: $("input[name='prod_family']:checked").val()
			cache: false
			ifModified: true
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