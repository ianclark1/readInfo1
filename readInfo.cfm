<cfprocessingdirective suppresswhitespace="yes">
<cfoutput>
<cfparam name="attributes.lesstext" default="" type="string">
<cfparam name="attributes.css" default="" type="string">
<cfparam name="attributes.fulltext" default="" type="string">
<cfparam name="attributes.more" default="More" type="string">
<cfparam name="attributes.less" default="Less" type="string">
<cfparam name="attributes.popup" default="" type="string">
<script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>
<cfset isMoz = FindNoCase('Mozilla/5.0','#CGI.HTTP_USER_AGENT#')>
<cfif attributes.css NEQ "">
  <style>
	body,div {#attributes.css#}
</style>
</cfif>
<cfif attributes.popup NEQ "">
  <style>
##backgroundPopup{
display:none;
<cfif isMoz>
position:fixed;
<cfelse>
position:absolute; /* hack for internet explorer 6*/
</cfif>
height:100%;
width:100%;
top:0;
left:0;
background:##000000;
border:1px solid ##cecece;
z-index:1;
}
##popupContact{
display:none;
<cfif isMoz>
position:fixed;
<cfelse>
position:absolute; /* hack for internet explorer 6*/
</cfif>
height:300px;
width:408px;
background:##FFFFFF;
border:2px solid ##cecece;
z-index:2;
padding:12px;
font-size:13px;
}
##popupContact h1{
text-align:left;
color:##6FA5FD;
font-size:22px;
font-weight:700;
border-bottom:1px dotted ##D3D3D3;
padding-bottom:2px;
margin-bottom:20px;
}
##popupContactClose{
font-size:14px;
line-height:14px;
right:6px;
top:4px;
position:absolute;
color:##6fa5fd;
font-weight:700;
text-decoration:underline;
<cfif isMoz>
cursor: pointer;
<cfelse>
cursor: hand;
</cfif>
display:block;
}
</style>
</cfif>
<cfif attributes.popup NEQ "">
<script language="javascript1.5">
//0 means disabled; 1 means enabled;
var popupStatus = 0;
//loading popup with jQuery magic!
function loadPopup(){
	//loads popup only if it is disabled
	if(popupStatus==0){
		$("##backgroundPopup").css({
			"opacity": "0.7"
		});
		$("##backgroundPopup").fadeIn("slow");
		$("##popupContact").fadeIn("slow");
		popupStatus = 1;
	}
}

//disabling popup with jQuery magic!
function disablePopup(){
	//disables popup only if it is enabled
	if(popupStatus==1){
		$("##backgroundPopup").fadeOut("slow");
		$("##popupContact").fadeOut("slow");
		popupStatus = 0;
	}
}

//centering popup
function centerPopup(){
	//request data for centering
	var windowWidth = document.documentElement.clientWidth;
	var windowHeight = document.documentElement.clientHeight;
	var popupHeight = $("##popupContact").height();
	var popupWidth = $("##popupContact").width();
	//centering
	$("##popupContact").css({
		"position": "absolute",
		"top": windowHeight/2-popupHeight/2,
		"left": windowWidth/2-popupWidth/2
	});
	//only need force for IE6
	
	$("##backgroundPopup").css({
		"height": windowHeight
	});
	
}

//CONTROLLING EVENTS IN jQuery
$(document).ready(function(){
	//LOADING POPUP
	//Click the button event!
	$("a.readmore").click(function(){
		//centering with css
		centerPopup();
		//load popup
		loadPopup();
	});
				
	//CLOSING POPUP
	//Click the x event!
	$("##popupContactClose").click(function(){
		disablePopup();
	});
	//Click out event!
	$("##backgroundPopup").click(function(){
		disablePopup();
	});
	//Press Escape event!
	$(document).keypress(function(e){
		if(e.keyCode==27 && popupStatus==1){
			disablePopup();
		}
	});

});
</script>
  <cfelse>
  <script language="javascript1.2">
$(document).ready(function() {
	$('.message').hide();
	$('a.readless').hide();
		$('a.readmore').click(function(){
				$('.message').fadeIn('slow');
				$('a.readless').fadeIn('slow');
		$('span').hide('slow');
		$('a.readmore').hide('slow');		
	});
	
	$('a.readless').click(function(){
			$('span').fadeOut('slow');
			$('div.message').fadeOut('slow');
		$('span').show('slow');
			$('a.readless').hide('slow');
			$('.readmore').show('slow');		
	});
});
</script>
</cfif>
<cfif attributes.lesstext IS "" AND attributes.fulltext IS "">

<h1>Error! Please Provide full text as well as less Text and the ID of the Record to show a Read More Link</h1>
<cfabort>
</cfif>
<cfif attributes.popup NEQ "">
  <div>#attributes.lesstext#</div>
  <a href="##" class="readmore">#attributes.more#</a>
  <div id="popupContact">
		<a id="popupContactClose">[Close X]</a>
		<br><br>
        <div style="overflow:auto;height:280px;">#attributes.fulltext#</div>
	</div>
	<div id="backgroundPopup"></div>
  <cfelse>
  <span>#attributes.lesstext#</span> <a href="##" class="readmore">#attributes.more#</a>
  <div class="message">#attributes.fulltext#</div>
  <a href="##" class="readless">#attributes.less#</a>
</cfif>
</cfoutput>
</cfprocessingdirective>
