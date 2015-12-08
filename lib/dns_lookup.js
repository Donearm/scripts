var dns = require("dns");
var process = require("process");

dns.lookup(process.argv[2], function onLookup(err, addresses, family) {
	console.log(process.argv[2]);
	console.log("addresses: ", addresses);
});
