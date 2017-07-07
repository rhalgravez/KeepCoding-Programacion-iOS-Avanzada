// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AGTMapSnapshot.m instead.

#import "_AGTMapSnapshot.h"

@implementation AGTMapSnapshotID
@end

@implementation _AGTMapSnapshot

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"MapSnapshot" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"MapSnapshot";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"MapSnapshot" inManagedObjectContext:moc_];
}

- (AGTMapSnapshotID*)objectID {
	return (AGTMapSnapshotID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic snapshotData;

@dynamic location;

@end

@implementation AGTMapSnapshotAttributes 
+ (NSString *)snapshotData {
	return @"snapshotData";
}
@end

@implementation AGTMapSnapshotRelationships 
+ (NSString *)location {
	return @"location";
}
@end

