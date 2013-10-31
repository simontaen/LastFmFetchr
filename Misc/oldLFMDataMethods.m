#pragma mark - Others

- (NSArray *)tagNamesArrayWithTagListKeyPath:(NSString *)tagListKeyPath
{
	id obj = self.JSON;
	// this is nil value save
	for (NSString *key in [tagListKeyPath componentsSeparatedByString:@"."]) {
		if ([obj isKindOfClass:[NSDictionary class]]) {
			obj = obj[key];
		}
	}

	if (![obj isKindOfClass:[NSArray class]]) {
		return nil;
	}
	NSArray *array = (NSArray *)obj;
	NSMutableArray *tags = [NSMutableArray arrayWithCapacity:[array count]];

	for (NSDictionary *dict in array) {
		[tags addObject:[dict[@"name"] description]];
	}
	return tags;
}

- (NSArray *)tagURLsArrayWithTagListKeyPath:(NSString *)tagListKeyPath
{
	id obj = self.JSON;
	// this is nil value save
	for (NSString *key in [tagListKeyPath componentsSeparatedByString:@"."]) {
		if ([obj isKindOfClass:[NSDictionary class]]) {
			obj = obj[key];
		}
	}

	NSArray *array = (NSArray *)obj;
	NSMutableArray *tags = [NSMutableArray arrayWithCapacity:[array count]];

	for (NSDictionary *dict in array) {
		[tags addObject:[NSURL URLWithString:[dict[@"url"] description]]];
	}

	return tags;
}

- (NSString *)smallImageForImageListKeyPath:(NSString *)imageListKeyPath
{
	id obj = [self.JSON valueForKeyPath:imageListKeyPath];
	if ([obj isKindOfClass:[NSArray class]]) {
		return [obj[0][@"#text"] description];
	}
	return kEmpty;
}

- (NSString *)mediumImageForImageListKeyPath:(NSString *)imageListKeyPath
{
	id obj = [self.JSON valueForKeyPath:imageListKeyPath];
	if ([obj isKindOfClass:[NSArray class]]) {
		return [obj[1][@"#text"] description];
	}
	return kEmpty;
}

- (NSString *)largeImageForImageListKeyPath:(NSString *)imageListKeyPath
{
	id obj = [self.JSON valueForKeyPath:imageListKeyPath];
	if ([obj isKindOfClass:[NSArray class]]) {
		return [obj[2][@"#text"] description];
	}
	return kEmpty;
}

- (NSString *)extraLargeImageForImageListKeyPath:(NSString *)imageListKeyPath
{
	id obj = [self.JSON valueForKeyPath:imageListKeyPath];
	if ([obj isKindOfClass:[NSArray class]]) {
		return [obj[3][@"#text"] description];
	}
	return kEmpty;
}

- (NSString *)megaImageForImageListKeyPath:(NSString *)imageListKeyPath
{
	id obj = [self.JSON valueForKeyPath:imageListKeyPath];
	if ([obj isKindOfClass:[NSArray class]]) {
		return [obj[4][@"#text"] description];
	}
	return kEmpty;
}
