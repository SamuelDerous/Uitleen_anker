
$(function() {
    var dialog;
    // a workaround for a flaw in the demo system (http://dev.jqueryui.com/ticket/4375), ignore!
		$( "#dialog:ui-dialog" ).dialog( "destroy" );
		
	var name = $( "#naam" ),
			email = $( "#email" ),
			password = $( "#bedrijf" ),
			allFields = $( [] ).add( name ).add( email ).add( password ),
			tips = $( ".validateTips" );		
	
		function updateTips( t ) {
			tips
				.text( t )
				.addClass( "ui-state-highlight" );
			setTimeout(function() {
				tips.removeClass( "ui-state-highlight", 1500 );
			}, 500 );
		}


		
							
		function checkLength( o, n, min, max ) {
			if ( o.val().length > max || o.val().length < min ) {
				o.addClass( "ui-state-error" );
				updateTips( "Length of " + n + " must be between " +
					min + " and " + max + "." );
				return false;
			} else {
				return true;
			}
		}

		function checkRegexp( o, regexp, n ) {
			if ( !( regexp.test( o.val() ) ) ) {
				o.addClass( "ui-state-error" );
				updateTips( n );
				return false;
			} else {
				return true;
			}
		}
		
		dialog = $( "#form" ).dialog({
			autoOpen: false,
			height: 170,
			width: 200,
			modal: true,
			closeOnEscape:true,
			buttons: {
				"Reserveer": function() {
					$("#reserveer").submit();
						
					}
				
				}
                        
		});

		$( "#create" )
			.button()
			.click(function() {
				dialog.dialog( "open" );
			});
			
	});
