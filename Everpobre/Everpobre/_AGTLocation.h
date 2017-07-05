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

@class AGTNote;

@interface AGTLocationID : NSManagedObjectID {}
@end

@interface _AGTLocation : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) AGTLocationID *objectID;

@property (nonatomic, strong, nullable) NSString* address;

@property (nonatomic, strong, nullable) NSNumber* latitude;

@property (atomic) double latitudeValue;
- (double)latitudeValue;
- (void)setLatitudeValue:(double)value_;

@property (nonatomic, strong, nullable) NSNumber* longitude;

@property (atomic) double longitudeValue;
- (double)longitudeValue;
- (void)setLongitudeValue:(double)value_;

@property (nonatomic, strong) NSSet<AGTNote*> *notes;
- (NSMutableSet<AGTNote*>*)notesSet;

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

- (nullable NSNumber*)primitiveLatitude;
- (void)setPrimitiveLatitude:(nullable NSNumber*)value;

- (double)primitiveLatitudeValue;
- (void)setPrimitiveLatitudeValue:(double)value_;

- (nullable NSNumber*)primitiveLongitude;
- (void)setPrimitiveLongitude:(nullable NSNumber*)value;

- (double)primitiveLongitudeValue;
- (void)setPrimitiveLongitudeValue:(double)value_;

- (NSMutableSet<AGTNote*>*)primitiveNotes;
- (void)setPrimitiveNotes:(NSMutableSet<AGTNote*>*)value;

@end

@interface AGTLocationAttributes: NSObject 
+ (NSString *)address;
+ (NSString *)latitude;
+ (NSString *)longitude;
@end

@interface AGTLocationRelationships: NSObject
+ (NSString *)notes;
@end

NS_ASSUME_NONNULL_END
