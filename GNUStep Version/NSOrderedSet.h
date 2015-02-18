//
//  NSOrderedSet
//  NSOrderedSetForGnuStep
//
//  Created by Jaufré Thumerel on 05/02/2015.
//  GNU LESSER GENERAL PUBLIC LICENSE
//  Version 3, 29 June 2007

#import <Foundation/Foundation.h>

@interface NSOrderedSet : NSObject <NSCopying, NSMutableCopying, NSCoding, NSFastEnumeration>
{
    NSArray *array;
    NSSet *set;
}

- (NSUInteger)count;
- (id)objectAtIndex:(NSUInteger)idx;
- (NSUInteger)indexOfObject:(id)object;
- (id)init;
- (id)initWithObjects:(const id [])objects count:(NSUInteger)cnt;
- (id)initWithCoder:(NSCoder *)aDecoder;
- (id)initWithArray:(NSArray *)array;
- (void)getObjects:(id __unsafe_unretained [])objects range:(NSRange)range;
- (NSArray *)objectsAtIndexes:(NSIndexSet *)indexes;
- (id) firstObject;
- (id) lastObject;
- (BOOL)isEqualToOrderedSet:(NSOrderedSet *)other;
- (BOOL)containsObject:(id)object;
- (BOOL)intersectsOrderedSet:(NSOrderedSet *)other;
- (BOOL)intersectsSet:(NSSet *)set;
- (BOOL)isSubsetOfOrderedSet:(NSOrderedSet *)other;
- (BOOL)isSubsetOfSet:(NSSet *)set;
- (id)objectAtIndexedSubscript:(NSUInteger)idx;
- (NSEnumerator *)objectEnumerator;
- (NSEnumerator *)reverseObjectEnumerator;
- (NSOrderedSet *) reversedOrderedSet;
- (NSArray *) array;
- (NSSet *) set;
- (void)enumerateObjectsUsingBlock:(void (^)(id obj, NSUInteger idx, BOOL *stop))block;
- (void)enumerateObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(id obj, NSUInteger idx, BOOL *stop))block;
- (void)enumerateObjectsAtIndexes:(NSIndexSet *)s options:(NSEnumerationOptions)opts usingBlock:(void (^)(id obj, NSUInteger idx, BOOL *stop))block;
- (NSUInteger)indexOfObjectPassingTest:(BOOL (^)(id obj, NSUInteger idx, BOOL *stop))predicate;
- (NSUInteger)indexOfObjectWithOptions:(NSEnumerationOptions)opts passingTest:(BOOL (^)(id obj, NSUInteger idx, BOOL *stop))predicate;
- (NSUInteger)indexOfObjectAtIndexes:(NSIndexSet *)s options:(NSEnumerationOptions)opts passingTest:(BOOL (^)(id obj, NSUInteger idx, BOOL *stop))predicate;
- (NSIndexSet *)indexesOfObjectsPassingTest:(BOOL (^)(id obj, NSUInteger idx, BOOL *stop))predicate;
- (NSIndexSet *)indexesOfObjectsWithOptions:(NSEnumerationOptions)opts passingTest:(BOOL (^)(id obj, NSUInteger idx, BOOL *stop))predicate;
- (NSIndexSet *)indexesOfObjectsAtIndexes:(NSIndexSet *)s options:(NSEnumerationOptions)opts passingTest:(BOOL (^)(id obj, NSUInteger idx, BOOL *stop))predicate;
- (NSUInteger)indexOfObject:(id)object inSortedRange:(NSRange)range options:(NSBinarySearchingOptions)opts usingComparator:(NSComparator)cmp; // binary search
- (NSArray *)sortedArrayUsingComparator:(NSComparator)cmptr;
- (NSArray *)sortedArrayWithOptions:(NSSortOptions)opts usingComparator:(NSComparator)cmptr;
- (NSString *) description;
- (NSString *)descriptionWithLocale:(id)locale;
- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level;

+ (id)orderedSet;
+ (id)orderedSetWithObject:(id)object;
+ (id)orderedSetWithObjects:(const id [])objects count:(NSUInteger)cnt;
+ (id)orderedSetWithObjects:(id)firstObj, ... NS_REQUIRES_NIL_TERMINATION;
+ (id)orderedSetWithOrderedSet:(NSOrderedSet *)set;
+ (id)orderedSetWithOrderedSet:(NSOrderedSet *)set range:(NSRange)range copyItems:(BOOL)flag;
+ (id)orderedSetWithArray:(NSArray *)array;
+ (id)orderedSetWithArray:(NSArray *)array range:(NSRange)range copyItems:(BOOL)flag;
+ (id)orderedSetWithSet:(NSSet *)set;
+ (id)orderedSetWithSet:(NSSet *)set copyItems:(BOOL)flag;

- (id)initWithObject:(id)object;
- (id)initWithObjects:(id)firstObj, ... NS_REQUIRES_NIL_TERMINATION;
- (id)initWithOrderedSet:(NSOrderedSet *)set;
- (id)initWithOrderedSet:(NSOrderedSet *)set copyItems:(BOOL)flag;
- (id)initWithOrderedSet:(NSOrderedSet *)set range:(NSRange)range copyItems:(BOOL)flag;
- (id)initWithArray:(NSArray *)array copyItems:(BOOL)flag;
- (id)initWithArray:(NSArray *)array range:(NSRange)range copyItems:(BOOL)flag;
- (id)initWithSet:(NSSet *)set;
- (id)initWithSet:(NSSet *)set copyItems:(BOOL)flag;

@end
