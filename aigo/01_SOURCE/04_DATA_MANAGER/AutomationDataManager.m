//
//  AutomationDataManager.m
//  trongvm
//
//  Created by Phan Ba Minh on 6/15/12.
//  Copyright (c) 2012 kidbaw. All rights reserved.
//

#import "AutomationDataManager.h"
#import "KardsDataManager.h"
#import "UserDataManager.h"
#import "AppViewController.h"
#import "SBJSON.h"

@implementation AutomationDataManager
- (id)init
{
    self = [super init];
    if (self) {
        _APIRequester = [APIRequester new];
        _APIRequesterKardBuilder = [APIRequester new];
        
        _automationDataManagerStep = enumAutomationDataManagerStep_UpdateUserLocation;
        
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        _locationManager.distanceFilter = 10;
        
        if (![UserDataManager Shared].userLocation) {
            [UserDataManager Shared].userLocation = [[CLLocation alloc] initWithLatitude:STRING_LOCATION_LATITUDE_DEFAULT.doubleValue longitude:STRING_LOCATION_LONGTITUDE_DEFAULT.doubleValue];
        }
        
//        [self updateUserLocationService];
        
        _pageIndexTemplate = 1;
        _pageIndexGraphic = 1;
        _pageIndexMeKards = 1;
        _locationState = enumLocationState_Stop;
        _locationTimeOut = [NSDate date];
        
        _alertLocationService = [[UIAlertView alloc] initWithTitle:@"" message:STRING_ALERT_MESSAGE_TURN_ON_LOCATION_SERVICE delegate:self cancelButtonTitle:STRING_ALERT_OK otherButtonTitles:nil];
        _alertRequestFailed = [[UIAlertView alloc] initWithTitle:STRING_ALERT_CONNECTION_ERROR_TITLE message:STRING_ALERT_CONNECTION_ERROR delegate:self cancelButtonTitle:STRING_ALERT_OK otherButtonTitles:nil];  
    }
    return self;
}

- (void)dealloc
{
}

#pragma mark - Actions

- (void)cancelRequest {
    _delegate = nil;
    [_APIRequester cancelRequest];
    _automationDataManagerStep = enumAutomationDataManagerStep_CheckingForNext;
}

- (void)reloadAllDataWithDataIsReady:(enumAutomationDataIsReady)isReady andDelegate:(id<AutomationDataManagerProtocol>)delegate{
    NSLog(@"reloadAllDataWithDataIsReady: %i, %@", isReady, [[delegate class] description]);
    
    if (isReady == enumAutomationDataIsReady_ForHome_BeforeEntering || isReady == enumAutomationDataIsReady_ForRegister_CreatingAccount) {
        _dataIsReady = isReady;
        _delegate = delegate;
        _automationDataManagerStep = enumAutomationDataManagerStep_UpdateUserLocation;
    }
    else if (isReady == enumAutomationDataIsReady_ForKonnect_UpdateUserLocation) {
//        [self updateUserLocationService];
        
        _dataIsReady = isReady;
        _delegate = delegate;
        _automationDataManagerStep = enumAutomationDataManagerStep_UpdateUserLocation;
    }
    else {
        _dataIsReady = isReady;
        _delegate = delegate;
        _automationDataManagerStep = enumAutomationDataManagerStep_GetUserProfile;
    }
}

