// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AGTNote.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

#import "AGTNamedEntity.h"

NS_ASSUME_NONNULL_BEGIN

@class AGTNotebook;

@interface AGTNoteID : AGTNamedEntityID {}
@end

@interface _AGTNote : AGTNamedEntity
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) AGTNoteID *objectID;

@property (nonatomic, strong, nullable) NSString* text;

@property (nonatomic, strong) AGTNotebook *notebook;

@end

@interface _AGTNote (CoreDataGeneratedPrimitiveAccessors)

- (nullable NSString*)primitiveText;
- (void)setPrimitiveText:(nullable NSString*)value;

- (AGTNotebook*)primitiveNotebook;
- (void)setPrimitiveNotebook:(AGTNotebook*)value;

@end

@interface AGTNoteAttributes: NSObject 
+ (NSString *)text;
@end

@interface AGTNoteRelationships: NSObject
+ (NSString *)notebook;
@end

NS_ASSUME_NONNULL_END
