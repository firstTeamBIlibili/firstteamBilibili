//
//  WDGSyncQuery.h
//  Wilddog
//
//  Created by Garin on 15/7/7.
//  Copyright (c) 2015年 Wilddog. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WDGDataEventType.h"
#import "WDGDataSnapshot.h"

NS_ASSUME_NONNULL_BEGIN

typedef int64_t WDGSyncHandle;
@class WDGDataSnapshot;

/**
 * 一个 WDGSyncQuery 对象，用于查询指定路径和指定条件下的数据。
 */
@interface WDGSyncQuery : NSObject

/** @name 属性 */

/**
 *  获取这个查询对象的 WDGSyncReference 实例。
 */
@property (nonatomic, readonly, strong) WDGSyncReference *ref;

/** @name 绑定观察者，读取数据 */

/**
 *
 *  observeEventType:withBlock: 用于监听一个指定节点的数据变化
 *  这是从 Wilddog Sync 服务器读取数据的主要方式，当监听到初始数据和初始数据有改变时，指定事件相对应的 block 会被触发。
 *
 *  typedef NS_ENUM(NSInteger, WDGDataEventType) {
 *      WDGDataEventTypeChildAdded,     // 0, 当有新增子节点时触发
 *      WDGDataEventTypeChildRemoved,   // 1, 当有子节点被删除时触发
 *      WDGDataEventTypeChildChanged,   // 2, 当某个子节点发生变化时触发
 *      WDGDataEventTypeChildMoved,     // 3, 当有子节排序发生变化时触发
 *      WDGDataEventTypeValue           // 4, 当有数据请求或有任何数据发生变化时触发
 *  };
 *
 *  @param eventType 监听的事件类型
 *  @param block     当监听到某事件时，回调该 block
 *
 *  @return 一个 WDGSyncHandle，用于调用函数 removeObserverWithHandle: 去注销这个block
 */
- (WDGSyncHandle)observeEventType:(WDGDataEventType)eventType withBlock:(void (^)(WDGDataSnapshot* snapshot))block;


/**
 * observeEventType:andPreviousSiblingKeyWithBlock: 用于监听在特定节点处的数据的变化。
 * 这是从 Wilddog Sync 服务器读取数据的主要方式，当监听到初始数据和初始数据有改变时，指定事件相对应的 block 会被触发。 此外， 对于 WDGDataEventTypeChildAdded, WDGDataEventTypeChildMoved 和 WDGDataEventTypeChildChanged 事件, block 通过 priority 排序将传输前一节点的 key 值。
 *
 * 用 removeObserverWithHandle: 方法去停止接受数据更新的监听。
 *
 * @param eventType 监听的事件类型
 * @param block 当监听到初始数据和初始数据发生变化时，这个 block 将被回调。block 将传输一个 WDGDataSnapshot 类型的数据和前一个子节点的 key
 * @return 一个 WDGSyncHandle，用于调用函数 removeObserverWithHandle: 去注销这个 block
 */
- (WDGSyncHandle)observeEventType:(WDGDataEventType)eventType andPreviousSiblingKeyWithBlock:(void (^)(WDGDataSnapshot* snapshot, NSString *__nullable prevKey))block;


/**
 *  observeEventType:withBlock:withCancelBlock: 用于监听一个指定节点的数据变化。
 *  这是从 Wilddog Sync 服务器读取数据的主要方式，当监听到初始数据和初始数据有改变时，指定事件相对应的 block 会被触发。
 *  由于你没有读取权限，就接受不到新的事件，这时 cancelBlock 就会被调用
 *
 *  @param eventType   监听的事件类型
 *  @param block       当监听到某事件时，回调 block
 *  @param cancelBlock 如果客户端没有权限去接受这些事件，这个 block 将会被调用
 *
 *  @return 一个 WDGSyncHandle，用于调用函数 removeObserverWithHandle: 去注销这个 block
 */
- (WDGSyncHandle)observeEventType:(WDGDataEventType)eventType withBlock:(void (^)(WDGDataSnapshot* snapshot))block withCancelBlock:(nullable void (^)(NSError* error))cancelBlock;


/**
 * observeEventType:andPreviousSiblingKeyWithBlock:withCancelBlock: 用于监听在特定节点处的数据的变化。
 * 这是从 Wilddog Sync 服务器读取数据的主要方式，当监听到初始数据和初始数据有改变时，指定事件相对应的 block 会被触发。 此外，对于 WDGDataEventTypeChildAdded, WDGDataEventTypeChildMoved 和 WDGDataEventTypeChildChanged 事件, block通过priority排序将传输前一节点的key值。
 *
 * 由于你没有读取权限，就接受不到新的事件，这时cancelBlock就会被调用
 *
 * 用 removeObserverWithHandle: 方法去停止接受数据更新的监听。
 *
 * @param eventType 监听的事件类型
 * @param block 当监听到初始数据和初始数据发生变化时，这个 block 将被回调。block 将传输一个 WDGDataSnapshot 类型的数据和前一个子节点的 key
 * @param cancelBlock 如果客户端没有权限去接受这些事件，这个block将会被调用
 *
 * @return  一个WDGSyncHandle，用于调用函数 removeObserverWithHandle: 去注销这个 block
 */