- (void)requestAPIWithAutomationDataManagerStep:(enumAutomationDataManagerStep)type {
    switch (type) {
        case enumAutomationDataManagerStep_GetMEKards:
        {
            NSString *strURL = [NSString stringWithFormat:@"%@/%i/%i/%i", STRING_REQUEST_URL_KARDS_GET_ME, [UserDataManager Shared].userID, _pageIndexMeKards, INT_DEFAULT_PAGE_SIZE];// MinhPB 2012/09/19
            [_APIRequester requestWithType:ENUM_API_REQUEST_TYPE_KARDS_GET_ME andRootURL:strURL andPostMethodKind:NO andParams:nil andDelegate:self];
            break;
        }
        case enumAutomationDataManagerStep_GetMyDeals:
        {
            NSString *url = [NSString stringWithFormat:@"%@/%i/%i/%i/%f/%f/mile", STRING_REQUEST_URL_DEAL_GET_MY, [UserDataManager Shared].userID,1, 100, [UserDataManager Shared].userLocation.coordinate.latitude, [UserDataManager Shared].userLocation.coordinate.longitude];
            [_APIRequester requestWithType:ENUM_API_REQUEST_TYPE_DEAL_GET_MY andRootURL:url andPostMethodKind:NO andParams:nil andDelegate:self];
        }
            break;
        case enumAutomationDataManagerStep_UpdateUserLocation:
        {
//             /session/update/{fkUser}/{latitude}/{longitude}/{sessionID}
//            /session/lacation/setting
//            @RequestParam Integer fkUser,@RequestParam String latitude,@RequestParam String longitude
            
//            NSMutableDictionary  *params = [NSMutableDictionary new];
//            [params setObject:[NSString stringWithFormat:@"%i", [UserDataManager Shared].userID] forKey:STRING_REQUEST_KEY_FK_USER];
//            [params setObject:[NSString stringWithFormat:@"%f", [UserDataManager Shared].userLocation.coordinate.latitude] forKey:STRING_REQUEST_KEY_LATITUDE];
//            [params setObject:[NSString stringWithFormat:@"%f", [UserDataManager Shared].userLocation.coordinate.longitude] forKey:STRING_REQUEST_KEY_LONGITUDE];
//            
//            [[APIRequester Shared] requestWithType:ENUM_API_REQUEST_TYPE_USER_UPDATE_LOCATION andRootURL:STRING_REQUEST_URL_USER_UPDATE_LOCATION andPostMethodKind:YES andParams:params andDelegate:self];
//            [params release];
            
            [self startUpdateLocationService];
            BOOL gpsIsAllowed = NO;
            if (CLLocationManager.authorizationStatus == kCLAuthorizationStatusRestricted || CLLocationManager.authorizationStatus == kCLAuthorizationStatusDenied)
            {
                gpsIsAllowed = NO;
            }
            else {
                gpsIsAllowed = YES;
            }
            
            NSMutableDictionary  *params = [NSMutableDictionary new];
            [params setObject:[NSString stringWithFormat:@"%i", [UserDataManager Shared].userID] forKey:STRING_REQUEST_KEY_FK_USER];
            [params setObject:[NSString stringWithFormat:@"%f", [UserDataManager Shared].userLocation.coordinate.latitude] forKey:STRING_REQUEST_KEY_LATITUDE];
            [params setObject:[NSString stringWithFormat:@"%f", [UserDataManager Shared].userLocation.coordinate.longitude] forKey:STRING_REQUEST_KEY_LONGITUDE];
            [params setObject:[NSString stringWithFormat:@"%@", [UserDataManager Shared].sessionID] forKey:STRING_REQUEST_KEY_SESSION];
            [params setObject:[NSString stringWithFormat:@"%i", gpsIsAllowed] forKey:STRING_REQUEST_KEY_GPS];
            
            [[APIRequester Shared] requestWithType:ENUM_API_REQUEST_TYPE_USER_UPDATE_LOCATION andRootURL:STRING_REQUEST_URL_USER_UPDATE_LOCATION_AND_GPS andPostMethodKind:YES andParams:params andDelegate:self];
            break;
        }
        case enumAutomationDataManagerStep_GetUserProfile:
        {
//             /accounts/profile/default/{idUsers}
            
            [[APIRequester Shared] requestWithType:ENUM_API_REQUEST_TYPE_USER_GET_PROFILE andRootURL:[NSString stringWithFormat:@"%@/%i", STRING_REQUEST_URL_USER_GET_PROFILE, [UserDataManager Shared].userID] andPostMethodKind:NO andParams:nil andDelegate:self];
            break;
        }
        case enumAutomationDataManagerStep_GetBannerAds:
        {
//             /accounts/kard/seedpartner/user/ads
            
            [[APIRequester Shared] requestWithType:ENUM_API_REQUEST_TYPE_USER_GET_BANNER_ADS andRootURL:[NSString stringWithFormat:@"%@", STRING_REQUEST_URL_BANNER_ADS] andPostMethodKind:NO andParams:nil andDelegate:self];
            break;
        }
//        case enumAutomationDataManagerStep_UpdateUserOnlineStatus:
//        {
////             /session/update/{fkUser}/{latitude}/{longitude}/{sessionID}
////            /session/lacation/setting
////            @RequestParam Integer fkUser,@RequestParam String latitude,@RequestParam String longitude
//            
//            NSMutableDictionary  *params = [NSMutableDictionary new];
//            [params setObject:[NSString stringWithFormat:@"%i", [UserDataManager Shared].userID] forKey:STRING_REQUEST_KEY_FK_USER];
//            [params setObject:[NSString stringWithFormat:@"%f", [UserDataManager Shared].userLocation.coordinate.latitude] forKey:STRING_REQUEST_KEY_LATITUDE];
//            [params setObject:[NSString stringWithFormat:@"%f", [UserDataManager Shared].userLocation.coordinate.longitude] forKey:STRING_REQUEST_KEY_LONGITUDE];
//            [params setObject:[NSString stringWithFormat:@"%@", [UserDataManager Shared].sessionID] forKey:STRING_REQUEST_KEY_SESSION_ID];
//            
//            [[APIRequester Shared] requestWithType:ENUM_API_REQUEST_TYPE_USER_UPDATE_ONLINE_STATUS andRootURL:STRING_REQUEST_URL_USER_UPDATE_ONLINE_STATUS andPostMethodKind:YES andParams:params andDelegate:self];
//            [params release];
//            break;
//        }
        default:
            break;
    }
}

