// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AGTNotebook.m instead.

#import "_AGTNotebook.h"

@implementation AGTNotebookID
@end

@implementation _AGTNotebook

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Notebook" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Notebook";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Notebook" inManagedObjectContext:moc_];
}

- (AGTNotebookID*)objectID {
	return (AGTNotebookID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic notes;

- (NSMutableSet<AGTNote*>*)notesSet {
	[self willAccessValueForKey:@"notes"];

	NSMutableSet<AGTNote*> *result = (NSMutableSet<AGTNote*>*)[self mutableSetValueForKey:@"notes"];

	[self didAccessValueForKey:@"notes"];
	return result;
}

@end

@implementation AGTNotebookRelationships 
+ (NSString *)notes {
	return @"notes";
}
@end