- (WDGSyncHandle)observeEventType:(WDGDataEventType)eventType andPreviousSiblingKeyWithBlock:(void (^)(WDGDataSnapshot* snapshot, NSString *__nullable prevKey))block withCancelBlock:(nullable void (^)(NSError* error))cancelBlock;


/**
 *  同observeEventType:withBlock: 类似，不同之处在于 observeSingleEventOfType:withBlock: 中的回调函数只被执行一次。
 *
 *  @param eventType 监听的事件类型
 *  @param block     当监听到某事件时，回调 block
 */
- (void)observeSingleEventOfType:(WDGDataEventType)eventType withBlock:(void (^)(WDGDataSnapshot* snapshot))block;


/**
 * 这个方法和 observeEventType:withBlock: 方法类似。不同之处是在初始数据返回后，这个 block 回调一次就被取消监听。此外，对于 WDGDataEventTypeChildAdded, WDGDataEventTypeChildMoved 和 WDGDataEventTypeChildChanged 事件, block 通过 priority 排序将传输前一节点的 key 值。
 *
 * @param eventType 监听的事件类型
 * @param block block 当监听到初始数据和初始数据发生变化时，这个 block 将被回调。block 将传输一个 WDGDataSnapshot 类型的数据和前一个子节点的 key
 */
- (void)observeSingleEventOfType:(WDGDataEventType)eventType andPreviousSiblingKeyWithBlock:(void (^)(WDGDataSnapshot* snapshot, NSString *__nullable prevKey))block;


/**
 *  同 observeSingleEventOfType:withBlock: 类似，如果你没有在这个节点读取数据的权限，cancelBlock 将会被回调。
 *
 *  @param eventType   监听的事件类型
 *  @param block       当监听到某事件时，回调 block
 *  @param cancelBlock 如果您没有权限访问此数据，将调用该 cancelBlock
 */
- (void)observeSingleEventOfType:(WDGDataEventType)eventType withBlock:(void (^)(WDGDataSnapshot* snapshot))block withCancelBlock:(nullable void (^)(NSError* error))cancelBlock;


/**
 * 这个方法和 observeEventType:withBlock: 方法类似。不同之处是：在初始数据返回后，这个 block 回调一次就被取消监听。此外，对于 WDGDataEventTypeChildAdded, WDGDataEventTypeChildMoved 和 WDGDataEventTypeChildChanged 事件, block 通过 priority 排序将传输前一节点的 key 值。
 *
 * 如果你没有在这个节点读取数据的权限，cancelBlock将会被回调
 *
 * @param eventType 监听的事件类型
 * @param block 将传输一个 WDGDataSnapshot 类型的数据和前一个子节点的 key
 * @param cancelBlock 如果您没有权限访问此数据，将调用该 cancelBlock
 */
- (void)observeSingleEventOfType:(WDGDataEventType)eventType andPreviousSiblingKeyWithBlock:(void (^)(WDGDataSnapshot* snapshot, NSString *__nullable prevKey))block withCancelBlock:(nullable void (^)(NSError* error))cancelBlock;


/** @name 移除观察者 */

/**
 *  取消监听事件。取消之前用 observeEventType:withBlock: 注册的回调函数。
 *
 *  @param handle 由 observeEventType:withBlock: 返回的 WDGSyncHandle
 */
- (void)removeObserverWithHandle:(WDGSyncHandle)handle;


/**
 *  取消之前由 observeEventType:withBlock: 注册的所有的监听事件。
 */
- (void)removeAllObservers;


/**
   在某一节点处通过调用 keepSynced:YES 方法，即使该节点处没有设置监听者，此节点处的数据也将自动下
   载存储并保持同步。
 
   @param keepSynced 参数设置为 YES，则在此节点处同步数据，设置为 NO，停止同步。
 */
- (void)keepSynced:(BOOL)keepSynced;


/** @name 查询和限制 */

/**
 * queryLimitedToFirst: 用于创建一个新 WDGSyncQuery 实例，获取从第一条开始的指定数量的数据。
 * 返回的 WDGSyncQuery 查询器类将响应从第一个开始，到最多指定(limit)节点个数的数据。
 *
 * @param limit 这次查询能够获取的子节点的最大数量
 * @return 返回一个 WDGSyncQuery 查询器类，最多指定(limit)个数的数据
 */
- (WDGSyncQuery *)queryLimitedToFirst:(NSUInteger)limit;


/**
 * queryLimitedToLast: 用于创建一个新 WDGSyncQuery 实例，获取从最后一条开始向前指定数量的数据。
 * 返回的 WDGSyncQuery 查询器类将响应从最后一个开始，最多指定(limit)个数的数据。
 *
 * @param limit 这次查询能够获取的子节点的最大数量
 * @return 返回一个 WDGSyncQuery 查询器类，最多指定(limit)个数的数据
 */
- (WDGSyncQuery *)queryLimitedToLast:(NSUInteger)limit;