- (void)update {
    if (![UserDataManager Shared].loginStatus || _dataIsReady == enumAutomationDataIsReady_Invalid) {
//        NSLog(@"AutomationDataManager: can not load user's data automatically");
        _dataIsReady = enumAutomationDataIsReady_Invalid;
        return;
    }
    
    switch (_automationDataManagerStep) {
        case enumAutomationDataManagerStep_UpdateUserLocation:
        {
            _requestTimer =  CFAbsoluteTimeGetCurrent();
            _checkingNetworkTimer =  CFAbsoluteTimeGetCurrent();
            
            [self requestAPIWithAutomationDataManagerStep:_automationDataManagerStep];
            _automationDataManagerStep = enumAutomationDataManagerStep_UpdateUserLocation_Waiting;
            break;
        }
        case enumAutomationDataManagerStep_UpdateUserLocation_Failed:
        {
            _automationDataManagerStep = enumAutomationDataManagerStep_UpdateUserLocation;
            break;
        }
        case enumAutomationDataManagerStep_UpdateUserLocation_Finished:
        {
            if (_dataIsReady == enumAutomationDataIsReady_ForKonnect_UpdateUserLocation) {
                // MinhPB 2012/11/08
//                _automationDataManagerStep = enumAutomationDataManagerStep_GetUserProfile;
                _automationDataManagerStep = enumAutomationDataManagerStep_GetMEKards;
            }
            else if (_dataIsReady == enumAutomationDataIsReady_ForAutomation) {
                _automationDataManagerStep = enumAutomationDataManagerStep_CheckingForNext;
            }
            else {
                _automationDataManagerStep = enumAutomationDataManagerStep_GetMEKards;
            }
            break;
        }
        case enumAutomationDataManagerStep_GetMEKards:
        {
            KardsCategoryData *MECategory = [[KardsDataManager kardsShared] getMECategory];
            if (!MECategory) {
                KardsCategoryData *kardsCategory = [[KardsCategoryData alloc] initWithKardsName:STRING_NAME_DECK_KARDS_ME andKardsID:STRING_NAME_DECK_KARDS_ME andKardsSmallAvatar:nil];
                kardsCategory.isMine = enumIsDataMine_isMine;
                kardsCategory.isLocalCopyType = enumIsLocalCopyType_Copy;
                kardsCategory.kardsSmallAvatarURL = [UserDataManager Shared].avatarSmallURL;
                kardsCategory.kardsMediumAvatarURL = [UserDataManager Shared].avatarSmallURL;
                kardsCategory.kardsLargeAvatarURL = [UserDataManager Shared].avatarSmallURL;
                [[KardsDataManager kardsShared] addCategory:kardsCategory];
                [self requestAPIWithAutomationDataManagerStep:_automationDataManagerStep];
                _automationDataManagerStep = enumAutomationDataManagerStep_GetMEKards_Waiting;
            }
            else {
                // MinhPB 2012/11/08, check for the me kards
                if (MECategory.categoryArray.count == 0) {
                    [self requestAPIWithAutomationDataManagerStep:_automationDataManagerStep];
                    _automationDataManagerStep = enumAutomationDataManagerStep_GetMEKards_Waiting;
                }
                else {
                    //_automationDataManagerStep = enumAutomationDataManagerStep_GetMyDeals;
                    _automationDataManagerStep = enumAutomationDataManagerStep_GetUserProfile;
                }
            }
            break;
        }
        case enumAutomationDataManagerStep_GetMEKards_Failed:
        {
            _automationDataManagerStep = enumAutomationDataManagerStep_GetMEKards;
            break;
        }
        case enumAutomationDataManagerStep_GetMEKards_Finished:
        {
            //_automationDataManagerStep = enumAutomationDataManagerStep_GetMyDeals;
            _automationDataManagerStep = enumAutomationDataManagerStep_GetUserProfile;
            break;
        }
        /*case enumAutomationDataManagerStep_GetMyDeals:
        {
            KardsCategoryData *dealCategory = [[KardsDataManager kardsShared] getDealCategory];
            if (!dealCategory) {
                KardsCategoryData *myDealsCategory = [[KardsCategoryData alloc] initWithKardsName:STRING_NAME_DECK_MY_DEAL andKardsID:STRING_NAME_DECK_MY_DEAL andKardsSmallAvatar:nil];
                myDealsCategory.isMine = enumIsDataMine_isMyDeal;
                myDealsCategory.isLocalCopyType = enumIsLocalCopyType_Copy;
                myDealsCategory.kardsSmallAvatarURL = [UserDataManager Shared].dealSmallURL;
                myDealsCategory.kardsMediumAvatarURL = [UserDataManager Shared].dealSmallURL;
                myDealsCategory.kardsLargeAvatarURL = [UserDataManager Shared].dealSmallURL;
                myDealsCategory.merchantName = [UserDataManager Shared].myDealMerchant;
                myDealsCategory.dealHeadLine = [UserDataManager Shared].myDealHeadline;
                myDealsCategory.dealPricevalue = [UserDataManager Shared].myDealPrice;
                [[KardsDataManager kardsShared] addCategory:myDealsCategory];
                
                [self requestAPIWithAutomationDataManagerStep:_automationDataManagerStep];
                _automationDataManagerStep = enumAutomationDataManagerStep_GetMyDeals_Waiting;
            }else
                _automationDataManagerStep = enumAutomationDataManagerStep_GetUserProfile;
        }
            break;
        case enumAutomationDataManagerStep_GetMyDeals_Failed:
        {
            _automationDataManagerStep = enumAutomationDataManagerStep_GetMyDeals;
        }break;
        case enumAutomationDataManagerStep_GetMyDeals_Finished:
        {
            _automationDataManagerStep = enumAutomationDataManagerStep_GetUserProfile;
        }break;*/
//        case enumAutomationDataManagerStep_UpdateUserOnlineStatus:
//        {
//            [self requestAPIWithAutomationDataManagerStep:_automationDataManagerStep];
//            _automationDataManagerStep = enumAutomationDataManagerStep_UpdateUserOnlineStatus_Waiting;
//            break;
//        }
//        case enumAutomationDataManagerStep_UpdateUserOnlineStatus_Failed:
//        {
//            _automationDataManagerStep = enumAutomationDataManagerStep_UpdateUserOnlineStatus;
//            break;
//        }
//        case enumAutomationDataManagerStep_UpdateUserOnlineStatus_Finished:
//        {
//            if (_dataIsReady == enumAutomationDataIsReady_ForKonnect_UpdateUserLocation) {
//                if ([_delegate respondsToSelector:@selector(didRequestFinishedWithDataIsReady:)]) {
//                    [_delegate didRequestFinishedWithDataIsReady:_dataIsReady];
//                    _delegate = nil;
//                }
//                
//                _automationDataManagerStep = enumAutomationDataManagerStep_CheckingForNext;
//            }
//            else {
//                _automationDataManagerStep = enumAutomationDataManagerStep_GetUserProfile;
//            }
//            break;
//        }
        case enumAutomationDataManagerStep_GetUserProfile:
        {
            [self requestAPIWithAutomationDataManagerStep:_automationDataManagerStep];
            _automationDataManagerStep = enumAutomationDataManagerStep_GetUserProfile_Waiting;
            break;
        }
        case enumAutomationDataManagerStep_GetUserProfile_Failed:
        {
            if ([_delegate respondsToSelector:@selector(didRequestFailedWithDataIsReady:)]) {
                [_delegate didRequestFailedWithDataIsReady:_dataIsReady];
                _delegate = nil;
            }
            
            _automationDataManagerStep = enumAutomationDataManagerStep_GetUserProfile;
            break;
        }
        case enumAutomationDataManagerStep_GetUserProfile_Finished:
        {
            
            if (_dataIsReady == enumAutomationDataIsReady_ForHome_BeforeEntering || _dataIsReady == enumAutomationDataIsReady_ForRegister_CreatingAccount) {
                _automationDataManagerStep = enumAutomationDataManagerStep_GetBannerAds;
            }
            else {
                if ([_delegate respondsToSelector:@selector(didRequestFinishedWithDataIsReady:)]) {
                    [_delegate didRequestFinishedWithDataIsReady:_dataIsReady];
                    _delegate = nil;
                }
                
                _automationDataManagerStep = enumAutomationDataManagerStep_GetBannerAds;
            }
            break;
        }
        case enumAutomationDataManagerStep_GetBannerAds:
        {
            [self requestAPIWithAutomationDataManagerStep:_automationDataManagerStep];
            _automationDataManagerStep = enumAutomationDataManagerStep_GetBannerAds_Waiting;
            break;
        }
        case enumAutomationDataManagerStep_GetBannerAds_Failed:
        {
            if ([_delegate respondsToSelector:@selector(didRequestFailedWithDataIsReady:)]) {
                [_delegate didRequestFailedWithDataIsReady:_dataIsReady];
                _delegate = nil;
            }
            _automationDataManagerStep = enumAutomationDataManagerStep_GetBannerAds;
        }
        case enumAutomationDataManagerStep_GetBannerAds_Finished:
        {
            if ([_delegate respondsToSelector:@selector(didRequestFinishedWithDataIsReady:)]) {
                [_delegate didRequestFinishedWithDataIsReady:_dataIsReady];
                _delegate = nil;
            }
            
            _automationDataManagerStep = enumAutomationDataManagerStep_CheckingForNext;
            break;
        }
        case enumAutomationDataManagerStep_CheckingForNext:
        {
            if (CFAbsoluteTimeGetCurrent() - _requestTimer > TIMER_AUTOMATION_UPDATING) {
                _automationDataManagerStep = enumAutomationDataManagerStep_UpdateUserLocation;
                _dataIsReady = enumAutomationDataIsReady_ForAutomation;
            }
            break;
        }
        case enumAutomationDataManagerStep_CheckingForNetwork:
        {
            if (([ASIHTTPRequest isNetworkReachable] || CFAbsoluteTimeGetCurrent() - _checkingNetworkTimer > TIMER_AUTOMATION_CHECKING_NETWORK) && !_alertCheckingNetwork_Showing) {
                _checkingNetworkTimer =  CFAbsoluteTimeGetCurrent();
                _dataIsReady = enumAutomationDataIsReady_ForAutomation;
                _automationDataManagerStep = _previousStep;
            }
            break;
        }
        default:
            break;
    }
}

