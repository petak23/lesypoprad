$(function() {  $.nette.init();	$( "#locale" ).change(function() {			$( "#datepicker" ).datepicker( "option",				$.datepicker.regional[ 'sk' ] );	});	$("input.date").each(function () { // input[type=date] does not work in IE        var el = $(this);        var value = el.val();        var date = (value ? $.datepicker.parseDate($.datepicker.W3C, value) : null);        var minDate = el.attr("min") || null;        if (minDate) minDate = $.datepicker.parseDate($.datepicker.W3C, minDate);        var maxDate = el.attr("max") || null;        if (maxDate) maxDate = $.datepicker.parseDate($.datepicker.W3C, maxDate);        // input.attr("type", "text") throws exception        if (el.attr("type") === "date") {            var tmp = $("<input/>");            $.each("class,disabled,id,maxlength,name,readonly,required,size,style,tabindex,title,value".split(","), function(i, attr)  {                tmp.attr(attr, el.attr(attr));            });            el.replaceWith(tmp);            el = tmp;        }        el.datepicker({            minDate: minDate,            maxDate: maxDate        });        el.val($.datepicker.formatDate(el.datepicker("option", "dateFormat"), date));    });//  $(".fotky").colorbox({//    rel:'fotky',//    loop: false,//    transition:"elastic",//    current: "{current} z {total}",//    previous: "&lt;-",//    next: "-&gt;",//    close: "Koniec"//	});//  $(".youtube").colorbox({iframe:true, innerWidth:640, innerHeight:390});//	$(".vimeo").colorbox({iframe:true, innerWidth:500, innerHeight:409});  	//Pre zobrazenie celého článku	var cely = $('.cely_clanok'); //Nájdem doplnok textu	//var ostatok = $('.ostatok');	cely.parent().next().hide();              //Skryjem ho	//ostatok.hide();	cely.click(function() { //Pri kliku na článok		$(this).fadeOut(200, function() {			$(this).remove();	//Odstránim odkaz			//ostatok.slideDown('slow');		}).parent().next().slideDown('slow');//fadeIn('slow');			  //Skryjem samotný odkaz		return false; 					  //Zakážem odkaz	});	//Pre zobrazenie celého oznamu	var cely = $('.cely_oznam'); //Nájdem doplnok textu	var textC = cely.next().html();		//Najdem cely text	var textU = cely.prev();		//Najdem upraveny text	cely.next().hide().remove();              //Skryjem ho	cely.click(function() { //Pri kliku na článok		textU.append('<span class="ost">' + textC + '</span>');		var ost = $('.ost');		ost.hide();		$(this).fadeOut(200, function() {			$(this).remove();	//Odstránim odkaz  		ost.slideDown('slow');		});//.next().slideDown('slow');//fadeIn('slow');			  //Skryjem samotný odkaz		return false; 					  //Zakážem odkaz	});	// Pre zobrazenie tagu, ktorý je pred položkou s id=nova_polozka na ktorú sa kliklo//	$('#nova_polozka').click(function() {//		$(this).prev().slideDown(1000);//		$(this).delay(1000).fadeTo(500,.01).slideUp(500, function() {//			$(this).remove();	//Odstránim odkaz//		});//		return false;//	});	// Pre zobrazenie tagu, ktorý je pred položkou s id=nova_upload, na ktorú sa kliklo	// a pre ukrytie nasledujúceho//	$('#nova_upload').click(function()	{//		$(this).prev().slideDown(1000);//		$(this).next().slideUp(1000);//		$(this).fadeTo(500,.01).slideUp(500, function() {//			$(this).remove();	//Odstránim odkaz//		});//		return false;//	});	// Pre zmiznutie hlásenia cez funkciu stav_dobre//	$('.st_zmiz').delay(2500).fadeTo(500,.01).slideUp(500, function() {//		$(this).remove();	//Odstránim odkaz//	});////	$('.stav').click(function() {//		$(this).fadeTo(500,.01).slideUp(500, function() {//			$(this).remove();	//Odstránim odkaz//		});//	});////  $('.stav').delay(5000).fadeTo(1000,0, function() {//		$(this).remove();	//Odstránim odkaz//	});//  $('.alert').delay(5000).fadeTo(1000,0, function() {//		$(this).remove();	//Odstránim odkaz//	});//	$("#cela_nav").css({'display': 'none'});//	$(".menu_ukaz").click(function() {//		$(".menu_ukaz").fadeOut("fast", function(){//			$("#cela_nav").slideDown(1000);//		});//		return false;//	});//  var login_form = $("#my-sign-in-form");//	$(".log-in").click(function() {//		login_form.slideDown(500, function() {//      $(".prihlasujem").css("opacity", 1);//    });//		return false;//	});////	$("#frmsignInForm-login").click(function() {//    login_form.after('<div class="prihlasujem">Prihlasujem...</div>');//    login_form.fadeTo(250, .3);//	});  //  $('.carousel').carousel({//    interval: 2000//  });});