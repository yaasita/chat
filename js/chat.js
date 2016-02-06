
$(function(){
	loadAndAppend(1,false);
	$("#hatugen").click(function(){kakikomi()});
	var name = unescape(document.cookie.split("="));
	$("#name").val(name[1]);
	$("#msg").keypress(function (e){
	if (e.which == 13){
		kakikomi();
		}
	});
	//Timer1 = setInterval (function (){loadAndAppend(nextid(),true)},2000);
});

function kakikomi(){
	$.post('./cgi/writedb.pl',{name:$('#name').val(),msg:$('#msg').val()},function(){
			//clearInterval(Timer1);
			loadAndAppend(nextid(),false);
			window.scrollBy(0,100);
			});
	$('#msg').val("");
	document.cookie = 
		'name=' + escape($('#name').val()) + '; '
		+  'expires=' + new Date(2030, 1).toUTCString();
}
var prvdata;
var nowdata;

function loadAndAppend(num,async){
	$.ajax({
	url: "./cgi/read.pl",
	async: async,
	type: "POST",
	data: "log="+num,
	dataType: "text",
	success: function(data,dataType){
		nowdata=data;
		if (prvdata == nowdata) {
			return true;
		}
		else {
			$("#chatlog").append(data);
			prvdata=data;
			$("table tbody tr:even").addClass("odd");
			}
		}
	});
}

function nextid(){
	var array =  $("tr").get().reverse();
	return parseInt(array[0].id) + 1;
}
