var offer = true;
var request = true;
$( document ).ready(function() {
	$('.requestShow').click(function(){
			$('.request').show();
			$('.offer').show();
		   if(offer == true && request == true) {
		// code to be executed if condition is true
		$('.offer').hide();
		offer = true;
		request = false;
		$('.requestShow').toggleClass('Active');
		
	} 
	else if(offer == true && request == false){
		$('.offer').show();
		offer = true;
		request = true;
		// code to be executed if condition is false
		$('.requestShow').toggleClass('Active');
	}	    
	});

	$('.offerShow').click(function(){
			$('.request').show();
			$('.offer').show();
	    if(offer == true && request == true) {
			// code to be executed if condition is true
			$('.request').hide();
			$('.offerShow').toggleClass('Active');
			offer = false;
			request = true;
			
		} 
		else if(offer == false && request == true){
			$('.request').show();
			$('.offerShow').toggleClass('Active');
			offer = true;
			request = true;
			// code to be executed if condition is false
		}
	});

  	$('#simple-menu').sidr({
  		onOpen: function() {
            $('#header').css({ 'left' : 'auto'});
            $('#plusle-message').css({ 'left' : 'auto'});
      //       if ($('body').hasClass('mobile')) {
    		// 	$('#plusle').css({ 'left' : 'auto'});
    			
    		// }
        },
        onClose: function() {
        	setTimeout(function(){ 
        		$('#header').css({ 'left' : '0px'});
        		$('#plusle-message').css({ 'left' : '0px'});
        		// if ($('body').hasClass('mobile')) {
        		// 	$('#plusle').css({ 'left' : '0px'});
        			
        		// }
        	}, 100);
        }
  	});
	$('body').on('click', function() {
		if($('body').hasClass('sidr-open')) {
			$.sidr('close');
		}
	});
	
	var pageWidth = $('body').width();
	if (pageWidth >= 801) {
		$('body').addClass('desktop');
	} else if (pageWidth < 801) {
		$('body').addClass('mobile');
	}

	var active = '';	
	$('.tags').click(function(){
		$.sidr('close');
		var status = $(this).attr('data-filter');
		if(active != status){
		 	$('.list-item').each(function(i, obj) {
		 	$(this).hide();
		 	if($(this).attr('data').indexOf(status) != -1){
		 		$(this).show();
		 		
		 	}
	     	
		 });
		 active = status;
		}else if(active == status){
		$('.list-item').each(function(i, obj) {
		 $(this).show();
		 	
	     	
		 });
		active = "";
	}    
	});

	$('.marketpost-message').click(function() {
		var id = $(this).attr('data-id');
		$('#transaction_marketpost_id').attr('value', id);
	});
	$('.btn-send').click(function() {
		$('#myModal').modal('hide');
	});

	$('#myModal, #addModal').on('shown', function () {
	    $('#transaction_description').focus();
	});

	$('.login-header').parent('#header').css({'background' : 'none', 'position' : 'absolute' });

	$(window).resize(function() {
		var pageWidthResize = $('body').width();
		if (pageWidthResize >= 801) {
			$('body').removeClass().addClass('desktop');
		} else if (pageWidthResize < 801) {
			$('body').removeClass().addClass('mobile');
		}
	});

		$(".list-item-header").on('click', function() {
			if ($('body').hasClass('mobile')) {
				var parent = $(this).parent(".list-item");
	    		$(parent).children(".list-item-body").slideToggle();
	    	}
		});
});


