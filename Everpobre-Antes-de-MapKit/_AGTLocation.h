// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AGTLocation.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class AGTMapSnapshot;
@class AGTNote;

@interface AGTLocationID : NSManagedObjectID {}
@end

@interface _AGTLocation : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) AGTLocationID *objectID;

@property (nonatomic, strong, nullable) NSString* address;

@property (nonatomic, strong) NSNumber* latitude;

@property (atomic) double latitudeValue;
- (double)latitudeValue;
- (void)setLatitudeValue:(double)value_;

@property (nonatomic, strong) NSNumber* longitude;

@property (atomic) double longitudeValue;
- (double)longitudeValue;
- (void)setLongitudeValue:(double)value_;

@property (nonatomic, strong, nullable) AGTMapSnapshot *mapSnapshot;

@property (nonatomic, strong, nullable) NSSet<AGTNote*> *notes;
- (nullable NSMutableSet<AGTNote*>*)notesSet;

@end

@interface _AGTLocation (NotesCoreDataGeneratedAccessors)
- (void)addNotes:(NSSet<AGTNote*>*)value_;
- (void)removeNotes:(NSSet<AGTNote*>*)value_;
- (void)addNotesObject:(AGTNote*)value_;
- (void)removeNotesObject:(AGTNote*)value_;

@end

@interface _AGTLocation (CoreDataGeneratedPrimitiveAccessors)

- (nullable NSString*)primitiveAddress;
- (void)setPrimitiveAddress:(nullable NSString*)value;

- (NSNumber*)primitiveLatitude;
- (void)setPrimitiveLatitude:(NSNumber*)value;

- (double)primitiveLatitudeValue;
- (void)setPrimitiveLatitudeValue:(double)value_;

- (NSNumber*)primitiveLongitude;
- (void)setPrimitiveLongitude:(NSNumber*)value;

- (double)primitiveLongitudeValue;
- (void)setPrimitiveLongitudeValue:(double)value_;

- (AGTMapSnapshot*)primitiveMapSnapshot;
- (void)setPrimitiveMapSnapshot:(AGTMapSnapshot*)value;

- (NSMutableSet<AGTNote*>*)primitiveNotes;
- (void)setPrimitiveNotes:(NSMutableSet<AGTNote*>*)value;

@end

@interface AGTLocationAttributes: NSObject 
+ (NSString *)address;
+ (NSString *)latitude;
+ (NSString *)longitude;
@end

@interface AGTLocationRelationships: NSObject
+ (NSString *)mapSnapshot;
+ (NSString *)notes;
@end

NS_ASSUME_NONNULL_END
