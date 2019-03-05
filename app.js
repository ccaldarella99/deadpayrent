var myElement = document.getElementById('music');
var swipeElement = document.getElementById('swipe');
var list = [['music', 'photo', 'video', 'press','contact'],
			['music2', 'photo2', 'video2', 'press2','contact2']];
var listBtn = [['music_btn', 'photo_btn', 'video_btn', 'press_btn','contact_btn'],
				['music_btn2', 'photo_btn2', 'video_btn2', 'press_btn2','contact_btn2']];
var listLength = list[0].length;
var listLength2 = list[1].length;
var getId = 0;
var x = 0;
var y = 0;

//let picsArray = ["DCS_0614.JPG", "DCS_0620.JPG", "DCS_0622.JPG", "DCS_0624.JPG"];
var thisSlide = 0;
var picSlide = 0;
slideShow(picSlide);
closeOverlay('slideshow', 'slideshow-contents');

//PROMOTIONAL: BEEN HERE BEFORE
openOverlay('promo_bhb','promo_bhb-contents');

//Slide Show OVERLAY

document.onkeydown = function(evt) {
	evt = evt || window.event;
	var isEscape = false;
	var isLeft = false;
	var isRight = false;
	
	if ("key" in evt) {
		isEscape = (evt.key == "Escape" || evt.key == "Esc");
		isLeft = (evt.key == "ArrowLeft");
		isRight = (evt.key == "ArrowRight");
	} else {
		isEscape = (evt.keyCode == 27);
		isLeft = (evt.keyCode == 37);
		isRight = (evt.keyCode == 39);
	}
	if (isEscape) {
		closeOverlay('slideshow', 'slideshow-contents');
	}
	if (isLeft) {
		slideShow(-1);
	}
	if (isRight) {
		slideShow(1);
	}
};

function slideShow(n) {
	var pSlides = document.getElementsByClassName("slide-img");
	var maxSlides = pSlides.length;
	
	picSlide += n;
	if (picSlide >= maxSlides) {
		picSlide = 0;
	} else if (picSlide < 0) {
		picSlide = maxSlides-1;
	}

	for (var i = 0; i < maxSlides; i++) {
		pSlides[i].style.display = "none";
	}
	
	pSlides[picSlide].style.display = "inline-block";
}


function slideShowMobile(n) {
	var pSlides = document.getElementsByClassName("slide-img-mob");
	var maxSlides = pSlides.length;
	
	picSlide += n;
	if (picSlide >= maxSlides) {
		picSlide = 0;
	} else if (picSlide < 0) {
		picSlide = maxSlides-1;
	}

	for (var i = 0; i < maxSlides; i++) {
		//console.log(pSlides[i]);
		//pSlides[i].style.display = "none";
		//document.getElementById(pSlides[i]).classList.remove('show-img-mob');
		//document.getElementById(pSlides[i]).classList.add('hide-img-mob');
		pSlides[i].classList.remove('show-img-mob');
		pSlides[i].classList.add('hide-img-mob');
	}
	
	//pSlides[picSlide].style.display = "inline-block";
	//document.getElementById(pSlides[picSlide]).classList.add('show-img-mob');
	pSlides[picSlide].classList.remove('hide-img-mob');
	pSlides[picSlide].classList.add('show-img-mob');
}


function openOverlayMobile(item, content, n) {
	if (n>=0) {
		picSlide = 0;
		slideShowMobile(n);
	}
	document.getElementById(item).style.width = "100%";
	//document.getElementById("escape").style.display = "block";
	document.getElementById(content).style.display = "inline-block";
	
	document.getElementById('left-btn-mob').style.display = "block";
	document.getElementById('right-btn-mob').style.display = "block";
}

function closeOverlayMobile(item, content) {
	document.getElementById(content).style.display = "none";
	//document.getElementById("escape").style.display = "none";
	document.getElementById(item).style.width = "0%";
	
	document.getElementById('left-btn-mob').style.display = "none";
	document.getElementById('right-btn-mob').style.display = "none";
}


function openOverlay(item, content, n) {
	if (n>=0) {
		picSlide = 0;
		slideShow(n);
	}
	document.getElementById(item).style.width = "100%";
	document.getElementById("escape").style.display = "block";
	document.getElementById(content).style.display = "inline-block";
}

function closeOverlay(item, content) {
	document.getElementById(content).style.display = "none";
	document.getElementById("escape").style.display = "none";
	document.getElementById(item).style.width = "0%";
}


//Gestures:

function mdown(ev) {
	if (ev.type == "mousedown")
	{
		x = ev.clientX;
		y = ev.clientY;
	} else if (ev.type == "touchstart") {
		x = ev.changedTouches[0].pageX;
		y = ev.changedTouches[0].pageY;
	}
}

function mup(ev) {
	if (ev.type == "mouseup")
	{
		var newX = ev.clientX;
		var newY = ev.clientY;
	} else if (ev.type == "touchend") {
		var newX = ev.changedTouches[0].pageX;
		var newY = ev.changedTouches[0].pageY;
	}
	var dX = x - newX;
	var dY = y - newY;
	for (var i=0; i<listLength2; i++)
	{
		if(document.getElementById(list[1][i]) == myElement)
		{ getId = i; }
	}
	if (dX!=0 && Math.abs(dY/dX) < 1)
	{
		if (dX < 0)
		{
			if(getId == 0)
			{ getId = listLength2 - 1;} 
			else 
			{ getId = getId-1; }
			myElement = list[1][getId]
			loadContent(myElement, 1);
		}
		if (dX > 0)
		{
			if(getId == listLength2 - 1)
			{ getId = 0; } 
			else 
			{ getId = getId+1; }
			myElement = list[1][getId]
			loadContent(myElement, 1);
		}
	}
	var menu = document.getElementById('menu');
	var changed = false;
	if(menu.classList.contains('show') && !changed)
	{
		menu.classList.remove('show');
		menu.classList.add('hide');
		changed = true;
	}
}


//Load Tabs

function loadContent(name, num) {
	for (var i=0; i<listLength2; i++) {
		if(list[num][i] == name) {
			document.getElementById(list[num][i]).classList.remove('hide');
			document.getElementById(list[num][i]).classList.add('show');
			document.getElementById(listBtn[num][i]).classList.add('on-focus');
		} else {
			document.getElementById(list[num][i]).classList.remove('show');
			document.getElementById(list[num][i]).classList.add('hide');
			document.getElementById(listBtn[num][i]).classList.remove('on-focus');
		}
	}
}


//Mobile hamburger Menu

function hamburger() {
	var menu = document.getElementById('menu');
	var changed = false;
		if(menu.classList.contains('show-menu') && !changed)
		{
			menu.classList.remove('show-menu');
			menu.classList.add('hide-menu');
			changed = true;
		} else if (menu.classList.contains('hide-menu') && !changed) {
			menu.classList.remove('hide-menu');
			menu.classList.add('show-menu');
			changed = true;
		}
}


function qs(search_for) {
	var query = window.location.search.substring(1);
	var parms = query.split('&');
	
	for(var i = 0; i < parms.length; i++)
	{
		var pos = parms[i].indexOf('=');
		if(pos > 0 && search_for == parms[i].substring(0, pos) ) {
			return parms[i].substring(pos+1);
		}
	}
	return "";
}

function loadError() {
	var errorCode = qs("error");
	if (errorCode != "")
	{ document.getElementById("show-error-code").innerHTML = "(" + qs("error") + " Error)"; }
}



