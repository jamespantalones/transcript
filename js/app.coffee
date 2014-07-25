tag = document.createElement('script')
tag.src = "//www.youtube.com/iframe_api"
firstScriptTag = document.getElementsByTagName('script')[0]
firstScriptTag.parentNode.insertBefore(tag, firstScriptTag)
player = {}
flag = 0
state = 0
duration = 0
width = $(document).width()
ratio = 390 / 640
YTheight = width / 2
YTwidth = YTheight * ratio


window.onYouTubeIframeAPIReady = ->
	player = new YT.Player('player', {
		height: YTwidth
		width: YTheight
		videoId: 'CG48Y5dL9J8',
		events: {
			'onReady': onPlayerReady
			'onStateChange': onPlayerStateChange
		}
		})

onPlayerReady = (event) ->
	event.target.playVideo()
	state = player.getPlayerState()
	setInterval(youTubeTime, 5000)

onPlayerStateChange = (event) ->
	console.log event.data
	if (event.data == 1)
		initData()
		duration = player.getDuration()
		if flag == 0
			state = event.data
			showProgressControls()
			flag = 1
		else
			return
	if (event.data == 0)
		hideProgressControls()
		localStorage.setItem('progress', 0)



initData = ->
	$('.text span').bind 'click', ->
		seconds = $(@).data 'time'
		player.seekTo(seconds, true)
	$('.resume a').bind 'click', ->
		retrieveProgress(duration)
	$('.reset a').bind 'click', ->
		resetPlaying()
	$(window).bind 'resize', ->
		resizeVideo()


resumePlaying = ->
	retrieveProgress(duration)

resetPlaying = ->
	localStorage.setItem('progress',0)
	console.log "Progress reset"
	player.seekTo(0)

youTubeTime = ->
	currentTime = player.getCurrentTime()
	currentTime = Math.floor currentTime
	saveProgress(currentTime)

	

saveProgress = (currentTime) ->
	console.log 'storage called'
	progress = localStorage.getItem('progress')
	if currentTime > progress
		localStorage.setItem('progress', currentTime)
		console.log "progress saved at #{currentTime}"
	else
		console.log "progress not saved, since it's less than your previous progress"
		return 0

showProgressControls = ->
	progress = localStorage.getItem('progress')
	if progress
		$('.reset').show()
		$('.resume').show()

hideProgressControls = ->
	$('.reset').fadeOut()
	$('.resume').fadeOut()


retrieveProgress = (duration) ->
	progress = localStorage.getItem('progress')
	if progress < Math.floor(duration)
		#give it a 5 second preroll
		player.seekTo(progress - 3)
		console.log "Video started from previous position of #{progress-3} minus three seconds"
	else
		localStorage.setItem('progress',0)

resizeVideo = ->
	width = $(document).width()
	YTwidth = width / 2.5
	YTheight = YTwidth * ratio
	$('#player').attr('width', YTwidth)
	$('#player').attr('height', YTheight)












