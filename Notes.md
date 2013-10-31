Code.todo

* Check NSURLSessionConfiguration @done
	* HEADER's fine? @done
* Check JSON Serializer @done
	* Response serializer ok? @done
	* Request searializer ok? @done
* [Check this to avoid manual parsing code](http://www.merowing.info/2013/07/stop-writing-data-parsing-code-in-your-apps) @done
	* The key to the problem is your representation of the LFM entities. Each "jsonContentKey" element is one class, start there and create a hierarchie later. For example these are missing at the moment: LFMTag, LFMTrack, LFMMember, etc.
	* Try NOT to name the data classes too similar to the API call-name: LFMArtistInfo with artist.getInfo is fine, but not LFMArtistGetInfo. The API call method ALREADY binds the call to the return class, this must be enough! Always favor the hierarchy over the API naming convention.
* Think about just one completion handler like [here](http://nsscreencast.com/episodes/91-afnetworking-2-0) @done
* Refactor the request generation and adding of default params @done
* Check if NSURLCache is working @done
* Comment style refactoring using [this xcode plugin](https://github.com/onevcat/VVDocumenter-Xcode)
* Fix TODO's in fetchr
* Update Passions to the new fetchr @done
* Draw the UI for the App FIRST!
	* Because you focus on solving the wrong problems if you don't!
* Get the AlbumView using a UICollectionView backed by the NSFetchedResultsController (CoreData) working (see links from nshipster and ash furrow)
* Implement the OAuth [Authentication](http://www.last.fm/api/authentication)


# Better LFM data access

* provide a [facade](https://en.wikipedia.org/wiki/Facade_pattern) to the LFM API data model for fully typed access
* build the facade using a [decorator](https://en.wikipedia.org/wiki/Decorator_pattern)
	* A decorator is only useful to decorate behaviour, not typed access.
* --> I basically just need a subclassing hierarchy