/**
 * queryOrderedByChild: 用于产生一个新 WDGSyncQuery 实例，是按照特定子节点的值进行排序的。
 * 此方法要与 queryStartingAtValue:, queryEndingAtValue: 或 queryEqualToValue: 方法联合使用。
 *
 * @param key 指定用来排序的子节点的 key
 * @return 返回一个按指定的子节点 key 排序生成的 WDGSyncQuery 查询器类
 */
- (WDGSyncQuery *)queryOrderedByChild:(NSString *)key;


/**
 * queryOrderedByKey 用于产生一个新 WDGSyncQuery 实例，是按照特定子节点的 key 进行排序的。
 * 此方法要与 queryStartingAtValue:, queryEndingAtValue: 或 queryEqualToValue: 方法联合使用。
 *
 * @return 返回一个按指定的子节点 key 排序生成的 WDGSyncQuery 查询器类
 */
- (WDGSyncQuery *)queryOrderedByKey;


/**
 * queryOrderedByValue 用于产生一个新 WDGSyncQuery 实例，是按照当前节点的值进行排序的。
 * 此方法要与 queryStartingAtValue:, queryEndingAtValue: 或 queryEqualToValue: 方法联合使用。
 *
 * @return 返回一个按指定的子节点值排序生成的 WDGSyncQuery 查询器类
 */
- (WDGSyncQuery *)queryOrderedByValue;


/**
 * queryOrderedByPriority 用于产生一个新 WDGSyncQuery 实例，是按照当前节点的优先级排序的。
 * 此方法要与 queryStartingAtValue:, queryEndingAtValue: 或 queryEqualToValue: 方法联合使用。
 *
 * @return 返回一个按指定的子节点优先级排序生成的 WDGSyncQuery 查询器类
 */
- (WDGSyncQuery *)queryOrderedByPriority;


/**
 * queryStartingAtValue: 用于返回一个 WDGSyncQuery 实例，这个实例用来监测数据的变化，这些被监测的数据的值均大于或等于 startValue。
 *
 * @param startValue query 查询到的值均大于等于 startValue
 * @return 返回一个 WDGSyncQuery 查询器类，用于响应在数据值大于或等于 startValue 的节点事件
 */
- (WDGSyncQuery *)queryStartingAtValue:(nullable id)startValue;


/**
 * queryStartingAtValue:childKey: 用于返回一个 WDGSyncQuery 实例，这个实例用来监测数据的变化，这些被监测的数据的值大于 startValue，或者等于 startValue 并且 key 大于等于 childKey。
 *
 * @param startValue query 查询到的值均大于等于 startValue
 * @param childKey  当 query 查询到的值和 startValue 相等时，则比较 key 的大小
 * @return 返回一个 WDGSyncQuery 查询器类，用于响应在数据值大于 startValue，或等于 startValue 的值并且 key 大于或等于 childKey 的节点事件
 */
- (WDGSyncQuery *)queryStartingAtValue:(nullable id)startValue childKey:(nullable NSString *)childKey;


/**
 * queryEndingAtValue: 用于返回一个 WDGSyncQuery 实例，这个实例用来监测数据的变化，这些被监测的数据的值均小于或者等于 endValue。
 *
 * @param endValue query 查询到的值均小于等于 endValue
 * @return 返回一个 WDGSyncQuery 查询器类，用于响应在数据值均小于或等于 endValue 的节点事件
 */
- (WDGSyncQuery *)queryEndingAtValue:(nullable id)endValue;


/**
 * queryEndingAtValue:childKey: 用于返回一个 WDGSyncQuery 实例，这个实例用来监测数据的变化，这些被监测的数据的值小于 endValue，或者等于 endValue 并且 key 小于等于 childKey。
 *
 * @param endValue query查询到的值均小于等于endValue
 * @param childKey 当 query 查询到的值和 endValue 相等时，则比较它们 key 的大小
 * @return 返回一个 WDGSyncQuery 查询器类，用于响应在查询到的数据值小于 endValue，或者数据值等于 endValue 并且key 小于等于 childKey 的节点事件
 */
- (WDGSyncQuery *)queryEndingAtValue:(nullable id)endValue childKey:(nullable NSString *)childKey;


/**
 * queryEqualToValue: 用于返回一个 WDGSyncQuery 实例，这个实例用来监测数据的变化，这些被监测的数据的值都等于value。
 *
 * @param value query 查询到的值都等于 value
 * @return 返回一个 WDGSyncQuery 查询器类，用于响应这个与之相等数值节点事件
 */
- (WDGSyncQuery *)queryEqualToValue:(nullable id)value;


/**
 * queryEqualToValue:childKey: 用于返回一个 WDGSyncQuery 实例，这个实例用来监测数据的变化，这些被监测的数据的值等于 value 并且 key 等于 childKey。返回的值肯定是唯一的，因为 key 是唯一的。
 *
 * @param value query 查询到的值都等于 value
 * @param childKey query 查询到的 key 都等于 childKey
 * @return 返回一个 WDGSyncQuery 查询器类，用于响应这个与之相等数值和 key 节点事件
 */
- (WDGSyncQuery *)queryEqualToValue:(nullable id)value childKey:(nullable NSString *)childKey;

@end

NS_ASSUME_NONNULL_END
