// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AGTNotebook.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

#import "AGTNamedEntity.h"

NS_ASSUME_NONNULL_BEGIN

@class AGTNote;

@interface AGTNotebookID : AGTNamedEntityID {}
@end

@interface _AGTNotebook : AGTNamedEntity
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) AGTNotebookID *objectID;

@property (nonatomic, strong, nullable) NSSet<AGTNote*> *notes;
- (nullable NSMutableSet<AGTNote*>*)notesSet;

@end

@interface _AGTNotebook (NotesCoreDataGeneratedAccessors)
- (void)addNotes:(NSSet<AGTNote*>*)value_;
- (void)removeNotes:(NSSet<AGTNote*>*)value_;
- (void)addNotesObject:(AGTNote*)value_;
- (void)removeNotesObject:(AGTNote*)value_;

@end

@interface _AGTNotebook (CoreDataGeneratedPrimitiveAccessors)

- (NSMutableSet<AGTNote*>*)primitiveNotes;
- (void)setPrimitiveNotes:(NSMutableSet<AGTNote*>*)value;

@end

@interface AGTNotebookRelationships: NSObject
+ (NSString *)notes;
@end

NS_ASSUME_NONNULL_END
