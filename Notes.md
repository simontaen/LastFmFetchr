Code.todo

* Comment style refactoring using [this xcode plugin](https://github.com/onevcat/VVDocumenter-Xcode)
* Fix TODO's in fetchr
* How can I call every property on an object?
	* http://stackoverflow.com/questions/2573805/using-objc-msgsend-to-call-a-objective-c-function-with-named-arguments
	* http://stackoverflow.com/questions/330030/list-selectors-for-obj-c-object
* NSAssert for methods in LFMAppdelegate
* it should be possible to directly return a proper LFMData from responseObjectForResponse:data:error in a AFURLResponseSerialization implementor
* Implement the OAuth [Authentication](http://www.last.fm/api/authentication)


# Better LFM data access

* The key to the problem is your representation of the LFM entities. Each "jsonContentKey" element is one class, start there and create a hierarchie later. For example these are missing at the moment: LFMTag, LFMTrack, LFMMember, etc.
* Try NOT to name the data classes too similar to the API call-name: LFMArtistInfo with artist.getInfo is fine, but not LFMArtistGetInfo. The API call method ALREADY binds the call to the return class, this must be enough! Always favor the hierarchy over the API naming convention.

