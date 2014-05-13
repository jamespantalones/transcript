var tag = document.createElement('script');

tag.src = "https://www.youtube.com/iframe_api";
var firstScriptTag = document.getElementsByTagName('script')[0];
firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

var player, playing;
var textCollection = [];
var textLength;
var currentText;

function onYouTubeIframeAPIReady(){
	player = new YT.Player('player', {
		height: '390',
		width: '640',
		videoId: 'CG48Y5dL9J8',
		events: {
			'onReady' : onPlayerReady
		}
	});
}

function onPlayerReady(event){
	event.target.playVideo();
	youTubeTime();
}

$('.text span').click(function(){
	seconds = $(this).data('time');
	player.seekTo(seconds, true);
});


function youTubeTime(){
	currentTime = player.getCurrentTime();
	currentTime = Math.floor(currentTime);
	checkText(currentTime);
	setTimeout(youTubeTime, 1000);
}




function checkText(currentTime){
	$('.text span').each(function(x){
		var spanTime = parseInt($(this).data('time'),10);
		currentText = $(this).text();
		splitCurrent();
		if (spanTime === currentTime){
			$('.squirt span').empty().text(currentText);
		}
	});
	
}

function splitCurrent(){
	
}


