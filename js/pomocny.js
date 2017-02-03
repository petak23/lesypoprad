function zobrazdat(boxid) {  
   if(document.getElementById(boxid).style.display=="none"){
    document.getElementById(boxid).style.display="block";}
   else{
    document.getElementById(boxid).style.display="none";}   
  }
  function zobrazdat_vym(boxid1, boxid2) {  
   if(document.getElementById(boxid1).style.display=="none"){
    document.getElementById(boxid1).style.display="block";
	document.getElementById(boxid2).style.display="none";
   }
   else{
    document.getElementById(boxid1).style.display="none";
	document.getElementById(boxid2).style.display="block";
   }   
  }  
  function zobrPrihlas() {  
    if(document.getElementById('prihlas1').style.display=="none"){
    document.getElementById('prihlas1').style.display="block";}
   else{
    document.getElementById('prihlas1').style.display="none";}   
  }  
	$(function() {
		$(".datepicker").datepicker({ 
		    minDate: "-10Y", maxDate: "+10Y",
				altFormat: "yy-mm-dd"
		});
		$( "#locale" ).change(function() {
			$( ".datepicker" ).datepicker( "option",
				$.datepicker.regional[ 'sk' ] );
		});
		$( "#datepicker" ).datepicker({ 
		    minDate: "-10Y", 
				maxDate: "+10Y",
			altField: "#alternate",
			altFormat: "yy-mm-dd"
		});
		$( "#locale" ).change(function() {
			$( "#datepicker" ).datepicker( "option",
				$.datepicker.regional[ 'sk' ] );
		});
		$('#clanok img').lazyload({
		        //placeholder : 'layout/ikony/bila.gif',
                effect : 'fadeIn',
                failurelimit : 20
        });
	});
