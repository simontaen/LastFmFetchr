# Code.todo

* Comment style refactoring using [this xcode plugin](https://github.com/onevcat/VVDocumenter-Xcode)
* Fix TODO's in fetchr
* How can I call every property on an object?
	* http://stackoverflow.com/questions/2573805/using-objc-msgsend-to-call-a-objective-c-function-with-named-arguments
	* http://stackoverflow.com/questions/330030/list-selectors-for-obj-c-object
* it should be possible to directly return a proper LFMData from responseObjectForResponse:data:error in a AFURLResponseSerialization implementor
* add the change to AFNetworking
* Implement the OAuth [Authentication](http://www.last.fm/api/authentication)


# Better LFM data access

* The key to the problem is your representation of the LFM entities. Each "jsonContentKey" element is one class, start there and create a hierarchie later. For example these are missing at the moment: LFMTag, LFMTrack, LFMMember, etc.
* Try NOT to name the data classes too similar to the API call-name: LFMArtistInfo with artist.getInfo is fine, but not LFMArtistGetInfo. The API call method ALREADY binds the call to the return class, this must be enough! Always favor the hierarchy over the API naming convention.

* [Mantle](https://github.com/github/Mantle) NOT persisting data makes it an ideal choice for an API client. Let the JSON Dictionary encoding be done by Mantle. The user of the API client still can then persist the data however he wants. "Mantle can still be a convenient translation layer between the API and" whatever the user uses for persistent. The API Client would basically be a customised Mantle version for the specific API.
	* Use a Serializer to create an MTLModel with AFNetworking
	* There is even an AFNetworking extension available: [Overcoat](https://github.com/gonzalezreal/Overcoat)
		* [mentioned](http://www.paylas.com/video/mattt-thompson--kod-io-2013) by mattt himself, minute 20-21

