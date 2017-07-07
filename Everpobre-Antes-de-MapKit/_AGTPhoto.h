// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AGTPhoto.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class AGTNote;

@interface AGTPhotoID : NSManagedObjectID {}
@end

@interface _AGTPhoto : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) AGTPhotoID *objectID;

@property (nonatomic, strong) NSData* imageData;

@property (nonatomic, strong) AGTNote *notes;

@end

@interface _AGTPhoto (CoreDataGeneratedPrimitiveAccessors)

- (NSData*)primitiveImageData;
- (void)setPrimitiveImageData:(NSData*)value;

- (AGTNote*)primitiveNotes;
- (void)setPrimitiveNotes:(AGTNote*)value;

@end

@interface AGTPhotoAttributes: NSObject 
+ (NSString *)imageData;
@end

@interface AGTPhotoRelationships: NSObject
+ (NSString *)notes;
@end

NS_ASSUME_NONNULL_END
