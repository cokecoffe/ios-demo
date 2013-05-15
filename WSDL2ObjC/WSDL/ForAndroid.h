#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class ForAndroid_LoginAndroid;
@class ForAndroid_LoginAndroidResponse;
@class ForAndroid_GetNews;
@class ForAndroid_GetNewsResponse;
@class ForAndroid_GetNewsList;
@class ForAndroid_GetNewsListResponse;
@class ForAndroid_AddFeedBack;
@class ForAndroid_AddFeedBackResponse;
@class ForAndroid_CompleteAll;
@class ForAndroid_CompleteAllResponse;
@class ForAndroid_GetCompletePageList;
@class ForAndroid_GetCompletePageListResponse;
@class ForAndroid_SearchAccont;
@class ForAndroid_SearchAccontResponse;
@class ForAndroid_AddOrUpdateCarInfo;
@class ForAndroid_AddOrUpdateCarInfoResponse;
@class ForAndroid_AddOtherInfo;
@class ForAndroid_AddOtherInfoResponse;
@class ForAndroid_AddOrUpdateCarAttachment;
@class ForAndroid_AddOrUpdateCarAttachmentResponse;
@class ForAndroid_AddOrUpdateCarCondition;
@class ForAndroid_AddOrUpdateCarConditionResponse;
@class ForAndroid_AddDiagData;
@class ForAndroid_AddDiagDataResponse;
@class ForAndroid_AddupdateCarFileInfo;
@class ForAndroid_AddupdateCarFileInfoResponse;
@class ForAndroid_AddupdateDetectlist;
@class ForAndroid_AddupdateDetectlistResponse;
@class ForAndroid_AddupdateJmDetectlist;
@class ForAndroid_AddupdateJmDetectlistResponse;
@class ForAndroid_ForAndroidComplete;
@class ForAndroid_ForAndroidCompleteResponse;
@class ForAndroid_GetCarId;
@class ForAndroid_GetCarIdResponse;
@class ForAndroid_GetByVin;
@class ForAndroid_GetByVinResponse;
@class ForAndroid_GetBycarbiscid;
@class ForAndroid_GetBycarbiscidResponse;
@class ForAndroid_GetSixSuanfa;
@class ForAndroid_GetSixSuanfaResponse;
@class ForAndroid_SearchCarName;
@class ForAndroid_SearchCarNameResponse;
@class ForAndroid_GetDYCWCarInfo;
@class ForAndroid_GetDYCWCarInfoResponse;
@class ForAndroid_AddOrUpdateTaskOtherInfo;
@class ForAndroid_AddOrUpdateTaskOtherInfoResponse;
@class ForAndroid_GetTaskOtherInfoJsonByTaskID;
@class ForAndroid_GetTaskOtherInfoJsonByTaskIDResponse;
@class ForAndroid_GetCustomCarInfo;
@class ForAndroid_GetCustomCarInfoResponse;
@interface ForAndroid_LoginAndroid : NSObject {
	
/* elements */
	NSString * name;
	NSString * password;
	NSString * device;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ForAndroid_LoginAndroid *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * name;
@property (retain) NSString * password;
@property (retain) NSString * device;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ForAndroid_LoginAndroidResponse : NSObject {
	
/* elements */
	NSString * LoginAndroidResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ForAndroid_LoginAndroidResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * LoginAndroidResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ForAndroid_GetNews : NSObject {
	
/* elements */
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ForAndroid_GetNews *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ForAndroid_GetNewsResponse : NSObject {
	
/* elements */
	NSString * GetNewsResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ForAndroid_GetNewsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * GetNewsResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ForAndroid_GetNewsList : NSObject {
	
/* elements */
	NSNumber * pageindex;
	NSNumber * pagesize;
	NSNumber * type;
	NSString * sourse;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ForAndroid_GetNewsList *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * pageindex;
@property (retain) NSNumber * pagesize;
@property (retain) NSNumber * type;
@property (retain) NSString * sourse;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ForAndroid_GetNewsListResponse : NSObject {
	
/* elements */
	NSString * GetNewsListResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ForAndroid_GetNewsListResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * GetNewsListResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ForAndroid_AddFeedBack : NSObject {
	
/* elements */
	NSString * content;
	NSString * userid;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ForAndroid_AddFeedBack *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * content;
@property (retain) NSString * userid;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ForAndroid_AddFeedBackResponse : NSObject {
	
/* elements */
	NSString * AddFeedBackResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ForAndroid_AddFeedBackResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * AddFeedBackResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ForAndroid_CompleteAll : NSObject {
	
/* elements */
	NSNumber * userid;
	NSNumber * carid;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ForAndroid_CompleteAll *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * userid;
@property (retain) NSNumber * carid;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ForAndroid_CompleteAllResponse : NSObject {
	
/* elements */
	NSString * CompleteAllResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ForAndroid_CompleteAllResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * CompleteAllResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ForAndroid_GetCompletePageList : NSObject {
	
/* elements */
	NSNumber * pagesize;
	NSNumber * pageindex;
	NSString * sdate;
	NSString * edate;
	NSNumber * brandId;
	NSNumber * serialid;
	NSNumber * type;
	NSNumber * userid;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ForAndroid_GetCompletePageList *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * pagesize;
@property (retain) NSNumber * pageindex;
@property (retain) NSString * sdate;
@property (retain) NSString * edate;
@property (retain) NSNumber * brandId;
@property (retain) NSNumber * serialid;
@property (retain) NSNumber * type;
@property (retain) NSNumber * userid;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ForAndroid_GetCompletePageListResponse : NSObject {
	
/* elements */
	NSString * GetCompletePageListResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ForAndroid_GetCompletePageListResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * GetCompletePageListResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ForAndroid_SearchAccont : NSObject {
	
/* elements */
	NSString * key;
	NSNumber * pageindex;
	NSNumber * pagesize;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ForAndroid_SearchAccont *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * key;
@property (retain) NSNumber * pageindex;
@property (retain) NSNumber * pagesize;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ForAndroid_SearchAccontResponse : NSObject {
	
/* elements */
	NSString * SearchAccontResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ForAndroid_SearchAccontResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * SearchAccontResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ForAndroid_AddOrUpdateCarInfo : NSObject {
	
/* elements */
	NSString * json;
	NSNumber * tvaid;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ForAndroid_AddOrUpdateCarInfo *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * json;
@property (retain) NSNumber * tvaid;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ForAndroid_AddOrUpdateCarInfoResponse : NSObject {
	
/* elements */
	NSString * AddOrUpdateCarInfoResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ForAndroid_AddOrUpdateCarInfoResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * AddOrUpdateCarInfoResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ForAndroid_AddOtherInfo : NSObject {
	
/* elements */
	NSString * json;
	NSNumber * userid;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ForAndroid_AddOtherInfo *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * json;
@property (retain) NSNumber * userid;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ForAndroid_AddOtherInfoResponse : NSObject {
	
/* elements */
	NSString * AddOtherInfoResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ForAndroid_AddOtherInfoResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * AddOtherInfoResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ForAndroid_AddOrUpdateCarAttachment : NSObject {
	
/* elements */
	NSString * json;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ForAndroid_AddOrUpdateCarAttachment *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * json;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ForAndroid_AddOrUpdateCarAttachmentResponse : NSObject {
	
/* elements */
	NSString * AddOrUpdateCarAttachmentResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ForAndroid_AddOrUpdateCarAttachmentResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * AddOrUpdateCarAttachmentResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ForAndroid_AddOrUpdateCarCondition : NSObject {
	
/* elements */
	NSString * json;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ForAndroid_AddOrUpdateCarCondition *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * json;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ForAndroid_AddOrUpdateCarConditionResponse : NSObject {
	
/* elements */
	NSString * AddOrUpdateCarConditionResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ForAndroid_AddOrUpdateCarConditionResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * AddOrUpdateCarConditionResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ForAndroid_AddDiagData : NSObject {
	
/* elements */
	NSString * carid;
	NSNumber * userid;
	NSString * json;
	NSString * lawLess;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ForAndroid_AddDiagData *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * carid;
@property (retain) NSNumber * userid;
@property (retain) NSString * json;
@property (retain) NSString * lawLess;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ForAndroid_AddDiagDataResponse : NSObject {
	
/* elements */
	NSString * AddDiagDataResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ForAndroid_AddDiagDataResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * AddDiagDataResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ForAndroid_AddupdateCarFileInfo : NSObject {
	
/* elements */
	NSString * json;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ForAndroid_AddupdateCarFileInfo *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * json;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ForAndroid_AddupdateCarFileInfoResponse : NSObject {
	
/* elements */
	NSString * AddupdateCarFileInfoResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ForAndroid_AddupdateCarFileInfoResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * AddupdateCarFileInfoResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ForAndroid_AddupdateDetectlist : NSObject {
	
/* elements */
	NSString * json;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ForAndroid_AddupdateDetectlist *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * json;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ForAndroid_AddupdateDetectlistResponse : NSObject {
	
/* elements */
	NSString * AddupdateDetectlistResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ForAndroid_AddupdateDetectlistResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * AddupdateDetectlistResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ForAndroid_AddupdateJmDetectlist : NSObject {
	
/* elements */
	NSString * json;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ForAndroid_AddupdateJmDetectlist *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * json;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ForAndroid_AddupdateJmDetectlistResponse : NSObject {
	
/* elements */
	NSString * AddupdateJmDetectlistResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ForAndroid_AddupdateJmDetectlistResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * AddupdateJmDetectlistResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ForAndroid_ForAndroidComplete : NSObject {
	
/* elements */
	NSNumber * userid;
	NSNumber * carid;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ForAndroid_ForAndroidComplete *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * userid;
@property (retain) NSNumber * carid;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ForAndroid_ForAndroidCompleteResponse : NSObject {
	
/* elements */
	NSString * ForAndroidCompleteResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ForAndroid_ForAndroidCompleteResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * ForAndroidCompleteResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ForAndroid_GetCarId : NSObject {
	
/* elements */
	NSNumber * userid;
	NSNumber * carid;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ForAndroid_GetCarId *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * userid;
@property (retain) NSNumber * carid;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ForAndroid_GetCarIdResponse : NSObject {
	
/* elements */
	NSString * GetCarIdResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ForAndroid_GetCarIdResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * GetCarIdResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ForAndroid_GetByVin : NSObject {
	
/* elements */
	NSString * vin;
	NSString * code;
	NSString * ccsj;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ForAndroid_GetByVin *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * vin;
@property (retain) NSString * code;
@property (retain) NSString * ccsj;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ForAndroid_GetByVinResponse : NSObject {
	
/* elements */
	NSString * GetByVinResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ForAndroid_GetByVinResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * GetByVinResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ForAndroid_GetBycarbiscid : NSObject {
	
/* elements */
	NSNumber * carbiscid;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ForAndroid_GetBycarbiscid *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * carbiscid;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ForAndroid_GetBycarbiscidResponse : NSObject {
	
/* elements */
	NSString * GetBycarbiscidResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ForAndroid_GetBycarbiscidResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * GetBycarbiscidResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ForAndroid_GetSixSuanfa : NSObject {
	
/* elements */
	NSString * json;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ForAndroid_GetSixSuanfa *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * json;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ForAndroid_GetSixSuanfaResponse : NSObject {
	
/* elements */
	NSString * GetSixSuanfaResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ForAndroid_GetSixSuanfaResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * GetSixSuanfaResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ForAndroid_SearchCarName : NSObject {
	
/* elements */
	NSString * json;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ForAndroid_SearchCarName *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * json;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ForAndroid_SearchCarNameResponse : NSObject {
	
/* elements */
	NSString * SearchCarNameResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ForAndroid_SearchCarNameResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * SearchCarNameResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ForAndroid_GetDYCWCarInfo : NSObject {
	
/* elements */
	NSNumber * BranId;
	NSNumber * SerieId;
	NSNumber * ProducerId;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ForAndroid_GetDYCWCarInfo *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * BranId;
@property (retain) NSNumber * SerieId;
@property (retain) NSNumber * ProducerId;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ForAndroid_GetDYCWCarInfoResponse : NSObject {
	
/* elements */
	NSString * GetDYCWCarInfoResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ForAndroid_GetDYCWCarInfoResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * GetDYCWCarInfoResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ForAndroid_AddOrUpdateTaskOtherInfo : NSObject {
	
/* elements */
	NSString * json;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ForAndroid_AddOrUpdateTaskOtherInfo *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * json;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ForAndroid_AddOrUpdateTaskOtherInfoResponse : NSObject {
	
/* elements */
	NSString * AddOrUpdateTaskOtherInfoResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ForAndroid_AddOrUpdateTaskOtherInfoResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * AddOrUpdateTaskOtherInfoResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ForAndroid_GetTaskOtherInfoJsonByTaskID : NSObject {
	
/* elements */
	NSNumber * taskID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ForAndroid_GetTaskOtherInfoJsonByTaskID *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * taskID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ForAndroid_GetTaskOtherInfoJsonByTaskIDResponse : NSObject {
	
/* elements */
	NSString * GetTaskOtherInfoJsonByTaskIDResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ForAndroid_GetTaskOtherInfoJsonByTaskIDResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * GetTaskOtherInfoJsonByTaskIDResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ForAndroid_GetCustomCarInfo : NSObject {
	
/* elements */
	NSNumber * userid;
	NSNumber * carid;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ForAndroid_GetCustomCarInfo *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * userid;
@property (retain) NSNumber * carid;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ForAndroid_GetCustomCarInfoResponse : NSObject {
	
/* elements */
	NSString * GetCustomCarInfoResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ForAndroid_GetCustomCarInfoResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * GetCustomCarInfoResult;
/* attributes */
- (NSDictionary *)attributes;
@end
/* Cookies handling provided by http://en.wikibooks.org/wiki/Programming:WebObjects/Web_Services/Web_Service_Provider */
#import <libxml/parser.h>
#import "xsd.h"
#import "ForAndroid.h"
@class ForAndroidSoapBinding;
@class ForAndroidSoap12Binding;
@interface ForAndroid : NSObject {
	
}
+ (ForAndroidSoapBinding *)ForAndroidSoapBinding;
+ (ForAndroidSoap12Binding *)ForAndroidSoap12Binding;
@end
@class ForAndroidSoapBindingResponse;
@class ForAndroidSoapBindingOperation;
@protocol ForAndroidSoapBindingResponseDelegate <NSObject>
- (void) operation:(ForAndroidSoapBindingOperation *)operation completedWithResponse:(ForAndroidSoapBindingResponse *)response;
@end
@interface ForAndroidSoapBinding : NSObject <ForAndroidSoapBindingResponseDelegate> {
	NSURL *address;
	NSTimeInterval defaultTimeout;
	NSMutableArray *cookies;
	BOOL logXMLInOut;
	BOOL synchronousOperationComplete;
	NSString *authUsername;
	NSString *authPassword;
}
@property (copy) NSURL *address;
@property (assign) BOOL logXMLInOut;
@property (assign) NSTimeInterval defaultTimeout;
@property (nonatomic, retain) NSMutableArray *cookies;
@property (nonatomic, retain) NSString *authUsername;
@property (nonatomic, retain) NSString *authPassword;
- (id)initWithAddress:(NSString *)anAddress;
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(ForAndroidSoapBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (ForAndroidSoapBindingResponse *)LoginAndroidUsingParameters:(ForAndroid_LoginAndroid *)aParameters ;
- (void)LoginAndroidAsyncUsingParameters:(ForAndroid_LoginAndroid *)aParameters  delegate:(id<ForAndroidSoapBindingResponseDelegate>)responseDelegate;
- (ForAndroidSoapBindingResponse *)GetNewsUsingParameters:(ForAndroid_GetNews *)aParameters ;
- (void)GetNewsAsyncUsingParameters:(ForAndroid_GetNews *)aParameters  delegate:(id<ForAndroidSoapBindingResponseDelegate>)responseDelegate;
- (ForAndroidSoapBindingResponse *)GetNewsListUsingParameters:(ForAndroid_GetNewsList *)aParameters ;
- (void)GetNewsListAsyncUsingParameters:(ForAndroid_GetNewsList *)aParameters  delegate:(id<ForAndroidSoapBindingResponseDelegate>)responseDelegate;
- (ForAndroidSoapBindingResponse *)AddFeedBackUsingParameters:(ForAndroid_AddFeedBack *)aParameters ;
- (void)AddFeedBackAsyncUsingParameters:(ForAndroid_AddFeedBack *)aParameters  delegate:(id<ForAndroidSoapBindingResponseDelegate>)responseDelegate;
- (ForAndroidSoapBindingResponse *)CompleteAllUsingParameters:(ForAndroid_CompleteAll *)aParameters ;
- (void)CompleteAllAsyncUsingParameters:(ForAndroid_CompleteAll *)aParameters  delegate:(id<ForAndroidSoapBindingResponseDelegate>)responseDelegate;
- (ForAndroidSoapBindingResponse *)GetCompletePageListUsingParameters:(ForAndroid_GetCompletePageList *)aParameters ;
- (void)GetCompletePageListAsyncUsingParameters:(ForAndroid_GetCompletePageList *)aParameters  delegate:(id<ForAndroidSoapBindingResponseDelegate>)responseDelegate;
- (ForAndroidSoapBindingResponse *)SearchAccontUsingParameters:(ForAndroid_SearchAccont *)aParameters ;
- (void)SearchAccontAsyncUsingParameters:(ForAndroid_SearchAccont *)aParameters  delegate:(id<ForAndroidSoapBindingResponseDelegate>)responseDelegate;
- (ForAndroidSoapBindingResponse *)AddOrUpdateCarInfoUsingParameters:(ForAndroid_AddOrUpdateCarInfo *)aParameters ;
- (void)AddOrUpdateCarInfoAsyncUsingParameters:(ForAndroid_AddOrUpdateCarInfo *)aParameters  delegate:(id<ForAndroidSoapBindingResponseDelegate>)responseDelegate;
- (ForAndroidSoapBindingResponse *)AddOtherInfoUsingParameters:(ForAndroid_AddOtherInfo *)aParameters ;
- (void)AddOtherInfoAsyncUsingParameters:(ForAndroid_AddOtherInfo *)aParameters  delegate:(id<ForAndroidSoapBindingResponseDelegate>)responseDelegate;
- (ForAndroidSoapBindingResponse *)AddOrUpdateCarAttachmentUsingParameters:(ForAndroid_AddOrUpdateCarAttachment *)aParameters ;
- (void)AddOrUpdateCarAttachmentAsyncUsingParameters:(ForAndroid_AddOrUpdateCarAttachment *)aParameters  delegate:(id<ForAndroidSoapBindingResponseDelegate>)responseDelegate;
- (ForAndroidSoapBindingResponse *)AddOrUpdateCarConditionUsingParameters:(ForAndroid_AddOrUpdateCarCondition *)aParameters ;
- (void)AddOrUpdateCarConditionAsyncUsingParameters:(ForAndroid_AddOrUpdateCarCondition *)aParameters  delegate:(id<ForAndroidSoapBindingResponseDelegate>)responseDelegate;
- (ForAndroidSoapBindingResponse *)AddDiagDataUsingParameters:(ForAndroid_AddDiagData *)aParameters ;
- (void)AddDiagDataAsyncUsingParameters:(ForAndroid_AddDiagData *)aParameters  delegate:(id<ForAndroidSoapBindingResponseDelegate>)responseDelegate;
- (ForAndroidSoapBindingResponse *)AddupdateCarFileInfoUsingParameters:(ForAndroid_AddupdateCarFileInfo *)aParameters ;
- (void)AddupdateCarFileInfoAsyncUsingParameters:(ForAndroid_AddupdateCarFileInfo *)aParameters  delegate:(id<ForAndroidSoapBindingResponseDelegate>)responseDelegate;
- (ForAndroidSoapBindingResponse *)AddupdateDetectlistUsingParameters:(ForAndroid_AddupdateDetectlist *)aParameters ;
- (void)AddupdateDetectlistAsyncUsingParameters:(ForAndroid_AddupdateDetectlist *)aParameters  delegate:(id<ForAndroidSoapBindingResponseDelegate>)responseDelegate;
- (ForAndroidSoapBindingResponse *)AddupdateJmDetectlistUsingParameters:(ForAndroid_AddupdateJmDetectlist *)aParameters ;
- (void)AddupdateJmDetectlistAsyncUsingParameters:(ForAndroid_AddupdateJmDetectlist *)aParameters  delegate:(id<ForAndroidSoapBindingResponseDelegate>)responseDelegate;
- (ForAndroidSoapBindingResponse *)ForAndroidCompleteUsingParameters:(ForAndroid_ForAndroidComplete *)aParameters ;
- (void)ForAndroidCompleteAsyncUsingParameters:(ForAndroid_ForAndroidComplete *)aParameters  delegate:(id<ForAndroidSoapBindingResponseDelegate>)responseDelegate;
- (ForAndroidSoapBindingResponse *)GetCarIdUsingParameters:(ForAndroid_GetCarId *)aParameters ;
- (void)GetCarIdAsyncUsingParameters:(ForAndroid_GetCarId *)aParameters  delegate:(id<ForAndroidSoapBindingResponseDelegate>)responseDelegate;
- (ForAndroidSoapBindingResponse *)GetByVinUsingParameters:(ForAndroid_GetByVin *)aParameters ;
- (void)GetByVinAsyncUsingParameters:(ForAndroid_GetByVin *)aParameters  delegate:(id<ForAndroidSoapBindingResponseDelegate>)responseDelegate;
- (ForAndroidSoapBindingResponse *)GetBycarbiscidUsingParameters:(ForAndroid_GetBycarbiscid *)aParameters ;
- (void)GetBycarbiscidAsyncUsingParameters:(ForAndroid_GetBycarbiscid *)aParameters  delegate:(id<ForAndroidSoapBindingResponseDelegate>)responseDelegate;
- (ForAndroidSoapBindingResponse *)GetSixSuanfaUsingParameters:(ForAndroid_GetSixSuanfa *)aParameters ;
- (void)GetSixSuanfaAsyncUsingParameters:(ForAndroid_GetSixSuanfa *)aParameters  delegate:(id<ForAndroidSoapBindingResponseDelegate>)responseDelegate;
- (ForAndroidSoapBindingResponse *)SearchCarNameUsingParameters:(ForAndroid_SearchCarName *)aParameters ;
- (void)SearchCarNameAsyncUsingParameters:(ForAndroid_SearchCarName *)aParameters  delegate:(id<ForAndroidSoapBindingResponseDelegate>)responseDelegate;
- (ForAndroidSoapBindingResponse *)GetDYCWCarInfoUsingParameters:(ForAndroid_GetDYCWCarInfo *)aParameters ;
- (void)GetDYCWCarInfoAsyncUsingParameters:(ForAndroid_GetDYCWCarInfo *)aParameters  delegate:(id<ForAndroidSoapBindingResponseDelegate>)responseDelegate;
- (ForAndroidSoapBindingResponse *)AddOrUpdateTaskOtherInfoUsingParameters:(ForAndroid_AddOrUpdateTaskOtherInfo *)aParameters ;
- (void)AddOrUpdateTaskOtherInfoAsyncUsingParameters:(ForAndroid_AddOrUpdateTaskOtherInfo *)aParameters  delegate:(id<ForAndroidSoapBindingResponseDelegate>)responseDelegate;
- (ForAndroidSoapBindingResponse *)GetTaskOtherInfoJsonByTaskIDUsingParameters:(ForAndroid_GetTaskOtherInfoJsonByTaskID *)aParameters ;
- (void)GetTaskOtherInfoJsonByTaskIDAsyncUsingParameters:(ForAndroid_GetTaskOtherInfoJsonByTaskID *)aParameters  delegate:(id<ForAndroidSoapBindingResponseDelegate>)responseDelegate;
- (ForAndroidSoapBindingResponse *)GetCustomCarInfoUsingParameters:(ForAndroid_GetCustomCarInfo *)aParameters ;
- (void)GetCustomCarInfoAsyncUsingParameters:(ForAndroid_GetCustomCarInfo *)aParameters  delegate:(id<ForAndroidSoapBindingResponseDelegate>)responseDelegate;
@end
@interface ForAndroidSoapBindingOperation : NSOperation {
	ForAndroidSoapBinding *binding;
	ForAndroidSoapBindingResponse *response;
	id<ForAndroidSoapBindingResponseDelegate> delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (retain) ForAndroidSoapBinding *binding;
@property (readonly) ForAndroidSoapBindingResponse *response;
@property (nonatomic, assign) id<ForAndroidSoapBindingResponseDelegate> delegate;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) NSURLConnection *urlConnection;
- (id)initWithBinding:(ForAndroidSoapBinding *)aBinding delegate:(id<ForAndroidSoapBindingResponseDelegate>)aDelegate;
@end
@interface ForAndroidSoapBinding_LoginAndroid : ForAndroidSoapBindingOperation {
	ForAndroid_LoginAndroid * parameters;
}
@property (retain) ForAndroid_LoginAndroid * parameters;
- (id)initWithBinding:(ForAndroidSoapBinding *)aBinding delegate:(id<ForAndroidSoapBindingResponseDelegate>)aDelegate
	parameters:(ForAndroid_LoginAndroid *)aParameters
;
@end
@interface ForAndroidSoapBinding_GetNews : ForAndroidSoapBindingOperation {
	ForAndroid_GetNews * parameters;
}
@property (retain) ForAndroid_GetNews * parameters;
- (id)initWithBinding:(ForAndroidSoapBinding *)aBinding delegate:(id<ForAndroidSoapBindingResponseDelegate>)aDelegate
	parameters:(ForAndroid_GetNews *)aParameters
;
@end
@interface ForAndroidSoapBinding_GetNewsList : ForAndroidSoapBindingOperation {
	ForAndroid_GetNewsList * parameters;
}
@property (retain) ForAndroid_GetNewsList * parameters;
- (id)initWithBinding:(ForAndroidSoapBinding *)aBinding delegate:(id<ForAndroidSoapBindingResponseDelegate>)aDelegate
	parameters:(ForAndroid_GetNewsList *)aParameters
;
@end
@interface ForAndroidSoapBinding_AddFeedBack : ForAndroidSoapBindingOperation {
	ForAndroid_AddFeedBack * parameters;
}
@property (retain) ForAndroid_AddFeedBack * parameters;
- (id)initWithBinding:(ForAndroidSoapBinding *)aBinding delegate:(id<ForAndroidSoapBindingResponseDelegate>)aDelegate
	parameters:(ForAndroid_AddFeedBack *)aParameters
;
@end
@interface ForAndroidSoapBinding_CompleteAll : ForAndroidSoapBindingOperation {
	ForAndroid_CompleteAll * parameters;
}
@property (retain) ForAndroid_CompleteAll * parameters;
- (id)initWithBinding:(ForAndroidSoapBinding *)aBinding delegate:(id<ForAndroidSoapBindingResponseDelegate>)aDelegate
	parameters:(ForAndroid_CompleteAll *)aParameters
;
@end
@interface ForAndroidSoapBinding_GetCompletePageList : ForAndroidSoapBindingOperation {
	ForAndroid_GetCompletePageList * parameters;
}
@property (retain) ForAndroid_GetCompletePageList * parameters;
- (id)initWithBinding:(ForAndroidSoapBinding *)aBinding delegate:(id<ForAndroidSoapBindingResponseDelegate>)aDelegate
	parameters:(ForAndroid_GetCompletePageList *)aParameters
;
@end
@interface ForAndroidSoapBinding_SearchAccont : ForAndroidSoapBindingOperation {
	ForAndroid_SearchAccont * parameters;
}
@property (retain) ForAndroid_SearchAccont * parameters;
- (id)initWithBinding:(ForAndroidSoapBinding *)aBinding delegate:(id<ForAndroidSoapBindingResponseDelegate>)aDelegate
	parameters:(ForAndroid_SearchAccont *)aParameters
;
@end
@interface ForAndroidSoapBinding_AddOrUpdateCarInfo : ForAndroidSoapBindingOperation {
	ForAndroid_AddOrUpdateCarInfo * parameters;
}
@property (retain) ForAndroid_AddOrUpdateCarInfo * parameters;
- (id)initWithBinding:(ForAndroidSoapBinding *)aBinding delegate:(id<ForAndroidSoapBindingResponseDelegate>)aDelegate
	parameters:(ForAndroid_AddOrUpdateCarInfo *)aParameters
;
@end
@interface ForAndroidSoapBinding_AddOtherInfo : ForAndroidSoapBindingOperation {
	ForAndroid_AddOtherInfo * parameters;
}
@property (retain) ForAndroid_AddOtherInfo * parameters;
- (id)initWithBinding:(ForAndroidSoapBinding *)aBinding delegate:(id<ForAndroidSoapBindingResponseDelegate>)aDelegate
	parameters:(ForAndroid_AddOtherInfo *)aParameters
;
@end
@interface ForAndroidSoapBinding_AddOrUpdateCarAttachment : ForAndroidSoapBindingOperation {
	ForAndroid_AddOrUpdateCarAttachment * parameters;
}
@property (retain) ForAndroid_AddOrUpdateCarAttachment * parameters;
- (id)initWithBinding:(ForAndroidSoapBinding *)aBinding delegate:(id<ForAndroidSoapBindingResponseDelegate>)aDelegate
	parameters:(ForAndroid_AddOrUpdateCarAttachment *)aParameters
;
@end
@interface ForAndroidSoapBinding_AddOrUpdateCarCondition : ForAndroidSoapBindingOperation {
	ForAndroid_AddOrUpdateCarCondition * parameters;
}
@property (retain) ForAndroid_AddOrUpdateCarCondition * parameters;
- (id)initWithBinding:(ForAndroidSoapBinding *)aBinding delegate:(id<ForAndroidSoapBindingResponseDelegate>)aDelegate
	parameters:(ForAndroid_AddOrUpdateCarCondition *)aParameters
;
@end
@interface ForAndroidSoapBinding_AddDiagData : ForAndroidSoapBindingOperation {
	ForAndroid_AddDiagData * parameters;
}
@property (retain) ForAndroid_AddDiagData * parameters;
- (id)initWithBinding:(ForAndroidSoapBinding *)aBinding delegate:(id<ForAndroidSoapBindingResponseDelegate>)aDelegate
	parameters:(ForAndroid_AddDiagData *)aParameters
;
@end
@interface ForAndroidSoapBinding_AddupdateCarFileInfo : ForAndroidSoapBindingOperation {
	ForAndroid_AddupdateCarFileInfo * parameters;
}
@property (retain) ForAndroid_AddupdateCarFileInfo * parameters;
- (id)initWithBinding:(ForAndroidSoapBinding *)aBinding delegate:(id<ForAndroidSoapBindingResponseDelegate>)aDelegate
	parameters:(ForAndroid_AddupdateCarFileInfo *)aParameters
;
@end
@interface ForAndroidSoapBinding_AddupdateDetectlist : ForAndroidSoapBindingOperation {
	ForAndroid_AddupdateDetectlist * parameters;
}
@property (retain) ForAndroid_AddupdateDetectlist * parameters;
- (id)initWithBinding:(ForAndroidSoapBinding *)aBinding delegate:(id<ForAndroidSoapBindingResponseDelegate>)aDelegate
	parameters:(ForAndroid_AddupdateDetectlist *)aParameters
;
@end
@interface ForAndroidSoapBinding_AddupdateJmDetectlist : ForAndroidSoapBindingOperation {
	ForAndroid_AddupdateJmDetectlist * parameters;
}
@property (retain) ForAndroid_AddupdateJmDetectlist * parameters;
- (id)initWithBinding:(ForAndroidSoapBinding *)aBinding delegate:(id<ForAndroidSoapBindingResponseDelegate>)aDelegate
	parameters:(ForAndroid_AddupdateJmDetectlist *)aParameters
;
@end
@interface ForAndroidSoapBinding_ForAndroidComplete : ForAndroidSoapBindingOperation {
	ForAndroid_ForAndroidComplete * parameters;
}
@property (retain) ForAndroid_ForAndroidComplete * parameters;
- (id)initWithBinding:(ForAndroidSoapBinding *)aBinding delegate:(id<ForAndroidSoapBindingResponseDelegate>)aDelegate
	parameters:(ForAndroid_ForAndroidComplete *)aParameters
;
@end
@interface ForAndroidSoapBinding_GetCarId : ForAndroidSoapBindingOperation {
	ForAndroid_GetCarId * parameters;
}
@property (retain) ForAndroid_GetCarId * parameters;
- (id)initWithBinding:(ForAndroidSoapBinding *)aBinding delegate:(id<ForAndroidSoapBindingResponseDelegate>)aDelegate
	parameters:(ForAndroid_GetCarId *)aParameters
;
@end
@interface ForAndroidSoapBinding_GetByVin : ForAndroidSoapBindingOperation {
	ForAndroid_GetByVin * parameters;
}
@property (retain) ForAndroid_GetByVin * parameters;
- (id)initWithBinding:(ForAndroidSoapBinding *)aBinding delegate:(id<ForAndroidSoapBindingResponseDelegate>)aDelegate
	parameters:(ForAndroid_GetByVin *)aParameters
;
@end
@interface ForAndroidSoapBinding_GetBycarbiscid : ForAndroidSoapBindingOperation {
	ForAndroid_GetBycarbiscid * parameters;
}
@property (retain) ForAndroid_GetBycarbiscid * parameters;
- (id)initWithBinding:(ForAndroidSoapBinding *)aBinding delegate:(id<ForAndroidSoapBindingResponseDelegate>)aDelegate
	parameters:(ForAndroid_GetBycarbiscid *)aParameters
;
@end
@interface ForAndroidSoapBinding_GetSixSuanfa : ForAndroidSoapBindingOperation {
	ForAndroid_GetSixSuanfa * parameters;
}
@property (retain) ForAndroid_GetSixSuanfa * parameters;
- (id)initWithBinding:(ForAndroidSoapBinding *)aBinding delegate:(id<ForAndroidSoapBindingResponseDelegate>)aDelegate
	parameters:(ForAndroid_GetSixSuanfa *)aParameters
;
@end
@interface ForAndroidSoapBinding_SearchCarName : ForAndroidSoapBindingOperation {
	ForAndroid_SearchCarName * parameters;
}
@property (retain) ForAndroid_SearchCarName * parameters;
- (id)initWithBinding:(ForAndroidSoapBinding *)aBinding delegate:(id<ForAndroidSoapBindingResponseDelegate>)aDelegate
	parameters:(ForAndroid_SearchCarName *)aParameters
;
@end
@interface ForAndroidSoapBinding_GetDYCWCarInfo : ForAndroidSoapBindingOperation {
	ForAndroid_GetDYCWCarInfo * parameters;
}
@property (retain) ForAndroid_GetDYCWCarInfo * parameters;
- (id)initWithBinding:(ForAndroidSoapBinding *)aBinding delegate:(id<ForAndroidSoapBindingResponseDelegate>)aDelegate
	parameters:(ForAndroid_GetDYCWCarInfo *)aParameters
;
@end
@interface ForAndroidSoapBinding_AddOrUpdateTaskOtherInfo : ForAndroidSoapBindingOperation {
	ForAndroid_AddOrUpdateTaskOtherInfo * parameters;
}
@property (retain) ForAndroid_AddOrUpdateTaskOtherInfo * parameters;
- (id)initWithBinding:(ForAndroidSoapBinding *)aBinding delegate:(id<ForAndroidSoapBindingResponseDelegate>)aDelegate
	parameters:(ForAndroid_AddOrUpdateTaskOtherInfo *)aParameters
;
@end
@interface ForAndroidSoapBinding_GetTaskOtherInfoJsonByTaskID : ForAndroidSoapBindingOperation {
	ForAndroid_GetTaskOtherInfoJsonByTaskID * parameters;
}
@property (retain) ForAndroid_GetTaskOtherInfoJsonByTaskID * parameters;
- (id)initWithBinding:(ForAndroidSoapBinding *)aBinding delegate:(id<ForAndroidSoapBindingResponseDelegate>)aDelegate
	parameters:(ForAndroid_GetTaskOtherInfoJsonByTaskID *)aParameters
;
@end
@interface ForAndroidSoapBinding_GetCustomCarInfo : ForAndroidSoapBindingOperation {
	ForAndroid_GetCustomCarInfo * parameters;
}
@property (retain) ForAndroid_GetCustomCarInfo * parameters;
- (id)initWithBinding:(ForAndroidSoapBinding *)aBinding delegate:(id<ForAndroidSoapBindingResponseDelegate>)aDelegate
	parameters:(ForAndroid_GetCustomCarInfo *)aParameters
;
@end
@interface ForAndroidSoapBinding_envelope : NSObject {
}
+ (ForAndroidSoapBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface ForAndroidSoapBindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (retain) NSArray *headers;
@property (retain) NSArray *bodyParts;
@property (retain) NSError *error;
@end
@class ForAndroidSoap12BindingResponse;
@class ForAndroidSoap12BindingOperation;
@protocol ForAndroidSoap12BindingResponseDelegate <NSObject>
- (void) operation:(ForAndroidSoap12BindingOperation *)operation completedWithResponse:(ForAndroidSoap12BindingResponse *)response;
@end
@interface ForAndroidSoap12Binding : NSObject <ForAndroidSoap12BindingResponseDelegate> {
	NSURL *address;
	NSTimeInterval defaultTimeout;
	NSMutableArray *cookies;
	BOOL logXMLInOut;
	BOOL synchronousOperationComplete;
	NSString *authUsername;
	NSString *authPassword;
}
@property (copy) NSURL *address;
@property (assign) BOOL logXMLInOut;
@property (assign) NSTimeInterval defaultTimeout;
@property (nonatomic, retain) NSMutableArray *cookies;
@property (nonatomic, retain) NSString *authUsername;
@property (nonatomic, retain) NSString *authPassword;
- (id)initWithAddress:(NSString *)anAddress;
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(ForAndroidSoap12BindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (ForAndroidSoap12BindingResponse *)LoginAndroidUsingParameters:(ForAndroid_LoginAndroid *)aParameters ;
- (void)LoginAndroidAsyncUsingParameters:(ForAndroid_LoginAndroid *)aParameters  delegate:(id<ForAndroidSoap12BindingResponseDelegate>)responseDelegate;
- (ForAndroidSoap12BindingResponse *)GetNewsUsingParameters:(ForAndroid_GetNews *)aParameters ;
- (void)GetNewsAsyncUsingParameters:(ForAndroid_GetNews *)aParameters  delegate:(id<ForAndroidSoap12BindingResponseDelegate>)responseDelegate;
- (ForAndroidSoap12BindingResponse *)GetNewsListUsingParameters:(ForAndroid_GetNewsList *)aParameters ;
- (void)GetNewsListAsyncUsingParameters:(ForAndroid_GetNewsList *)aParameters  delegate:(id<ForAndroidSoap12BindingResponseDelegate>)responseDelegate;
- (ForAndroidSoap12BindingResponse *)AddFeedBackUsingParameters:(ForAndroid_AddFeedBack *)aParameters ;
- (void)AddFeedBackAsyncUsingParameters:(ForAndroid_AddFeedBack *)aParameters  delegate:(id<ForAndroidSoap12BindingResponseDelegate>)responseDelegate;
- (ForAndroidSoap12BindingResponse *)CompleteAllUsingParameters:(ForAndroid_CompleteAll *)aParameters ;
- (void)CompleteAllAsyncUsingParameters:(ForAndroid_CompleteAll *)aParameters  delegate:(id<ForAndroidSoap12BindingResponseDelegate>)responseDelegate;
- (ForAndroidSoap12BindingResponse *)GetCompletePageListUsingParameters:(ForAndroid_GetCompletePageList *)aParameters ;
- (void)GetCompletePageListAsyncUsingParameters:(ForAndroid_GetCompletePageList *)aParameters  delegate:(id<ForAndroidSoap12BindingResponseDelegate>)responseDelegate;
- (ForAndroidSoap12BindingResponse *)SearchAccontUsingParameters:(ForAndroid_SearchAccont *)aParameters ;
- (void)SearchAccontAsyncUsingParameters:(ForAndroid_SearchAccont *)aParameters  delegate:(id<ForAndroidSoap12BindingResponseDelegate>)responseDelegate;
- (ForAndroidSoap12BindingResponse *)AddOrUpdateCarInfoUsingParameters:(ForAndroid_AddOrUpdateCarInfo *)aParameters ;
- (void)AddOrUpdateCarInfoAsyncUsingParameters:(ForAndroid_AddOrUpdateCarInfo *)aParameters  delegate:(id<ForAndroidSoap12BindingResponseDelegate>)responseDelegate;
- (ForAndroidSoap12BindingResponse *)AddOtherInfoUsingParameters:(ForAndroid_AddOtherInfo *)aParameters ;
- (void)AddOtherInfoAsyncUsingParameters:(ForAndroid_AddOtherInfo *)aParameters  delegate:(id<ForAndroidSoap12BindingResponseDelegate>)responseDelegate;
- (ForAndroidSoap12BindingResponse *)AddOrUpdateCarAttachmentUsingParameters:(ForAndroid_AddOrUpdateCarAttachment *)aParameters ;
- (void)AddOrUpdateCarAttachmentAsyncUsingParameters:(ForAndroid_AddOrUpdateCarAttachment *)aParameters  delegate:(id<ForAndroidSoap12BindingResponseDelegate>)responseDelegate;
- (ForAndroidSoap12BindingResponse *)AddOrUpdateCarConditionUsingParameters:(ForAndroid_AddOrUpdateCarCondition *)aParameters ;
- (void)AddOrUpdateCarConditionAsyncUsingParameters:(ForAndroid_AddOrUpdateCarCondition *)aParameters  delegate:(id<ForAndroidSoap12BindingResponseDelegate>)responseDelegate;
- (ForAndroidSoap12BindingResponse *)AddDiagDataUsingParameters:(ForAndroid_AddDiagData *)aParameters ;
- (void)AddDiagDataAsyncUsingParameters:(ForAndroid_AddDiagData *)aParameters  delegate:(id<ForAndroidSoap12BindingResponseDelegate>)responseDelegate;
- (ForAndroidSoap12BindingResponse *)AddupdateCarFileInfoUsingParameters:(ForAndroid_AddupdateCarFileInfo *)aParameters ;
- (void)AddupdateCarFileInfoAsyncUsingParameters:(ForAndroid_AddupdateCarFileInfo *)aParameters  delegate:(id<ForAndroidSoap12BindingResponseDelegate>)responseDelegate;
- (ForAndroidSoap12BindingResponse *)AddupdateDetectlistUsingParameters:(ForAndroid_AddupdateDetectlist *)aParameters ;
- (void)AddupdateDetectlistAsyncUsingParameters:(ForAndroid_AddupdateDetectlist *)aParameters  delegate:(id<ForAndroidSoap12BindingResponseDelegate>)responseDelegate;
- (ForAndroidSoap12BindingResponse *)AddupdateJmDetectlistUsingParameters:(ForAndroid_AddupdateJmDetectlist *)aParameters ;
- (void)AddupdateJmDetectlistAsyncUsingParameters:(ForAndroid_AddupdateJmDetectlist *)aParameters  delegate:(id<ForAndroidSoap12BindingResponseDelegate>)responseDelegate;
- (ForAndroidSoap12BindingResponse *)ForAndroidCompleteUsingParameters:(ForAndroid_ForAndroidComplete *)aParameters ;
- (void)ForAndroidCompleteAsyncUsingParameters:(ForAndroid_ForAndroidComplete *)aParameters  delegate:(id<ForAndroidSoap12BindingResponseDelegate>)responseDelegate;
- (ForAndroidSoap12BindingResponse *)GetCarIdUsingParameters:(ForAndroid_GetCarId *)aParameters ;
- (void)GetCarIdAsyncUsingParameters:(ForAndroid_GetCarId *)aParameters  delegate:(id<ForAndroidSoap12BindingResponseDelegate>)responseDelegate;
- (ForAndroidSoap12BindingResponse *)GetByVinUsingParameters:(ForAndroid_GetByVin *)aParameters ;
- (void)GetByVinAsyncUsingParameters:(ForAndroid_GetByVin *)aParameters  delegate:(id<ForAndroidSoap12BindingResponseDelegate>)responseDelegate;
- (ForAndroidSoap12BindingResponse *)GetBycarbiscidUsingParameters:(ForAndroid_GetBycarbiscid *)aParameters ;
- (void)GetBycarbiscidAsyncUsingParameters:(ForAndroid_GetBycarbiscid *)aParameters  delegate:(id<ForAndroidSoap12BindingResponseDelegate>)responseDelegate;
- (ForAndroidSoap12BindingResponse *)GetSixSuanfaUsingParameters:(ForAndroid_GetSixSuanfa *)aParameters ;
- (void)GetSixSuanfaAsyncUsingParameters:(ForAndroid_GetSixSuanfa *)aParameters  delegate:(id<ForAndroidSoap12BindingResponseDelegate>)responseDelegate;
- (ForAndroidSoap12BindingResponse *)SearchCarNameUsingParameters:(ForAndroid_SearchCarName *)aParameters ;
- (void)SearchCarNameAsyncUsingParameters:(ForAndroid_SearchCarName *)aParameters  delegate:(id<ForAndroidSoap12BindingResponseDelegate>)responseDelegate;
- (ForAndroidSoap12BindingResponse *)GetDYCWCarInfoUsingParameters:(ForAndroid_GetDYCWCarInfo *)aParameters ;
- (void)GetDYCWCarInfoAsyncUsingParameters:(ForAndroid_GetDYCWCarInfo *)aParameters  delegate:(id<ForAndroidSoap12BindingResponseDelegate>)responseDelegate;
- (ForAndroidSoap12BindingResponse *)AddOrUpdateTaskOtherInfoUsingParameters:(ForAndroid_AddOrUpdateTaskOtherInfo *)aParameters ;
- (void)AddOrUpdateTaskOtherInfoAsyncUsingParameters:(ForAndroid_AddOrUpdateTaskOtherInfo *)aParameters  delegate:(id<ForAndroidSoap12BindingResponseDelegate>)responseDelegate;
- (ForAndroidSoap12BindingResponse *)GetTaskOtherInfoJsonByTaskIDUsingParameters:(ForAndroid_GetTaskOtherInfoJsonByTaskID *)aParameters ;
- (void)GetTaskOtherInfoJsonByTaskIDAsyncUsingParameters:(ForAndroid_GetTaskOtherInfoJsonByTaskID *)aParameters  delegate:(id<ForAndroidSoap12BindingResponseDelegate>)responseDelegate;
- (ForAndroidSoap12BindingResponse *)GetCustomCarInfoUsingParameters:(ForAndroid_GetCustomCarInfo *)aParameters ;
- (void)GetCustomCarInfoAsyncUsingParameters:(ForAndroid_GetCustomCarInfo *)aParameters  delegate:(id<ForAndroidSoap12BindingResponseDelegate>)responseDelegate;
@end
@interface ForAndroidSoap12BindingOperation : NSOperation {
	ForAndroidSoap12Binding *binding;
	ForAndroidSoap12BindingResponse *response;
	id<ForAndroidSoap12BindingResponseDelegate> delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (retain) ForAndroidSoap12Binding *binding;
@property (readonly) ForAndroidSoap12BindingResponse *response;
@property (nonatomic, assign) id<ForAndroidSoap12BindingResponseDelegate> delegate;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) NSURLConnection *urlConnection;
- (id)initWithBinding:(ForAndroidSoap12Binding *)aBinding delegate:(id<ForAndroidSoap12BindingResponseDelegate>)aDelegate;
@end
@interface ForAndroidSoap12Binding_LoginAndroid : ForAndroidSoap12BindingOperation {
	ForAndroid_LoginAndroid * parameters;
}
@property (retain) ForAndroid_LoginAndroid * parameters;
- (id)initWithBinding:(ForAndroidSoap12Binding *)aBinding delegate:(id<ForAndroidSoap12BindingResponseDelegate>)aDelegate
	parameters:(ForAndroid_LoginAndroid *)aParameters
;
@end
@interface ForAndroidSoap12Binding_GetNews : ForAndroidSoap12BindingOperation {
	ForAndroid_GetNews * parameters;
}
@property (retain) ForAndroid_GetNews * parameters;
- (id)initWithBinding:(ForAndroidSoap12Binding *)aBinding delegate:(id<ForAndroidSoap12BindingResponseDelegate>)aDelegate
	parameters:(ForAndroid_GetNews *)aParameters
;
@end
@interface ForAndroidSoap12Binding_GetNewsList : ForAndroidSoap12BindingOperation {
	ForAndroid_GetNewsList * parameters;
}
@property (retain) ForAndroid_GetNewsList * parameters;
- (id)initWithBinding:(ForAndroidSoap12Binding *)aBinding delegate:(id<ForAndroidSoap12BindingResponseDelegate>)aDelegate
	parameters:(ForAndroid_GetNewsList *)aParameters
;
@end
@interface ForAndroidSoap12Binding_AddFeedBack : ForAndroidSoap12BindingOperation {
	ForAndroid_AddFeedBack * parameters;
}
@property (retain) ForAndroid_AddFeedBack * parameters;
- (id)initWithBinding:(ForAndroidSoap12Binding *)aBinding delegate:(id<ForAndroidSoap12BindingResponseDelegate>)aDelegate
	parameters:(ForAndroid_AddFeedBack *)aParameters
;
@end
@interface ForAndroidSoap12Binding_CompleteAll : ForAndroidSoap12BindingOperation {
	ForAndroid_CompleteAll * parameters;
}
@property (retain) ForAndroid_CompleteAll * parameters;
- (id)initWithBinding:(ForAndroidSoap12Binding *)aBinding delegate:(id<ForAndroidSoap12BindingResponseDelegate>)aDelegate
	parameters:(ForAndroid_CompleteAll *)aParameters
;
@end
@interface ForAndroidSoap12Binding_GetCompletePageList : ForAndroidSoap12BindingOperation {
	ForAndroid_GetCompletePageList * parameters;
}
@property (retain) ForAndroid_GetCompletePageList * parameters;
- (id)initWithBinding:(ForAndroidSoap12Binding *)aBinding delegate:(id<ForAndroidSoap12BindingResponseDelegate>)aDelegate
	parameters:(ForAndroid_GetCompletePageList *)aParameters
;
@end
@interface ForAndroidSoap12Binding_SearchAccont : ForAndroidSoap12BindingOperation {
	ForAndroid_SearchAccont * parameters;
}
@property (retain) ForAndroid_SearchAccont * parameters;
- (id)initWithBinding:(ForAndroidSoap12Binding *)aBinding delegate:(id<ForAndroidSoap12BindingResponseDelegate>)aDelegate
	parameters:(ForAndroid_SearchAccont *)aParameters
;
@end
@interface ForAndroidSoap12Binding_AddOrUpdateCarInfo : ForAndroidSoap12BindingOperation {
	ForAndroid_AddOrUpdateCarInfo * parameters;
}
@property (retain) ForAndroid_AddOrUpdateCarInfo * parameters;
- (id)initWithBinding:(ForAndroidSoap12Binding *)aBinding delegate:(id<ForAndroidSoap12BindingResponseDelegate>)aDelegate
	parameters:(ForAndroid_AddOrUpdateCarInfo *)aParameters
;
@end
@interface ForAndroidSoap12Binding_AddOtherInfo : ForAndroidSoap12BindingOperation {
	ForAndroid_AddOtherInfo * parameters;
}
@property (retain) ForAndroid_AddOtherInfo * parameters;
- (id)initWithBinding:(ForAndroidSoap12Binding *)aBinding delegate:(id<ForAndroidSoap12BindingResponseDelegate>)aDelegate
	parameters:(ForAndroid_AddOtherInfo *)aParameters
;
@end
@interface ForAndroidSoap12Binding_AddOrUpdateCarAttachment : ForAndroidSoap12BindingOperation {
	ForAndroid_AddOrUpdateCarAttachment * parameters;
}
@property (retain) ForAndroid_AddOrUpdateCarAttachment * parameters;
- (id)initWithBinding:(ForAndroidSoap12Binding *)aBinding delegate:(id<ForAndroidSoap12BindingResponseDelegate>)aDelegate
	parameters:(ForAndroid_AddOrUpdateCarAttachment *)aParameters
;
@end
@interface ForAndroidSoap12Binding_AddOrUpdateCarCondition : ForAndroidSoap12BindingOperation {
	ForAndroid_AddOrUpdateCarCondition * parameters;
}
@property (retain) ForAndroid_AddOrUpdateCarCondition * parameters;
- (id)initWithBinding:(ForAndroidSoap12Binding *)aBinding delegate:(id<ForAndroidSoap12BindingResponseDelegate>)aDelegate
	parameters:(ForAndroid_AddOrUpdateCarCondition *)aParameters
;
@end
@interface ForAndroidSoap12Binding_AddDiagData : ForAndroidSoap12BindingOperation {
	ForAndroid_AddDiagData * parameters;
}
@property (retain) ForAndroid_AddDiagData * parameters;
- (id)initWithBinding:(ForAndroidSoap12Binding *)aBinding delegate:(id<ForAndroidSoap12BindingResponseDelegate>)aDelegate
	parameters:(ForAndroid_AddDiagData *)aParameters
;
@end
@interface ForAndroidSoap12Binding_AddupdateCarFileInfo : ForAndroidSoap12BindingOperation {
	ForAndroid_AddupdateCarFileInfo * parameters;
}
@property (retain) ForAndroid_AddupdateCarFileInfo * parameters;
- (id)initWithBinding:(ForAndroidSoap12Binding *)aBinding delegate:(id<ForAndroidSoap12BindingResponseDelegate>)aDelegate
	parameters:(ForAndroid_AddupdateCarFileInfo *)aParameters
;
@end
@interface ForAndroidSoap12Binding_AddupdateDetectlist : ForAndroidSoap12BindingOperation {
	ForAndroid_AddupdateDetectlist * parameters;
}
@property (retain) ForAndroid_AddupdateDetectlist * parameters;
- (id)initWithBinding:(ForAndroidSoap12Binding *)aBinding delegate:(id<ForAndroidSoap12BindingResponseDelegate>)aDelegate
	parameters:(ForAndroid_AddupdateDetectlist *)aParameters
;
@end
@interface ForAndroidSoap12Binding_AddupdateJmDetectlist : ForAndroidSoap12BindingOperation {
	ForAndroid_AddupdateJmDetectlist * parameters;
}
@property (retain) ForAndroid_AddupdateJmDetectlist * parameters;
- (id)initWithBinding:(ForAndroidSoap12Binding *)aBinding delegate:(id<ForAndroidSoap12BindingResponseDelegate>)aDelegate
	parameters:(ForAndroid_AddupdateJmDetectlist *)aParameters
;
@end
@interface ForAndroidSoap12Binding_ForAndroidComplete : ForAndroidSoap12BindingOperation {
	ForAndroid_ForAndroidComplete * parameters;
}
@property (retain) ForAndroid_ForAndroidComplete * parameters;
- (id)initWithBinding:(ForAndroidSoap12Binding *)aBinding delegate:(id<ForAndroidSoap12BindingResponseDelegate>)aDelegate
	parameters:(ForAndroid_ForAndroidComplete *)aParameters
;
@end
@interface ForAndroidSoap12Binding_GetCarId : ForAndroidSoap12BindingOperation {
	ForAndroid_GetCarId * parameters;
}
@property (retain) ForAndroid_GetCarId * parameters;
- (id)initWithBinding:(ForAndroidSoap12Binding *)aBinding delegate:(id<ForAndroidSoap12BindingResponseDelegate>)aDelegate
	parameters:(ForAndroid_GetCarId *)aParameters
;
@end
@interface ForAndroidSoap12Binding_GetByVin : ForAndroidSoap12BindingOperation {
	ForAndroid_GetByVin * parameters;
}
@property (retain) ForAndroid_GetByVin * parameters;
- (id)initWithBinding:(ForAndroidSoap12Binding *)aBinding delegate:(id<ForAndroidSoap12BindingResponseDelegate>)aDelegate
	parameters:(ForAndroid_GetByVin *)aParameters
;
@end
@interface ForAndroidSoap12Binding_GetBycarbiscid : ForAndroidSoap12BindingOperation {
	ForAndroid_GetBycarbiscid * parameters;
}
@property (retain) ForAndroid_GetBycarbiscid * parameters;
- (id)initWithBinding:(ForAndroidSoap12Binding *)aBinding delegate:(id<ForAndroidSoap12BindingResponseDelegate>)aDelegate
	parameters:(ForAndroid_GetBycarbiscid *)aParameters
;
@end
@interface ForAndroidSoap12Binding_GetSixSuanfa : ForAndroidSoap12BindingOperation {
	ForAndroid_GetSixSuanfa * parameters;
}
@property (retain) ForAndroid_GetSixSuanfa * parameters;
- (id)initWithBinding:(ForAndroidSoap12Binding *)aBinding delegate:(id<ForAndroidSoap12BindingResponseDelegate>)aDelegate
	parameters:(ForAndroid_GetSixSuanfa *)aParameters
;
@end
@interface ForAndroidSoap12Binding_SearchCarName : ForAndroidSoap12BindingOperation {
	ForAndroid_SearchCarName * parameters;
}
@property (retain) ForAndroid_SearchCarName * parameters;
- (id)initWithBinding:(ForAndroidSoap12Binding *)aBinding delegate:(id<ForAndroidSoap12BindingResponseDelegate>)aDelegate
	parameters:(ForAndroid_SearchCarName *)aParameters
;
@end
@interface ForAndroidSoap12Binding_GetDYCWCarInfo : ForAndroidSoap12BindingOperation {
	ForAndroid_GetDYCWCarInfo * parameters;
}
@property (retain) ForAndroid_GetDYCWCarInfo * parameters;
- (id)initWithBinding:(ForAndroidSoap12Binding *)aBinding delegate:(id<ForAndroidSoap12BindingResponseDelegate>)aDelegate
	parameters:(ForAndroid_GetDYCWCarInfo *)aParameters
;
@end
@interface ForAndroidSoap12Binding_AddOrUpdateTaskOtherInfo : ForAndroidSoap12BindingOperation {
	ForAndroid_AddOrUpdateTaskOtherInfo * parameters;
}
@property (retain) ForAndroid_AddOrUpdateTaskOtherInfo * parameters;
- (id)initWithBinding:(ForAndroidSoap12Binding *)aBinding delegate:(id<ForAndroidSoap12BindingResponseDelegate>)aDelegate
	parameters:(ForAndroid_AddOrUpdateTaskOtherInfo *)aParameters
;
@end
@interface ForAndroidSoap12Binding_GetTaskOtherInfoJsonByTaskID : ForAndroidSoap12BindingOperation {
	ForAndroid_GetTaskOtherInfoJsonByTaskID * parameters;
}
@property (retain) ForAndroid_GetTaskOtherInfoJsonByTaskID * parameters;
- (id)initWithBinding:(ForAndroidSoap12Binding *)aBinding delegate:(id<ForAndroidSoap12BindingResponseDelegate>)aDelegate
	parameters:(ForAndroid_GetTaskOtherInfoJsonByTaskID *)aParameters
;
@end
@interface ForAndroidSoap12Binding_GetCustomCarInfo : ForAndroidSoap12BindingOperation {
	ForAndroid_GetCustomCarInfo * parameters;
}
@property (retain) ForAndroid_GetCustomCarInfo * parameters;
- (id)initWithBinding:(ForAndroidSoap12Binding *)aBinding delegate:(id<ForAndroidSoap12BindingResponseDelegate>)aDelegate
	parameters:(ForAndroid_GetCustomCarInfo *)aParameters
;
@end
@interface ForAndroidSoap12Binding_envelope : NSObject {
}
+ (ForAndroidSoap12Binding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface ForAndroidSoap12BindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (retain) NSArray *headers;
@property (retain) NSArray *bodyParts;
@property (retain) NSError *error;
@end
