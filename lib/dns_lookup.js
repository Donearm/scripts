var dns = require("dns");
var process = require("process");

let hostname = process.argv[2].replace(/(http(s)?:\/\/)?/, '');

dns.lookup(hostname, function onLookup(err, addresses, family) {
	console.log(hostname);
	console.log("addresses: ", addresses);
});
