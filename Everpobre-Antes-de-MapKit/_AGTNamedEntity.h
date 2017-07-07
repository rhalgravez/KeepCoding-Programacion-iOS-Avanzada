// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AGTNamedEntity.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface AGTNamedEntityID : NSManagedObjectID {}
@end

@interface _AGTNamedEntity : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) AGTNamedEntityID *objectID;

@property (nonatomic, strong) NSDate* creationDate;

@property (nonatomic, strong) NSDate* modificationDate;

@property (nonatomic, strong) NSString* name;

@end

@interface _AGTNamedEntity (CoreDataGeneratedPrimitiveAccessors)

- (NSDate*)primitiveCreationDate;
- (void)setPrimitiveCreationDate:(NSDate*)value;

- (NSDate*)primitiveModificationDate;
- (void)setPrimitiveModificationDate:(NSDate*)value;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

@end

@interface AGTNamedEntityAttributes: NSObject 
+ (NSString *)creationDate;
+ (NSString *)modificationDate;
+ (NSString *)name;
@end

NS_ASSUME_NONNULL_END
