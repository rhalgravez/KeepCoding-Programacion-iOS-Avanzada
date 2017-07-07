// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AGTMapSnapshot.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class AGTLocation;

@interface AGTMapSnapshotID : NSManagedObjectID {}
@end

@interface _AGTMapSnapshot : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) AGTMapSnapshotID *objectID;

@property (nonatomic, strong) NSData* snapshotData;

@property (nonatomic, strong) AGTLocation *location;

@end

@interface _AGTMapSnapshot (CoreDataGeneratedPrimitiveAccessors)

- (NSData*)primitiveSnapshotData;
- (void)setPrimitiveSnapshotData:(NSData*)value;

- (AGTLocation*)primitiveLocation;
- (void)setPrimitiveLocation:(AGTLocation*)value;

@end

@interface AGTMapSnapshotAttributes: NSObject 
+ (NSString *)snapshotData;
@end

@interface AGTMapSnapshotRelationships: NSObject
+ (NSString *)location;
@end

NS_ASSUME_NONNULL_END
