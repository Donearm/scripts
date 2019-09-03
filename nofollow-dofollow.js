var style = document.createElement('style');
style.type = 'text/css';
style.innerHTML = '.bd {border-radius:3px;color:white;background:black;padding:2px;font-size:10px;}.df{background:green}';
$$('head')[0].appendChild(style);

var urls = $$("a");
for (url in urls) {
	if (urls[url].rel) {
		urls[url].innerHTML += " <span class='bd'> " + urls[url].rel + "</span>";
	} else {
		urls[url].innerHTML +="<span class='bd df'>dofollow</span>"
	}
}