#pragma mark - APIRequesterProtocol

- (void)requestFinished:(ASIHTTPRequest *)request andType:(ENUM_API_REQUEST_TYPE)type {
    NSLog(@"AutomationDataManager requestFinished: %@", [request responseString]);
    
    NSError *error;
    SBJSON *sbJSON = [SBJSON new];
    
    if (![sbJSON objectWithString:[request responseString] error:&error] || request.responseStatusCode != 200 || !request) {
//        if (![ASIHTTPRequest isNetworkReachable]) {
//            ALERT(STRING_ALERT_CONNECTION_ERROR_TITLE, STRING_ALERT_SERVER_ERROR);
//        }
        
//        // For now: support compatiable for all servers about API get banner, we will ignore the error so that we use default banner come with the app.
//        if (type != ENUM_API_REQUEST_TYPE_USER_GET_BANNER_ADS) {
//            
//            ALERT(STRING_ALERT_CONNECTION_ERROR_TITLE, STRING_ALERT_SERVER_ERROR);
//            
//            if ([_delegate respondsToSelector:@selector(didRequestFailedWithDataIsReady:)]) {
//                [_delegate didRequestFailedWithDataIsReady:_dataIsReady];
//                _delegate = nil;
//            }
//        } else {
//            _automationDataManagerStep = enumAutomationDataManagerStep_GetBannerAds_Finished;
//            return;
//        }
        // MinhPB 2012/10, should not return then get the old step to help the System understand
        ALERT(STRING_ALERT_CONNECTION_ERROR_TITLE, STRING_ALERT_SERVER_ERROR);
        
        if ([_delegate respondsToSelector:@selector(didRequestFailedWithDataIsReady:)]) {
            [_delegate didRequestFailedWithDataIsReady:_dataIsReady];
            _delegate = nil;
        }
        
        if (_dataIsReady == enumAutomationDataIsReady_ForAutomation) {
            _alertCheckingNetwork_Showing = YES;
            
            if (type == ENUM_API_REQUEST_TYPE_USER_UPDATE_LOCATION) {
                _previousStep = enumAutomationDataManagerStep_UpdateUserLocation_Failed;
            }
//            else if (type == ENUM_API_REQUEST_TYPE_USER_UPDATE_ONLINE_STATUS) {
//                _previousStep = enumAutomationDataManagerStep_UpdateUserOnlineStatus_Failed;
//            }
            else if (type == ENUM_API_REQUEST_TYPE_USER_GET_PROFILE) {
                _previousStep = enumAutomationDataManagerStep_GetUserProfile_Failed;
            }
            else if (type == ENUM_API_REQUEST_TYPE_USER_GET_BANNER_ADS) {
                _previousStep = enumAutomationDataManagerStep_GetBannerAds_Failed;
            }
            else if (type == ENUM_API_REQUEST_TYPE_KARDS_GET_ME) {
                _previousStep = enumAutomationDataManagerStep_GetMEKards_Failed;
            }
            _automationDataManagerStep = enumAutomationDataManagerStep_CheckingForNetwork;
        }
        else {
            _automationDataManagerStep = enumAutomationDataManagerStep_CheckingForNext;
        }
        return;
    }
    
    if (type == ENUM_API_REQUEST_TYPE_USER_UPDATE_LOCATION) {
        _automationDataManagerStep = enumAutomationDataManagerStep_UpdateUserLocation_Finished;
    }
//    else if (type == ENUM_API_REQUEST_TYPE_USER_UPDATE_ONLINE_STATUS) {
//        _automationDataManagerStep = enumAutomationDataManagerStep_UpdateUserOnlineStatus_Finished;
//    }
    else if (type == ENUM_API_REQUEST_TYPE_USER_GET_PROFILE) {
        NSMutableArray *jsonData = [sbJSON objectWithString:[request responseString] error:&error];
        if (jsonData.count > 0) {
            NSMutableDictionary *dicJson = [SupportFunction repairingDictionaryWith:[jsonData objectAtIndex:0]];
            if (dicJson) {
                
                [UserDataManager Shared].avatarSmallURL = [dicJson objectForKey:STRING_RESPONSE_KEY_DECK_IMAGE_SMALL];
                [UserDataManager Shared].konnectSmallURL = [dicJson objectForKey:STRING_RESPONSE_KEY_KONNECT_IMAGE];
                [UserDataManager Shared].dealSmallURL = [dicJson objectForKey:STRING_RESPONSE_KEY_DEAL_IMAGE];
                [UserDataManager Shared].feedsSmallURL = [dicJson objectForKey:STRING_RESPONSE_KEY_FEEDS_IMAGE];
                [UserDataManager Shared].myKardsUnreadMessage = [[dicJson objectForKey:STRING_RESPONSE_KEY_MESSAGE_UNREAD] intValue];
                [UserDataManager Shared].feedsUnreadMessage = [[dicJson objectForKey:STRING_RESPONSE_KEY_FEED_UNREAD] intValue];
                [UserDataManager Shared].konnectWaitingForApproval = [[dicJson objectForKey:STRING_RESPONSE_KEY_NUMBER_WAITING_ARROVE] intValue];
                [UserDataManager Shared].sortMyKard = [[dicJson objectForKey:STRING_RESPONSE_KEY_SORT_MY_KARD] intValue];
                [UserDataManager Shared].showMyKardUnread = [[dicJson objectForKey:STRING_RESPONSE_KEY_SHOW_UNREAD] intValue]; 
                [UserDataManager Shared].userIsVisible = [[dicJson objectForKey:STRING_RESPONSE_KEY_USER_VISIBLE] intValue];
                [UserDataManager Shared].myDealMerchant = [dicJson objectForKey:STRING_RESPONSE_KEY_MY_DEAL_MECHANT_NAME];
                [UserDataManager Shared].myDealHeadline = [dicJson objectForKey:STRING_RESPONSE_KEY_MY_DEAL_HEADLINE];
                [UserDataManager Shared].myDealPrice = [[dicJson objectForKey:STRING_RESPONSE_KEY_MY_DEAL_PRICE] intValue];
                [UserDataManager Shared].myDealValue = [[dicJson objectForKey:STRING_RESPONSE_KEY_MY_DEAL_VALUE] intValue];
                [UserDataManager Shared].dealSmallURL = [dicJson objectForKey:STRING_RESPONSE_KEY_MY_DEAL_IMAGE];
                [UserDataManager Shared].myDealCategory = [dicJson objectForKey:STRING_RESPONSE_KEY_MY_DEAL_CATEGORY_HOME];
                [UserDataManager Shared].pointUser = [[dicJson objectForKey:STRING_RESPONSE_KEY_POINT_USER] intValue];
                [UserDataManager Shared].myDefaultKardId = [[dicJson objectForKey:STRING_RESPONSE_KEY_ID_KARDS] intValue];
                [UserDataManager Shared].fullName = [dicJson objectForKey:STRING_REQUEST_KEY_FULL_NAME];
                
                if ([[dicJson objectForKey:STRING_RESPONSE_KEY_ID_KARDS] intValue] > 0 && [UserDataManager Shared].userMeKards == 0) {
                    [UserDataManager Shared].userMeKards = 1;
                }
                
                [[UserDataManager Shared] save];
                
                KardsCategoryData *kardsCategory = [[KardsDataManager kardsShared] getMECategory];
                kardsCategory.kardsSmallAvatarURL = [dicJson objectForKey:STRING_RESPONSE_KEY_IMAGE_SMALL];
                // Hard code, MinhPB 2012/11/08
                kardsCategory.kardsFeedNumber = @"0";
            }
        }
        _automationDataManagerStep = enumAutomationDataManagerStep_GetUserProfile_Finished;
    }
    else if (type == ENUM_API_REQUEST_TYPE_USER_GET_BANNER_ADS) {
        NSMutableArray *jsonData = [sbJSON objectWithString:[request responseString] error:&error];
        if (jsonData.count > 0) {
            NSMutableDictionary *dicJson = [SupportFunction repairingDictionaryWith:[jsonData objectAtIndex:0]];
            if (dicJson) {
                
            }
        }
        
        _automationDataManagerStep = enumAutomationDataManagerStep_GetBannerAds_Finished;
    }
    else if (type == ENUM_API_REQUEST_TYPE_KARDS_GET_ME) {
        NSMutableArray *jsonData = [sbJSON objectWithString:[request responseString] error:&error];
        KardsCategoryData *kardsCategory = [[KardsDataManager kardsShared] getMECategory];
        for (NSMutableDictionary *dicJson in jsonData) {
            if ([dicJson objectForKey:STRING_RESPONSE_KEY_GET_DECK_USER_INFO] == nil) {                
                KardsNodeData *kardsNode = [[KardsNodeData alloc] initWithKardsName:[dicJson objectForKey:STRING_RESPONSE_KEY_NAME] andKardsID:[[dicJson objectForKey:STRING_RESPONSE_KEY_ID_KARDS] stringValue] andKardsSmallAvatar:nil];
                kardsNode.kardsSmallAvatarURL = [dicJson objectForKey:STRING_RESPONSE_KEY_IMAGE_SMALL];
                kardsNode.kardsMediumAvatarURL = [dicJson objectForKey:STRING_RESPONSE_KEY_IMAGE_MEDIUM];
                kardsNode.kardsLargeAvatarURL = [dicJson objectForKey:STRING_RESPONSE_KEY_IMAGE_LARGE];
                kardsNode.kardType = [[dicJson objectForKey:STRING_RESPONSE_KEY_FK_KARD_TYPE] intValue];
                kardsNode.kardsTradeType = enumKardsTradeType_MyKardsTraded;
                kardsNode.isMine = enumIsDataMine_isMine;
                kardsNode.kardsUserID = [[dicJson objectForKey:STRING_RESPONSE_KEY_FK_USER] stringValue];
                kardsNode.kardsNumberWaitingArrove = [[dicJson objectForKey:STRING_RESPONSE_KEY_NUMBER_WAITING_ARROVE] stringValue];
                kardsNode.isLocalCopyType = enumIsLocalCopyType_FromServer;
                kardsNode.kardsIsMyDefault = [[dicJson objectForKey:STRING_RESPONSE_KEY_IS_MY_DEFAULT] stringValue];
                kardsNode.konnectVisibility = [[dicJson objectForKey:STRING_RESPONSE_KEY_KONNECT_VISIBILITY] stringValue];
                kardsNode.profileID =[[dicJson objectForKey:STRING_RESPONSE_KEY_FK_PROFILE] stringValue];
                
                [kardsCategory addNode:kardsNode];
            }
            else {
                KardsCategoryData *kardsCategory = [[KardsCategoryData alloc] initWithKardsName:[dicJson objectForKey:STRING_RESPONSE_KEY_NAME] andKardsID:[[dicJson objectForKey:STRING_RESPONSE_KEY_ID_KARDS] stringValue] andKardsSmallAvatar:nil];
                kardsCategory.kardsSmallAvatarURL = [dicJson objectForKey:STRING_RESPONSE_KEY_IMAGE_SMALL];
                kardsCategory.kardsMediumAvatarURL = [dicJson objectForKey:STRING_RESPONSE_KEY_IMAGE_MEDIUM];
                kardsCategory.kardsLargeAvatarURL = [dicJson objectForKey:STRING_RESPONSE_KEY_IMAGE_LARGE];
                kardsCategory.kardType = [[dicJson objectForKey:STRING_RESPONSE_KEY_FK_KARD_TYPE] intValue];
                kardsCategory.kardsTradeType = enumKardsTradeType_MyKardsTraded;
                kardsCategory.isMine = enumIsDataMine_isMine;
                kardsCategory.kardsUserID = [[dicJson objectForKey:STRING_RESPONSE_KEY_FK_USER] stringValue];
                kardsCategory.isLocalCopyType = enumIsLocalCopyType_FromServer;
                kardsCategory.kardsIsMyDefault = [[dicJson objectForKey:STRING_RESPONSE_KEY_IS_MY_DEFAULT] stringValue];
                kardsCategory.konnectVisibility = [[dicJson objectForKey:STRING_RESPONSE_KEY_KONNECT_VISIBILITY] stringValue];
                kardsCategory.profileID = [[dicJson objectForKey:STRING_RESPONSE_KEY_FK_PROFILE] stringValue];
                
                [kardsCategory addCategory:kardsCategory];
            }
        }
        
        [UserDataManager Shared].userMeKards = kardsCategory.categoryArray.count;
        [[UserDataManager Shared] save];
        
        _automationDataManagerStep = enumAutomationDataManagerStep_GetMEKards_Finished;
    }
    if (type == ENUM_API_REQUEST_TYPE_DEAL_GET_MY)
    {
        NSMutableArray *myDealList = [[NSMutableArray alloc] initWithArray:[sbJSON objectWithString:[request responseString] error:&error]];
        
        KardsCategoryData *dealsCategory = [[KardsDataManager kardsShared] getDealCategory];
        for (NSMutableDictionary *dict in myDealList)
        {
            NSMutableDictionary *dicJson = [SupportFunction repairingDictionaryWith:dict];
            KardsNodeData *kardsNode1 = [[KardsNodeData alloc] initWithKardsName:[dicJson objectForKey:STRING_RESPONSE_KEY_MERCHANT_NAME] andKardsID:[[dicJson objectForKey:STRING_RESPONSE_KEY_ID_KARDS] stringValue] andKardsSmallAvatar:nil];
            kardsNode1.kardsUserID = [NSString stringWithFormat:@"%i",[[dicJson objectForKey:STRING_REQUEST_KEY_FK_USER] intValue]];
            kardsNode1.kardsSmallAvatarURL = [dicJson objectForKey:STRING_RESPONSE_KEY_THUMBNAIL];
            kardsNode1.kardsMediumAvatarURL = [dicJson objectForKey:STRING_RESPONSE_KEY_THUMBNAIL];
            kardsNode1.kardsLargeAvatarURL = [dicJson objectForKey:STRING_RESPONSE_KEY_THUMBNAIL];
            kardsNode1.dealAddress = [dicJson objectForKey:STRING_RESPONSE_KEY_MERCHANT_ADDRESS];
            kardsNode1.dealHeadLine = [dicJson objectForKey:STRING_RESPONSE_KEY_HEADLINE];
            kardsNode1.dealDistance = [[dicJson objectForKey:STRING_RESPONSE_KEY_DISTANCE_TO_MERCHANT] intValue];
            kardsNode1.dealCity = [dicJson objectForKey:STRING_RESPONSE_KEY_CITY_NAME];
            kardsNode1.dealRedeemed = [[dicJson objectForKey:STRING_RESPONSE_KEY_IS_REDEEMED] intValue];
            kardsNode1.dealPendding = [[dicJson objectForKey:STRING_RESPONSE_KEY_IS_PENDING] intValue];
            kardsNode1.kardsTradeType = enumKardsTradeType_DealPending;
            kardsNode1.kardType = enumKardType_Deal;
            kardsNode1.dealID = [NSString stringWithFormat:@"%i",[[dicJson objectForKey:STRING_RESPONSE_KEY_DEAL_ID] intValue]];
            kardsNode1.coordinate = CLLocationCoordinate2DMake([[dicJson objectForKey:STRING_RESPONSE_KEY_LATITUDE] floatValue], [[dicJson objectForKey:STRING_RESPONSE_KEY_LOGITUDE] floatValue]);
            kardsNode1.latitude=[[dicJson objectForKey:STRING_RESPONSE_KEY_LATITUDE] floatValue];
            kardsNode1.longitude=[[dicJson objectForKey:STRING_RESPONSE_KEY_LOGITUDE] floatValue];
            kardsNode1.pricevalue=[[dicJson objectForKey:STRING_RESPONSE_KEY_REGULAR_PRICE]intValue];
            kardsNode1.discountvalue=[[dicJson objectForKey:STRING_RESPONSE_KEY_DISCOUNT_PRICE]intValue];
            kardsNode1.merchantName=[dicJson objectForKey:STRING_RESPONSE_KEY_MERCHANT_NAME];
            kardsNode1.dealredeemeddate=[dicJson objectForKey:STRING_RESPONSE_KEY_REDEEMED_DATE];
            kardsNode1.kardsID = [NSString stringWithFormat:@"%i",[[dicJson objectForKey:STRING_RESPONSE_KEY_KARD_ID] intValue]];
            kardsNode1.redeemedCode = [dicJson objectForKey:STRING_RESPONSE_KEY_DEAL_REDEEMCODE];
            kardsNode1.descriptionvalue=[dicJson objectForKey:STRING_RESPONSE_KEY_DESCRIPTION];
            kardsNode1.kardsFriendID = [NSString stringWithFormat:@"%@",[dicJson objectForKey:STRING_RESPONSE_KEY_FK_FRIEND]];
            kardsNode1.isMine = enumIsDataMine_isMyDeal;
            kardsNode1.dealCategory = [dicJson objectForKey:STRING_RESPONSE_KEY_DEAL_CATEGORY];
            kardsNode1.kardsTradeType = enumKardsTradeType_DealPurchased;
            [dealsCategory addNode:kardsNode1];
        }
        _automationDataManagerStep = enumAutomationDataManagerStep_GetMyDeals_Finished;
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request andType:(ENUM_API_REQUEST_TYPE)type {
    NSLog(@"AutomationDataManager requestFailed %@ ", request.responseString);
    
//    // For now: support compatiable for all servers about API get banner, we will ignore the error so that we use default banner come with the app.
//    if (type != ENUM_API_REQUEST_TYPE_USER_GET_BANNER_ADS) {
//        if ([_delegate respondsToSelector:@selector(didRequestFailedWithDataIsReady:)]) {
//            [_delegate didRequestFailedWithDataIsReady:_dataIsReady];
//            _delegate = nil;
//        }
//
//        if (!_alertRequestFailed.visible) {
//            [_alertRequestFailed show];
//        }
//    }
//    else {
//        _automationDataManagerStep = enumAutomationDataManagerStep_GetBannerAds;
//        return;
//    }
    // MinhPB 2012/10, should not return then get the old step to help the System understand
    if ([_delegate respondsToSelector:@selector(didRequestFailedWithDataIsReady:)]) {
        [_delegate didRequestFailedWithDataIsReady:_dataIsReady];
        _delegate = nil;
    }
    
    if (!_alertRequestFailed.visible) {
        [_alertRequestFailed show];
    }
    
    if (_dataIsReady == enumAutomationDataIsReady_ForAutomation) {
        _alertCheckingNetwork_Showing = YES;
        
        if (type == ENUM_API_REQUEST_TYPE_USER_UPDATE_LOCATION) {
            _previousStep = enumAutomationDataManagerStep_UpdateUserLocation_Failed;
        }
//        else if (type == ENUM_API_REQUEST_TYPE_USER_UPDATE_ONLINE_STATUS) {
//            _previousStep = enumAutomationDataManagerStep_UpdateUserOnlineStatus_Failed;
//        }
        else if (type == ENUM_API_REQUEST_TYPE_USER_GET_BANNER_ADS) {
            _previousStep = enumAutomationDataManagerStep_GetBannerAds_Failed;
        }
        else if (type == ENUM_API_REQUEST_TYPE_USER_GET_PROFILE) {
            _previousStep = enumAutomationDataManagerStep_GetUserProfile_Failed;
        }
        else if (type == ENUM_API_REQUEST_TYPE_KARDS_GET_ME) {
            _previousStep = enumAutomationDataManagerStep_GetMEKards_Failed;
        }
        _automationDataManagerStep = enumAutomationDataManagerStep_CheckingForNetwork;
    }
    else {
        _automationDataManagerStep = enumAutomationDataManagerStep_CheckingForNext;
    }
}

#pragma mark - CLLocationManagerDelegate

/*
- (void)updateUserLocationService {
    // Only allow user request location after amount time default is 2 mins
    if (![self isAllowGetCurrentLocationTimer]) {
        return;
    }
    
    if (CLLocationManager.authorizationStatus == kCLAuthorizationStatusRestricted || CLLocationManager.authorizationStatus == kCLAuthorizationStatusDenied)
    {
        if (!_alertLocationService.visible) {
            [_alertLocationService show];
        }
    }
    else {
        //[_locationManager stopUpdatingLocation];
        //[_locationManager startUpdatingLocation];
        [self startUpdateLocationService];
    }
}
*/

- (void)startMonitoringSignificantLocationChanges {
    if (CLLocationManager.authorizationStatus == kCLAuthorizationStatusRestricted || CLLocationManager.authorizationStatus == kCLAuthorizationStatusDenied)
    {
        if (!_alertLocationService.visible) {
            [_alertLocationService show];
        }
    }
    else {
        if (_locationState == enumLocationState_Standard_Running) {
            [self stopUpdateLocationService];
        }
        [_locationManager startMonitoringSignificantLocationChanges];
        _locationState = enumLocationState_SLC_Running;
    }
}


- (void)stopMonitoringSignificantLocationChanges {
    if (CLLocationManager.authorizationStatus == kCLAuthorizationStatusRestricted || CLLocationManager.authorizationStatus == kCLAuthorizationStatusDenied)
    {
        if (!_alertLocationService.visible) {
            [_alertLocationService show];
        }
    }
    else {
        [_locationManager stopMonitoringSignificantLocationChanges];
        _locationState = enumLocationState_SLC_Stop;
    }
}

- (void)startUpdateLocationService {
    // MinhPB force updating 
//    // Only allow user request location after amount time default is 2 mins
//    if (![self isAllowGetCurrentLocationTimer]) {
//        return;
//    }
    
    if (CLLocationManager.authorizationStatus == kCLAuthorizationStatusRestricted || CLLocationManager.authorizationStatus == kCLAuthorizationStatusDenied)
    {
        if (!_alertLocationService.visible) {
            [_alertLocationService show];
        }
    }
    else {
        if (_locationState == enumLocationState_SLC_Running) {
            [self stopMonitoringSignificantLocationChanges];
        }
        [_locationManager startUpdatingLocation];
        _locationState = enumLocationState_Standard_Running;
    }
}

- (void)stopUpdateLocationService {
    if (CLLocationManager.authorizationStatus == kCLAuthorizationStatusRestricted || CLLocationManager.authorizationStatus == kCLAuthorizationStatusDenied)
    {
        if (!_alertLocationService.visible) {
            [_alertLocationService show];
        }
    }
    else {
        [_locationManager stopUpdatingLocation];
         _locationState = enumLocationState_Standard_Stop;
    }
}

-(void) sendBackgroundLocationToServer:(CLLocation *)location
{
    // REMEMBER. We are running in the background if this is being executed.
    // We can't assume normal network access.
    // bgTask is defined as an instance variable of type UIBackgroundTaskIdentifier
    
    // Note that the expiration handler block simply ends the task. It is important that we always
    // end tasks that we have started.
    
    bgTask = [[UIApplication sharedApplication]
              beginBackgroundTaskWithExpirationHandler:
              ^{
                  [[UIApplication sharedApplication] endBackgroundTask:bgTask];
                   }];
                  
                  // ANY CODE WE PUT HERE IS OUR BACKGROUND TASK
                  
                  // For example, I can do a series of SYNCHRONOUS network methods (we're in the background, there is
                  // no UI to block so synchronous is the correct approach here).
                  
                  // ...
                  
                  // AFTER ALL THE UPDATES, close the task
                  
                  if (bgTask != UIBackgroundTaskInvalid)
                  {
                      [[UIApplication sharedApplication] endBackgroundTask:bgTask];
                       bgTask = UIBackgroundTaskInvalid;
                       
                  }
}

- (void)updateLocalUserLocation:(CLLocation *)location {
    // MinhPB 2012/10/26
    if (location.coordinate.latitude == 0 || location.coordinate.longitude == 0) {
        return;
    }
    
//    NSLog(@"-updateLocalUserLocation-_locationState=%i",_locationState);
    [UserDataManager Shared].userLocation = location;
    [[UserDataManager Shared] save];
    
    // If it's a relatively recent event, turn off updates to save power
    NSDate* eventDate = location.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (abs(howRecent) < 15.0) {
        // If the event is recent, do something with it.
//        NSLog(@"latitude %+.6f, longitude %+.6f\n",
//              location.coordinate.latitude,
//              location.coordinate.longitude);
        
        
        CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
        [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
            // STOP TRACKING USER LOCATION TO SAVE BATTERRY ONCE THE THE LOCATION FIX
            //[self stopUpdateLocationService];
            if (_locationState == enumLocationState_Standard_Running) {
                //[_locationManager stopUpdatingLocation];
                //[self stopUpdateLocationService];
                [self startMonitoringSignificantLocationChanges];
            }
            
            [UserDataManager Shared].currentPlaceMark = [placemarks objectAtIndex:0];
            [[UserDataManager Shared] save];
        }];
    }
}


-(BOOL)isAllowGetCurrentLocationTimer {
    // Only allow user request location after amount time default is 2 mins
    NSTimeInterval howRecent = [_locationTimeOut timeIntervalSinceNow];
    if (abs(howRecent) < TIMER_LOCATION_ALLOW_TO_UPDATE) {
        return FALSE;
    } else {
        // Update current time
        _locationTimeOut = [NSDate date];
        return TRUE;
    }
}

// decaptered in iOS5
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    //[_locationManager stopUpdatingLocation];
    
  //  NSLog(@" didUpdateToLocation %f, %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
//        ALERT(@"", [NSString stringWithFormat:@"test location: %f", [newLocation distanceFromLocation:userLocation]]);
    
    //[UserDataManager Shared].userLocation = newLocation;
    //[[UserDataManager Shared] save];
    
    [self updateLocalUserLocation:newLocation];
    /*
    // Get Currrent Placemark
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        //NSString * location = ([placemarks count] > 0) ? [[placemarks objectAtIndex:0] locality] : @"Not Found";
        
        //NSLog(@"----------Place marks = %@", location);
        
        
        // STOP TRACKING USER LOCATION TO SAVE BATTERRY ONCE THE THE LOCATION FIX
        [_locationManager stopUpdatingLocation];
        
        [UserDataManager Shared].currentPlaceMark = [placemarks objectAtIndex:0];
        [[UserDataManager Shared] save];
        
        //NSString *isoCountryCodetext = placemark.ISOcountryCode;
        //NSString *countrytext = placemark.country;
        //NSString *postalCodetext= placemark.postalCode;
        //NSString *adminAreatext=placemark.administrativeArea;
        //NSString *subAdminAreatext=placemark.subAdministrativeArea;
        //NSString *localitytext=placemark.locality;
        //NSString *subLocalitytext=placemark.subLocality;
        //NSString *thoroughfaretext=placemark.thoroughfare;
        //NSString *subThoroughfaretext=placemark.subThoroughfare;
        
        
        //NSLog(@"-------1---Place marks = %@", [UserDataManager Shared].currentPlaceMark);
        //NSLog(@"-------2---Place marks = %@----%@-----%@-----%@", [UserDataManager Shared].currentPlaceMark.locality,[UserDataManager Shared].currentPlaceMark.subLocality,[UserDataManager Shared].currentPlaceMark.subAdministrativeArea,[UserDataManager Shared].currentPlaceMark.administrativeArea);
        
        //region.text=placemark.region;
        
        
    }];
    */
    
}


