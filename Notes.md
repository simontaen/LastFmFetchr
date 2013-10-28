Code.todo

* Check NSURLSessionConfiguration @done
	* HEADER's fine? @done
* Check JSON Serializer @done
	* Response serializer ok? @done
	* Request searializer ok? @done
* [Check this to avoid manual parsing code](http://www.merowing.info/2013/07/stop-writing-data-parsing-code-in-your-apps)
	* The key to the problem is your representation of the LFM entities. Each "jsonContentKey" element is one class, start there and create a hierarchie later. For example these are missing at the moment: LFMTag, LFMTrack, LFMMember, etc.
	* Try NOT to name the data classes too similar to the API call-name: LFMArtistInfo with artist.getInfo is fine, but not LFMArtistGetInfo. The API call method ALREADY binds the call to the return class, this must be enough! Always favor the hierarchy over the API naming convention.
* Think about just one completion handler like [here](http://nsscreencast.com/episodes/91-afnetworking-2-0)
* Comment style refactoring using [this xcode plugin](https://github.com/onevcat/VVDocumenter-Xcode)
* Check if NSURLCache is working
* Draw the UI for the App FIRST!
* Get the AlbumView using a UICollectionView backed by the NSFetchedResultsController (CoreData) working (see links from nshipster and ash furrow)
* Implement the OAuth [Authentication](http://www.last.fm/api/authentication)