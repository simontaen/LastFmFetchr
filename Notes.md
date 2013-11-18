Code.todo

* Comment style refactoring using [this xcode plugin](https://github.com/onevcat/VVDocumenter-Xcode)
* Fix TODO's in fetchr
* How can I call every property on an object?
* Implement the OAuth [Authentication](http://www.last.fm/api/authentication)


# Better LFM data access

* provide a [facade](https://en.wikipedia.org/wiki/Facade_pattern) to the LFM API data model for fully typed access
* build the facade using a [decorator](https://en.wikipedia.org/wiki/Decorator_pattern)
	* A decorator is only useful to decorate behaviour, not typed access.
	* --> I basically just need a subclassing hierarchy
* The key to the problem is your representation of the LFM entities. Each "jsonContentKey" element is one class, start there and create a hierarchie later. For example these are missing at the moment: LFMTag, LFMTrack, LFMMember, etc.
* Try NOT to name the data classes too similar to the API call-name: LFMArtistInfo with artist.getInfo is fine, but not LFMArtistGetInfo. The API call method ALREADY binds the call to the return class, this must be enough! Always favor the hierarchy over the API naming convention.