// Delegate method from the CLLocationManagerDelegate protocol.
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    
    BOOL isInBackground = NO;
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateBackground)
    {
        isInBackground = YES;
    }
    
    // Handle location updates as normal, code omitted for brevity.
    // The omitted code should determine whether to reject the location update for being too
    // old, too close to the previous one, too inaccurate and so forth according to your own
    // application design.
    
    if (isInBackground)
    {
        //[self sendBackgroundLocationToServer:newLocation];
    }
    else
    {
        // ...
    }
    
    CLLocation* location = [locations lastObject];
    [self updateLocalUserLocation:location];    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@" didFailWithError ");
//    [_locationManager stopUpdatingLocation];
    
//    ALERT(@"", STRING_ALERT_MESSAGE_TURN_ON_LOCATION_SERVICE);
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    NSLog(@" didChangeAuthorizationStatus ");
    if (status == kCLAuthorizationStatusRestricted || status == kCLAuthorizationStatusDenied)
    {
        if (!_alertLocationService.visible) {
            [_alertLocationService show];
        }
    }
    else {
        [_alertLocationService dismissWithClickedButtonIndex:0 animated:YES];
    }
}

static AutomationDataManager *m_Instance;
+ (AutomationDataManager *)Shared
{
    if (!m_Instance) {
        m_Instance = [AutomationDataManager new];
    }
    return m_Instance;
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    _alertCheckingNetwork_Showing = NO;
}

@end
