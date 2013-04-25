#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class LocalTime_LocalTimeByZipCode;
@class LocalTime_LocalTimeByZipCodeResponse;
@interface LocalTime_LocalTimeByZipCode : NSObject {
	
/* elements */
	NSString * ZipCode;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (LocalTime_LocalTimeByZipCode *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * ZipCode;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface LocalTime_LocalTimeByZipCodeResponse : NSObject {
	
/* elements */
	NSString * LocalTimeByZipCodeResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (LocalTime_LocalTimeByZipCodeResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * LocalTimeByZipCodeResult;
/* attributes */
- (NSDictionary *)attributes;
@end
/* Cookies handling provided by http://en.wikibooks.org/wiki/Programming:WebObjects/Web_Services/Web_Service_Provider */
#import <libxml/parser.h>
#import "xs.h"
#import "LocalTime.h"
@class LocalTimeSoapBinding;
@class LocalTimeSoap12Binding;
@interface LocalTime : NSObject {
	
}
+ (LocalTimeSoapBinding *)LocalTimeSoapBinding;
+ (LocalTimeSoap12Binding *)LocalTimeSoap12Binding;
@end
@class LocalTimeSoapBindingResponse;
@class LocalTimeSoapBindingOperation;
@protocol LocalTimeSoapBindingResponseDelegate <NSObject>
- (void) operation:(LocalTimeSoapBindingOperation *)operation completedWithResponse:(LocalTimeSoapBindingResponse *)response;
@end
@interface LocalTimeSoapBinding : NSObject <LocalTimeSoapBindingResponseDelegate> {
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
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(LocalTimeSoapBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (LocalTimeSoapBindingResponse *)LocalTimeByZipCodeUsingParameters:(LocalTime_LocalTimeByZipCode *)aParameters ;
- (void)LocalTimeByZipCodeAsyncUsingParameters:(LocalTime_LocalTimeByZipCode *)aParameters  delegate:(id<LocalTimeSoapBindingResponseDelegate>)responseDelegate;
@end
@interface LocalTimeSoapBindingOperation : NSOperation {
	LocalTimeSoapBinding *binding;
	LocalTimeSoapBindingResponse *response;
	id<LocalTimeSoapBindingResponseDelegate> delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (retain) LocalTimeSoapBinding *binding;
@property (readonly) LocalTimeSoapBindingResponse *response;
@property (nonatomic, assign) id<LocalTimeSoapBindingResponseDelegate> delegate;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) NSURLConnection *urlConnection;
- (id)initWithBinding:(LocalTimeSoapBinding *)aBinding delegate:(id<LocalTimeSoapBindingResponseDelegate>)aDelegate;
@end
@interface LocalTimeSoapBinding_LocalTimeByZipCode : LocalTimeSoapBindingOperation {
	LocalTime_LocalTimeByZipCode * parameters;
}
@property (retain) LocalTime_LocalTimeByZipCode * parameters;
- (id)initWithBinding:(LocalTimeSoapBinding *)aBinding delegate:(id<LocalTimeSoapBindingResponseDelegate>)aDelegate
	parameters:(LocalTime_LocalTimeByZipCode *)aParameters
;
@end
@interface LocalTimeSoapBinding_envelope : NSObject {
}
+ (LocalTimeSoapBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface LocalTimeSoapBindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (retain) NSArray *headers;
@property (retain) NSArray *bodyParts;
@property (retain) NSError *error;
@end
@class LocalTimeSoap12BindingResponse;
@class LocalTimeSoap12BindingOperation;
@protocol LocalTimeSoap12BindingResponseDelegate <NSObject>
- (void) operation:(LocalTimeSoap12BindingOperation *)operation completedWithResponse:(LocalTimeSoap12BindingResponse *)response;
@end
@interface LocalTimeSoap12Binding : NSObject <LocalTimeSoap12BindingResponseDelegate> {
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
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(LocalTimeSoap12BindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (LocalTimeSoap12BindingResponse *)LocalTimeByZipCodeUsingParameters:(LocalTime_LocalTimeByZipCode *)aParameters ;
- (void)LocalTimeByZipCodeAsyncUsingParameters:(LocalTime_LocalTimeByZipCode *)aParameters  delegate:(id<LocalTimeSoap12BindingResponseDelegate>)responseDelegate;
@end
@interface LocalTimeSoap12BindingOperation : NSOperation {
	LocalTimeSoap12Binding *binding;
	LocalTimeSoap12BindingResponse *response;
	id<LocalTimeSoap12BindingResponseDelegate> delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (retain) LocalTimeSoap12Binding *binding;
@property (readonly) LocalTimeSoap12BindingResponse *response;
@property (nonatomic, assign) id<LocalTimeSoap12BindingResponseDelegate> delegate;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) NSURLConnection *urlConnection;
- (id)initWithBinding:(LocalTimeSoap12Binding *)aBinding delegate:(id<LocalTimeSoap12BindingResponseDelegate>)aDelegate;
@end
@interface LocalTimeSoap12Binding_LocalTimeByZipCode : LocalTimeSoap12BindingOperation {
	LocalTime_LocalTimeByZipCode * parameters;
}
@property (retain) LocalTime_LocalTimeByZipCode * parameters;
- (id)initWithBinding:(LocalTimeSoap12Binding *)aBinding delegate:(id<LocalTimeSoap12BindingResponseDelegate>)aDelegate
	parameters:(LocalTime_LocalTimeByZipCode *)aParameters
;
@end
@interface LocalTimeSoap12Binding_envelope : NSObject {
}
+ (LocalTimeSoap12Binding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface LocalTimeSoap12BindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (retain) NSArray *headers;
@property (retain) NSArray *bodyParts;
@property (retain) NSError *error;
@end
