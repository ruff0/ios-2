//
//  KardsDataManager.m
//  trongvm
//
//  Created by Admin on 5/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "KardsDataManager.h"

#pragma mark - KardsNodeData

@implementation KardsNodeData
@synthesize kardsName, kardsID, kardsSmallAvatar, kardsMediumAvatar, kardsLargeAvatar, coordinate, kardsOpptions, kardsLargeAvatarURL, kardsSmallAvatarURL, kardsMediumAvatarURL, dealAddress, dealDistance, dealHeadLine, kardsTradeType, isMine, kardsUserID, kardsTradeKonnectId, dealUserPassed, dealPendding, dealRedeemed, kardType, kardsNumberWaitingArrove, isLocalCopyType, konnectDistanceMap, titletext, title, subtitle, subtitletext, konnectDistanceUser, kardsFriendID, kardsIsMyDefault, konnectVisibility, profileID, konnectMutualKards, konnectKonnectLabel, kardsFeedNumber, konnectIsHidden, konnectHiddenDate, konnectUserIsOnline, konnectRequestingNumber, kardsDeckName, isHide;

@synthesize feedsComment,feedsFullName,feedsFkProfile,feedsTitle,feedsMedia,feedsIdNews,feedsCountResponse
,feedsCountLike,feedsDateCreated,feedsIsLike,feedsCountUnLike,feedsIsUnLike,feedsIsPrioritize, postBackKard, mediaThumb,feedIsRead,hideThisKard,hideKardDate;

@synthesize dealPricevalue, dealMerchantName, dealDiscountvalue, dealCategory;

@synthesize latitude, longitude, pricevalue, merchantName, discountvalue, dealredeemeddate, descriptionvalue, dealCity, dealID, redeemedCode;

@synthesize rewardAddress,
rewardState,
rewardCountry,
rewardDescription,
rewardPhone,
rewardLat,
rewardLng,
productType,
rewardTitle,
rewardDateCreated,
rewardDistanceUser,
rewardProductId,
rewardProductTYpeName,
rewardSalePrice,
rewardOrignPrice,
rewardZipCode,rewardCity,rewardPoints;

- (void)dealloc {
}

- (NSString *)subtitle {
	return subtitletext;
}
- (NSString *)title {
	return titletext;
}

- (void)setTitle:(NSString*)strTitle {
	self.titletext = strTitle;
}

- (void)setSubTitle:(NSString*)strSubTitle {
	self.subtitletext = strSubTitle;
}

- (id)initWithKardsName:(NSString *)strName 
             andKardsID:(NSString *)strID
         andKardsSmallAvatar:(UIImage *)imgSmallAvatar {
    self = [super init];
    if (self) {
        if (strName && (NSNull *)strName != [NSNull null]) {
            kardsName = strName;
        }
        if (strID && (NSNull *)strID != [NSNull null]) {
            kardsID = strID ;
        }
        if (imgSmallAvatar && (NSNull *)imgSmallAvatar != [NSNull null]) kardsSmallAvatar = imgSmallAvatar ;
    }
    return self;    
}

/*
- (id)copyWithZone:(NSZone *)zone
{
    KardsNodeData *nodeCopy = [[[self class] alloc] init];
    
    if (nodeCopy) {
        // Copy NSObject subclasses
        nodeCopy.kardsName = [kardsName copy];
        nodeCopy.kardsID = [kardsID copy];
        nodeCopy.kardsSmallAvatar = [kardsSmallAvatar copy];
        nodeCopy.kardsMediumAvatar = [kardsMediumAvatar copy];
        nodeCopy.kardsLargeAvatar = [kardsLargeAvatar copy];
        nodeCopy.kardType = kardType;
        nodeCopy.kardsOpptions = [kardsOpptions copy];
        nodeCopy.coordinate = coordinate;
        nodeCopy.kardsSmallAvatarURL = [kardsSmallAvatarURL copy];
        nodeCopy.kardsMediumAvatarURL = [kardsMediumAvatarURL copy];
        nodeCopy.kardsLargeAvatarURL = [kardsLargeAvatarURL copy];
        nodeCopy.kardsUserID = [kardsUserID copy];
        nodeCopy.kardsTradeKonnectId = [kardsTradeKonnectId copy];
        nodeCopy.dealDistance = dealDistance;
        nodeCopy.dealAddress = [dealAddress copy];
        nodeCopy.dealHeadLine = [dealHeadLine copy];
        nodeCopy.dealRedeemed = dealRedeemed;
        nodeCopy.dealPendding = dealPendding;
        nodeCopy.dealUserPassed = dealUserPassed;
        nodeCopy.dealID = [dealID copy];
        nodeCopy.dealCategory = [dealCategory copy];
        nodeCopy.konnectVisibility = [konnectVisibility copy];
        nodeCopy.profileID = [profileID copy];
        nodeCopy.kardsTradeType = kardsTradeType;
        nodeCopy.isMine = isMine;
        nodeCopy.kardsNumberWaitingArrove = self.kardsNumberWaitingArrove;
        nodeCopy.isLocalCopyType = self.isLocalCopyType;
        nodeCopy.konnectDistanceUser = [konnectDistanceMap copy];
        nodeCopy.feedsComment = [feedsComment copy];
        nodeCopy.feedsFullName = [feedsFullName copy];
        nodeCopy.feedsFkProfile = feedsFkProfile;
        nodeCopy.feedsTitle = [feedsTitle copy];
        nodeCopy.feedsMedia = [feedsMedia copy];
        nodeCopy.feedsIdNews = feedsIdNews;
        nodeCopy.feedsCountResponse = feedsCountResponse;
        nodeCopy.feedsCountLike = feedsCountLike;
        nodeCopy.feedsDateCreated = [feedsDateCreated copy];
        nodeCopy.feedsIsLike = feedsIsLike;
        nodeCopy.feedsCountUnLike = feedsCountUnLike;
        nodeCopy.feedsIsUnLike = feedsIsUnLike;
        nodeCopy.feedsIsPrioritize = feedsIsPrioritize;
        nodeCopy.kardsFriendID = kardsFriendID;
        nodeCopy.postBackKard = postBackKard;
        nodeCopy.mediaThumb = [mediaThumb copy];
        nodeCopy.feedIsRead = feedIsRead;
        
        nodeCopy.pricevalue=pricevalue;
        nodeCopy.discountvalue=discountvalue;
        nodeCopy.latitude = latitude;
        nodeCopy.longitude = longitude;
        nodeCopy.merchantName=[merchantName copy];
        nodeCopy.dealredeemeddate=[dealredeemeddate copy];
        nodeCopy.descriptionvalue=[descriptionvalue copy];
        nodeCopy.dealCity = [dealCity copy];
        nodeCopy.redeemedCode = [redeemedCode copy];
        nodeCopy.hideKardDate = [hideKardDate copy];
        nodeCopy.hideThisKard = hideThisKard;
        
        ////// Rewards ////////
        nodeCopy.rewardAddress = [rewardAddress copy];
        nodeCopy.rewardState = [rewardState copy];
        nodeCopy.rewardCountry = [rewardCountry copy];
        nodeCopy.rewardDescription = [rewardDescription copy];
        nodeCopy.rewardPhone = [rewardPhone copy]; 
        nodeCopy.rewardLat = [rewardLat copy];
        nodeCopy.rewardLng = [rewardLng copy];
        nodeCopy.productType = productType;
        nodeCopy.rewardTitle = [rewardTitle copy];
        nodeCopy.rewardDateCreated = [rewardDateCreated copy];
        nodeCopy.rewardDistanceUser = rewardDistanceUser;
        nodeCopy.rewardProductId = rewardProductId;
        nodeCopy.rewardProductTYpeName = [rewardProductTYpeName copy];
        nodeCopy.rewardSalePrice = rewardSalePrice;
        nodeCopy.rewardOrignPrice = rewardOrignPrice;
        nodeCopy.rewardZipCode = rewardZipCode;
        nodeCopy.rewardCity = [rewardCity copy];
        nodeCopy.rewardPoints = rewardPoints;
        

    }
    
    return nodeCopy;
}

*/
- (id)copy {
//    kardsName
//    kardsID
//    kardsSmallAvatar
//    kardsMediumAvatar
//    kardsLargeAvatar
//    kardType
//    kardsOpptions
//    coordinate
//    kardsSmallAvatarURL
//    kardsMediumAvatarURL
//    kardsLargeAvatarURL
//    kardsUserID
//    kardsTradeKonnectId
//    dealDistance
//    dealAddress
//    dealHeadLine
//    dealRedeemed
//    dealPendding
//    dealUserPassed
//    kardsTradeType
//    isMine
//    kardsNumberWaitingArrove
    
//    KardsNodeData *nodeCopy = [[[KardsNodeData alloc] initWithKardsName:self.kardsName andKardsID:self.kardsID andKardsSmallAvatar:self.kardsSmallAvatar] autorelease];
//
//    nodeCopy.kardsMediumAvatar = self.kardsMediumAvatar;
//    nodeCopy.kardsLargeAvatar = self.kardsLargeAvatar;
//    nodeCopy.kardType = self.kardType;
//    nodeCopy.kardsOpptions = self.kardsOpptions;
//    nodeCopy.coordinate = self.coordinate;
//    nodeCopy.kardsSmallAvatarURL = self.kardsSmallAvatarURL;
//    nodeCopy.kardsMediumAvatarURL = self.kardsMediumAvatarURL;
//    nodeCopy.kardsLargeAvatarURL = self.kardsLargeAvatarURL;
//    nodeCopy.kardsUserID = self.kardsUserID;
//    nodeCopy.kardsTradeKonnectId = self.kardsTradeKonnectId;
//    nodeCopy.dealDistance = self.dealDistance;
//    nodeCopy.dealAddress = self.dealAddress;
//    nodeCopy.dealHeadLine = self.dealHeadLine;
//    nodeCopy.dealRedeemed = self.dealRedeemed;
//    nodeCopy.dealPendding = self.dealPendding;
//    nodeCopy.dealUserPassed = self.dealUserPassed;
//    nodeCopy.kardsTradeType = self.kardsTradeType;
//    nodeCopy.isMine = self.isMine;
//    nodeCopy.kardsNumberWaitingArrove = self.kardsNumberWaitingArrove;
    
    return [super copy];
}

- (void)setKardsSmallAvatarURL:(NSString *)url {
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager downloadWithURL:[NSURL URLWithString:url] delegate:self];
    kardsSmallAvatarURL = url;
}

- (void)setKardsMediumAvatarURL:(NSString *)url {
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager downloadWithURL:[NSURL URLWithString:url] delegate:self retryFailed:NO lowPriority:YES];
    kardsMediumAvatarURL = url;
}

- (void)setKardsLargeAvatarURL:(NSString *)url {
//    SDWebImageManager *manager = [SDWebImageManager sharedManager];
//    [manager downloadWithURL:[NSURL URLWithString:url] delegate:self];
    kardsLargeAvatarURL = url;
}

#pragma mark - SDWebImageDownloaderDelegate

- (void)webImageManager:(SDWebImageManager *)imageManager didFinishWithImage:(UIImage *)image {
//    NSLog(@"KardsNodeData; webImageManager; didFinishWithImage");
}

- (void)webImageManager:(SDWebImageManager *)imageManager didFailWithError:(NSError *)error {
//    NSLog(@"KardsNodeData; webImageManager; didFailWithError");
}

@end 

#pragma mark - KardsCategoryData

@implementation KardsCategoryData

@synthesize isChildOfCategory, categoryArray, kardsDeepLevel, isHidden;

//- (id)initWithKardsName:(NSString *)strName 
//             andKardsID:(NSString *)strID
//         andKardsAvatar:(UIImage *)imgAvatar 
//           andCoodinate:(CLLocationCoordinate2D)clCoordinate
//           andKardsType:(NSString*)strType
//         andKardsOption:(NSMutableDictionary *)dictOption
// andKardsSmallAvatarURL:(NSString *)strSmallAvatar
// andKardsLargeAvatarURL:(NSString *)strLargeAvatar{
//    self = [super initWithKardsName:strName andKardsID:strID andKardsAvatar:imgAvatar andCoodinate:clCoordinate andKardsType:strType andKardsOption:dictOption andKardsSmallAvatarURL:strSmallAvatar andKardsLargeAvatarURL:strLargeAvatar];
//    if (self) {
//        isMine = enumIsDataMine_invalid;
//        kardsDeepLevel = 0;
//        isHidden = NO;
//        isChildOfCategory = eHasNotChild;
//        categoryArray = [NSMutableArray new];
//    }
//    return self;
//}
//
//- (id)initWithKardsName:(NSString *)strName 
//             andKardsID:(NSString *)strID 
//         andKardsAvatar:(UIImage *)imgAvatar 
//           andDeepLevel:(int)intDeepLevel 
//              andIsMind:(enumIsDataMine)eIsMine
//           andKardsType:(NSString *)strType 
//         andKardsOption:(NSMutableDictionary *)dictOption
// andKardsSmallAvatarURL:(NSString *)strSmallAvatar
// andKardsLargeAvatarURL:(NSString *)strLargeAvatar {
//    self = [super initWithKardsName:strName andKardsID:strID andKardsAvatar:imgAvatar andCoodinate:CLLocationCoordinate2DMake(0, 0)andKardsType:strType andKardsOption:dictOption andKardsSmallAvatarURL:strSmallAvatar andKardsLargeAvatarURL:strLargeAvatar];
//    if (self) {
//        isMine = eIsMine;
//        kardsDeepLevel = 0;
//        isHidden = NO;
//        isChildOfCategory = eHasNotChild;
//        categoryArray = [NSMutableArray new];
//    }
//    return self;
//}
//
//- (id)initWithKardsName:(NSString *)strName 
//             andKardsID:(NSString *)strID 
//         andKardsAvatar:(UIImage *)imgAvatar
//           andDeepLevel:(int)intDeepLevelpass 
//              andIsMind:(enumIsDataMine)eIsMine 
//           andCoodinate:(CLLocationCoordinate2D)clCoordinate
//           andKardsType:(NSString *)strType 
//         andKardsOption:(NSMutableDictionary *)dictOption
// andKardsSmallAvatarURL:(NSString *)strSmallAvatar
// andKardsLargeAvatarURL:(NSString *)strLargeAvatar {
//    self = [super initWithKardsName:strName andKardsID:strID andKardsAvatar:imgAvatar andCoodinate:clCoordinate andKardsType:strType andKardsOption:dictOption andKardsSmallAvatarURL:strSmallAvatar andKardsLargeAvatarURL:strLargeAvatar];
//    if (self) {
//        isMine = eIsMine;
//        kardsDeepLevel = 0;
//        isHidden = NO;
//        isChildOfCategory = eHasNotChild;
//        categoryArray = [NSMutableArray new];
//    }
//    return self;
//}

- (id)initWithKardsName:(NSString *)strName 
             andKardsID:(NSString *)strID
    andKardsSmallAvatar:(UIImage *)imgSmallAvatar {
    self = [super initWithKardsName:strName andKardsID:strID andKardsSmallAvatar:imgSmallAvatar];
    if (self) {
        kardsDeepLevel = 0;
        isHidden = NO;
        isChildOfCategory = eHasNotChild;
        categoryArray = [NSMutableArray new];
    }
    return self;    
}

- (void)dealloc {
    [categoryArray removeAllObjects];
    categoryArray = nil;
}

- (enumIsDataAdd)addNode:(KardsNodeData *)node {
    if (!categoryArray) {
        return eIsDataAddInvalid;
    }
    if (!node) {
        return eIsDataAddNull;
    }
    if ([categoryArray count] == 0) {
        [categoryArray addObject:node];
        isChildOfCategory = eChildIsNode;
        if (kardsSmallAvatar == nil && node.kardsSmallAvatar) {
            kardsSmallAvatar = node.kardsSmallAvatar;
        }
        if (kardsMediumAvatar == nil && node.kardsMediumAvatar) {
            kardsMediumAvatar = node.kardsMediumAvatar;
        }
        if (kardsLargeAvatar == nil && node.kardsLargeAvatar) {
            kardsLargeAvatar = node.kardsLargeAvatar;
        }
        if (kardsSmallAvatarURL == nil && node.kardsSmallAvatarURL) {
            kardsSmallAvatarURL = node.kardsSmallAvatarURL;
        }
        if (kardsMediumAvatarURL == nil && node.kardsMediumAvatarURL) {
            kardsMediumAvatarURL = node.kardsMediumAvatarURL;
        }
        if (kardsLargeAvatarURL == nil && node.kardsLargeAvatarURL) {
            kardsLargeAvatarURL = node.kardsLargeAvatarURL;
        }
        return eIsDataAddSuccess;
    }
    else
    {
        // MinhPB 2012/10/12
        // OLD
//        if (isChildOfCategory == eChildIsNode) {
//            for (int i=0; i<[categoryArray count]; i++) {
//                KardsNodeData *cjd_Temp = [categoryArray objectAtIndex:i];
//                if ([cjd_Temp.kardsID isEqualToString:node.kardsID] ) 
//                    return eIsDataAddHasSameKardsIDInAGroup;
//            }
//            
//            [categoryArray addObject:node];
//            return eIsDataAddSuccess;
//        }
//        else
//            return eIsDataAddFailChildIsCategory;
        
        // MinhPB 2012/10/12
        // For Current
        for (int i=0; i<[categoryArray count]; i++) {
            KardsNodeData *cjd_Temp = [categoryArray objectAtIndex:i];
            if ([cjd_Temp.kardsID isEqualToString:node.kardsID] ) 
                return eIsDataAddHasSameKardsIDInAGroup;
        }
        
        if (isChildOfCategory == eChildIsCategory) {
            isChildOfCategory = eChildIsCategoryAndNode;
        }
        [categoryArray addObject:node];
        if (kardsSmallAvatar == nil && node.kardsSmallAvatar) {
            kardsSmallAvatar = node.kardsSmallAvatar;
        }
        if (kardsMediumAvatar == nil && node.kardsMediumAvatar) {
            kardsMediumAvatar = node.kardsMediumAvatar;
        }
        if (kardsLargeAvatar == nil && node.kardsLargeAvatar) {
            kardsLargeAvatar = node.kardsLargeAvatar;
        }
        if (kardsSmallAvatarURL == nil && node.kardsSmallAvatarURL) {
            kardsSmallAvatarURL = node.kardsSmallAvatarURL;
        }
        if (kardsMediumAvatarURL == nil && node.kardsMediumAvatarURL) {
            kardsMediumAvatarURL = node.kardsMediumAvatarURL;
        }
        if (kardsLargeAvatarURL == nil && node.kardsLargeAvatarURL) {
            kardsLargeAvatarURL = node.kardsLargeAvatarURL;
        }
        return eIsDataAddSuccess;
    }
}

- (enumIsDataAdd)addNode:(KardsNodeData *)node atKardsID:(NSString *)strID {
    if (!categoryArray || !strID) {
        return eIsDataAddInvalid;
    }
    if (!node) {
        return eIsDataAddNull;
    }
    if ([kardsID isEqualToString:strID]) {
        return [self addNode:node];
    }
    else if (isChildOfCategory == eChildIsCategory || isChildOfCategory == eChildIsCategoryAndNode)
    {
        for (int i=0; i<[categoryArray count]; i++) {
            KardsCategoryData *cjd_Temp = [categoryArray objectAtIndex:i];
            enumIsDataAdd jda_Temp = [cjd_Temp addNode:node atKardsID:strID];
            if (jda_Temp == eIsDataAddSearchContinue) 
                continue;
            else
                return jda_Temp;
        }
    }
    return eIsDataAddSearchContinue;
}

- (enumIsDataAdd)addCategory:(KardsCategoryData *)node {
    if (!categoryArray) {
        return eIsDataAddInvalid;
    }
    if (!node) {
        return eIsDataAddNull;
    }
    if ([categoryArray count] == 0) {
        [categoryArray addObject:node];
        isChildOfCategory = eChildIsCategory;
        node.kardsDeepLevel = kardsDeepLevel+1;
        if (kardsSmallAvatar == nil && node.kardsSmallAvatar) {
            kardsSmallAvatar = node.kardsSmallAvatar;
        }
        if (kardsMediumAvatar == nil && node.kardsMediumAvatar) {
            kardsMediumAvatar = node.kardsMediumAvatar;
        }
        if (kardsLargeAvatar == nil && node.kardsLargeAvatar) {
            kardsLargeAvatar = node.kardsLargeAvatar;
        }
        if (kardsSmallAvatarURL == nil && node.kardsSmallAvatarURL) {
            kardsSmallAvatarURL = node.kardsSmallAvatarURL;
        }
        if (kardsMediumAvatarURL == nil && node.kardsMediumAvatarURL) {
            kardsMediumAvatarURL = node.kardsMediumAvatarURL;
        }
        if (kardsLargeAvatarURL == nil && node.kardsLargeAvatarURL) {
            kardsLargeAvatarURL = node.kardsLargeAvatarURL;
        }
        return eIsDataAddSuccess;
    }
    else
    {
        // MinhPB 2012/10/12
        // OLD
//        for (int i=0; i<[categoryArray count]; i++) {
//            KardsCategoryData *cjd_Temp = [categoryArray objectAtIndex:i];
//            if ([cjd_Temp.kardsID isEqualToString:node.kardsID] ) 
//                return eIsDataAddHasSameKardsIDInAGroup;
//        }
//        if (isChildOfCategory == eChildIsCategory) {
//            [categoryArray addObject:node];
//            node.kardsDeepLevel = kardsDeepLevel+1;
//            return eIsDataAddSuccess;
//        }
//        else
//            return eIsDataAddFailChildIsNode;
        
        // MinhPB 2012/10/12
        // For Current
        for (int i=0; i<[categoryArray count]; i++) {
            KardsCategoryData *cjd_Temp = [categoryArray objectAtIndex:i];
            if ([cjd_Temp.kardsID isEqualToString:node.kardsID] ) 
                return eIsDataAddHasSameKardsIDInAGroup;
        }
        
        if (isChildOfCategory == eChildIsNode) {
            isChildOfCategory = eChildIsCategoryAndNode;
        }
        [categoryArray addObject:node];
        node.kardsDeepLevel = kardsDeepLevel+1;
        if (kardsSmallAvatar == nil && node.kardsSmallAvatar) {
            kardsSmallAvatar = node.kardsSmallAvatar;
        }
        if (kardsMediumAvatar == nil && node.kardsMediumAvatar) {
            kardsMediumAvatar = node.kardsMediumAvatar;
        }
        if (kardsLargeAvatar == nil && node.kardsLargeAvatar) {
            kardsLargeAvatar = node.kardsLargeAvatar;
        }
        if (kardsSmallAvatarURL == nil && node.kardsSmallAvatarURL) {
            kardsSmallAvatarURL = node.kardsSmallAvatarURL;
        }
        if (kardsMediumAvatarURL == nil && node.kardsMediumAvatarURL) {
            kardsMediumAvatarURL = node.kardsMediumAvatarURL;
        }
        if (kardsLargeAvatarURL == nil && node.kardsLargeAvatarURL) {
            kardsLargeAvatarURL = node.kardsLargeAvatarURL;
        }
        return eIsDataAddSuccess;

    }
}

- (enumIsDataAdd)addCategory:(KardsCategoryData *)node atKardsID:(NSString *)strID {
    if (!categoryArray || !strID) {
        return eIsDataAddInvalid;
    }
    if (!node) {
        return eIsDataAddNull;
    }
    if ([kardsID isEqualToString:strID]) {
        return [self addCategory:node];
    }
    else if (isChildOfCategory == eChildIsCategory || isChildOfCategory == eChildIsCategoryAndNode)
    {
        for (int i=0; i<[categoryArray count]; i++) {
            KardsCategoryData *cjd_Temp = [categoryArray objectAtIndex:i];
            enumIsDataAdd jda_Temp = [cjd_Temp addCategory:node atKardsID:strID];
            if (jda_Temp == eIsDataAddSearchContinue) 
                continue;
            else
                return jda_Temp;
        }
    }
    return eIsDataAddSearchContinue;
}

- (BOOL)checkImInhere:(KardsNodeData *)node {
    if (isChildOfCategory == eChildIsNode) {
        for (int i=0; i<[categoryArray count]; i++) {
            KardsNodeData *njd_Temp = [categoryArray objectAtIndex:i];
            if ([node.kardsID isEqualToString:njd_Temp.kardsID]) {
                return YES;
            }
        }
    }
    return NO;
}

- (enumIsDataRemove)removeCategoriesWithKardsID:(NSString *)strID {
    if (!categoryArray || !strID) {
        return enumIsDataRemove_DataIsNil;
    }
    
    enumIsDataRemove enumReturn = enumIsDataRemove_NotExist;
    for (int i=0; i<[categoryArray count]; i++) {
		NSObject *objTemp = [categoryArray objectAtIndex:i];
        if ([[objTemp.class description] isEqualToString:[KardsCategoryData.class description]]) {
            if ([((KardsCategoryData *)objTemp).kardsID isEqualToString:strID]) {
                [categoryArray removeObjectAtIndex:i];
                enumReturn = enumIsDataRemove_Successful;
                NSLog(@"Successful: %@", ((KardsCategoryData *)objTemp).kardsName);
            }
            else {
                enumIsDataRemove enumTemp = [((KardsCategoryData *)objTemp) removeCategoriesWithKardsID:strID];
                if (enumTemp == enumIsDataRemove_Successful) {
                    enumReturn = enumTemp;
                }
                else if (enumTemp == enumIsDataRemove_DataIsNil) {
                    return enumTemp;
                }
            }
        }
    }
    return enumReturn;
}

- (enumIsDataRemove)removeKardsWithKardsID:(NSString *)strID {
    if (!categoryArray || !strID) {
        return enumIsDataRemove_DataIsNil;
    }
    
    enumIsDataRemove enumReturn = enumIsDataRemove_NotExist;
    for (int i=0; i<[categoryArray count]; i++) {
		NSObject *objTemp = [categoryArray objectAtIndex:i];
        if ([[objTemp.class description] isEqualToString:[KardsCategoryData.class description]]) {
            enumIsDataRemove enumTemp = [((KardsCategoryData *)objTemp) removeCategoriesWithKardsID:strID];
            if (enumTemp == enumIsDataRemove_Successful) {
                enumReturn = enumTemp;
            }
            else if (enumTemp == enumIsDataRemove_DataIsNil) {
                return enumTemp;
            }
        }
        else if ([[objTemp.class description] isEqualToString:[KardsNodeData.class description]]) {
            if ([((KardsNodeData *)objTemp).kardsID isEqualToString:strID]) {
                [categoryArray removeObjectAtIndex:i];
                enumReturn = enumIsDataRemove_Successful;
                NSLog(@"Successful: %@", ((KardsNodeData *)objTemp).kardsName);
            }
        }
    }
    return enumReturn;
}

- (NSMutableArray *)AllCategoriesWithKardsID:(NSString *)strID {
	NSMutableArray *ma_Temp = [NSMutableArray new];
	
    if ([kardsID isEqualToString:strID]) {
        [ma_Temp addObject:self];
    }
	for (int i=0; i<[categoryArray count]; i++) {
		NSObject *objTemp = [categoryArray objectAtIndex:i];
		if ([[objTemp.class description] isEqualToString:[KardsCategoryData.class description]]) {
            if ([((KardsCategoryData *)objTemp).kardsID isEqualToString:strID]) {
                [ma_Temp addObject:objTemp];
            }
            else {
                [ma_Temp addObjectsFromArray:[((KardsCategoryData *)objTemp) AllCategoriesWithKardsID:strID]];
            }
		}
	}
	NSMutableArray *ma_Sort = [SupportFunction sortArray:ma_Temp withKey:@"kardsName"];
    return ma_Sort;
}

- (NSMutableArray *)AllKardsWithKardsID:(NSString *)strID {
	NSMutableArray *ma_Temp = [NSMutableArray new];
	
    for (int i=0; i<[categoryArray count]; i++) {
		NSObject *objTemp = [categoryArray objectAtIndex:i];
		if ([[objTemp.class description] isEqualToString:[KardsCategoryData.class description]]) {
			[ma_Temp addObjectsFromArray:[((KardsCategoryData *)objTemp) AllKardsWithKardsID:strID]];
		}
        else if ([[objTemp.class description] isEqualToString:[KardsNodeData.class description]]) {
            if ([((KardsNodeData *)objTemp).kardsID isEqualToString:strID]) {
                [ma_Temp addObject:objTemp];
            }
        }
	}
	NSMutableArray *ma_Sort = [SupportFunction sortArray:ma_Temp withKey:@"kardsName"];
    return ma_Sort;
}

- (NSMutableArray *)AllNode {
    NSMutableArray *ma_Temp = [NSMutableArray new];
	
	for (int i=0; i<[categoryArray count]; i++) {
		NSObject *objTemp = [categoryArray objectAtIndex:i];
		if ([[objTemp.class description] isEqualToString:[KardsCategoryData.class description]]) {
			[ma_Temp addObjectsFromArray:((KardsCategoryData *)objTemp).AllNode];
		}
		if ([[objTemp.class description] isEqualToString:[KardsNodeData.class description]]) {
			[ma_Temp addObject:(KardsNodeData *)objTemp];
		}
	}
	NSMutableArray *ma_Sort = [SupportFunction sortArray:ma_Temp withKey:@"kardsName"];
    return ma_Sort;
}

- (NSMutableArray *)CurrentNode {
    NSMutableArray *ma_Temp = [NSMutableArray new];
    
    for (int i=0; i<[categoryArray count]; i++) {
        NSObject *objTemp = [categoryArray objectAtIndex:i];
        if ([[objTemp.class description] isEqualToString:[KardsNodeData.class description]]) {
            [ma_Temp addObject:objTemp];
        }
    }
	NSMutableArray *ma_Sort = [SupportFunction sortArray:ma_Temp withKey:@"kardsName"];
    return ma_Sort;
}

- (NSMutableArray *)CurrentCategory {
    NSMutableArray *ma_Temp = [NSMutableArray new];
    
    for (int i=0; i<[categoryArray count]; i++) {
        NSObject *objTemp = [categoryArray objectAtIndex:i];
        if ([[objTemp.class description] isEqualToString:[KardsCategoryData.class description]]) {
            [ma_Temp addObject:objTemp];
        }
    }
	NSMutableArray *ma_Sort = [SupportFunction sortArray:ma_Temp withKey:@"kardsName"];
    return ma_Sort;
}

- (enumIsDataRemove)removeCategories:(KardsCategoryData *)node {
    if (!node) {
        return enumIsDataRemove_DataIsNil;
    }
    
    enumIsDataRemove enumReturn = enumIsDataRemove_NotExist;
    for (int i=0; i<[categoryArray count]; i++) {
        NSObject *objTemp = [categoryArray objectAtIndex:i];
        if ([[objTemp.class description] isEqualToString:[KardsCategoryData.class description]]) {
            if ((KardsCategoryData *)objTemp == node) {
                [categoryArray removeObjectAtIndex:i];
                enumReturn = enumIsDataRemove_Successful;
                NSLog(@"Successful: %@", ((KardsCategoryData *)objTemp).kardsName);
            }
            else {
                enumIsDataRemove enumTemp = [((KardsCategoryData *)objTemp) removeCategories:node];
                if (enumTemp == enumIsDataRemove_Successful) {
                    enumReturn = enumTemp;
                }
                else if (enumTemp == enumIsDataRemove_DataIsNil) {
                    return enumTemp;
                }
            }
        }
    }
    return enumReturn;
}

- (enumIsDataRemove)removeKards:(KardsNodeData *)node {
    if (!node) {
        return enumIsDataRemove_DataIsNil;
    }
    
    enumIsDataRemove enumReturn = enumIsDataRemove_NotExist;
    for (int i=0; i<[categoryArray count]; i++) {
		NSObject *objTemp = [categoryArray objectAtIndex:i];
        if ([[objTemp.class description] isEqualToString:[KardsCategoryData.class description]]) {
            enumIsDataRemove enumTemp = [((KardsCategoryData *)objTemp) removeKards:node];
            if (enumTemp == enumIsDataRemove_Successful) {
                enumReturn = enumTemp;
            }
            else if (enumTemp == enumIsDataRemove_DataIsNil) {
                return enumTemp;
            }
        }
        else if ([[objTemp.class description] isEqualToString:[KardsNodeData.class description]]) {
            if ((KardsNodeData *)objTemp == node) {
                [categoryArray removeObjectAtIndex:i];
                enumReturn = enumIsDataRemove_Successful;
                NSLog(@"Successful: %@", ((KardsNodeData *)objTemp).kardsName);
            }
        }
    }
    return enumReturn;
}

- (enumIsDataRemove)removeDataFromServer {
    enumIsDataRemove enumReturn = enumIsDataRemove_NotExist;
    for (int i=[categoryArray count]-1; i>=0; i--) {
		NSObject *objTemp = [categoryArray objectAtIndex:i];
        if ([[objTemp.class description] isEqualToString:[KardsCategoryData.class description]]) {
            if (((KardsCategoryData *)objTemp).isLocalCopyType == enumIsLocalCopyType_Copy) {
                enumIsDataRemove enumTemp = [((KardsCategoryData *)objTemp) removeDataFromServer];
                if (enumTemp == enumIsDataRemove_Successful) {
                    enumReturn = enumTemp;
                }
                else if (enumTemp == enumIsDataRemove_DataIsNil) {
                    return enumTemp;
                }
            }
            else {
                [categoryArray removeObject:objTemp];
            }
        }
        else if ([[objTemp.class description] isEqualToString:[KardsNodeData.class description]]) {
            if (((KardsNodeData *)objTemp).isLocalCopyType != enumIsLocalCopyType_Copy) {
                [categoryArray removeObject:objTemp];
            }
        }
    }
    return enumReturn;
}

- (void)resetAllData {
    NSLog(@"categoryArray count:%d",categoryArray.count);
    for (int i=[categoryArray count]-1; i>=0; i--) {
		NSObject *objTemp = [categoryArray objectAtIndex:i];
        if ([[objTemp.class description] isEqualToString:[KardsCategoryData.class description]]) {
            [((KardsCategoryData *)objTemp) resetAllData];
            [categoryArray removeObject:objTemp];
        }
        else if ([[objTemp.class description] isEqualToString:[KardsNodeData.class description]]) {
            [categoryArray removeObject:objTemp];
        }
    }
}

@end

#pragma mark - KardsTableData

@implementation KardsTableData
@synthesize categoryArray;

- (id)init {
    self = [super init];
    if (self) {
		categoryArray = [NSMutableArray new];
	}
	return self;
}

- (void)dealloc {
    [categoryArray removeAllObjects];
    categoryArray = nil;
}

- (enumIsDataRemove)removeCategoriesWithKardsID:(NSString *)strID {
    if (!categoryArray || !strID) {
        return enumIsDataRemove_DataIsNil;
    }
    
    enumIsDataRemove enumReturn = enumIsDataRemove_NotExist;
    for (int i=0; i<[categoryArray count]; i++) {
		NSObject *objTemp = [categoryArray objectAtIndex:i];
        if ([[objTemp.class description] isEqualToString:[KardsCategoryData.class description]]) {
            if ([((KardsCategoryData *)objTemp).kardsID isEqualToString:strID]) {
                [categoryArray removeObjectAtIndex:i];
                enumReturn = enumIsDataRemove_Successful;
                NSLog(@"Successful: %@", ((KardsCategoryData *)objTemp).kardsName);
            }
            else {
                enumIsDataRemove enumTemp = [((KardsCategoryData *)objTemp) removeCategoriesWithKardsID:strID];
                if (enumTemp == enumIsDataRemove_Successful) {
                    enumReturn = enumTemp;
                }
                else if (enumTemp == enumIsDataRemove_DataIsNil) {
                    return enumTemp;
                }
            }
        }
    }
    return enumReturn;
}

- (enumIsDataRemove)removeKardsWithKardsID:(NSString *)strID {
    if (!categoryArray || !strID) {
        return enumIsDataRemove_DataIsNil;
    }
    
    enumIsDataRemove enumReturn = enumIsDataRemove_NotExist;
    for (int i=0; i<[categoryArray count]; i++) {
		NSObject *objTemp = [categoryArray objectAtIndex:i];
        if ([[objTemp.class description] isEqualToString:[KardsCategoryData.class description]]) {
            enumIsDataRemove enumTemp = [((KardsCategoryData *)objTemp) removeCategoriesWithKardsID:strID];
            if (enumTemp == enumIsDataRemove_Successful) {
                enumReturn = enumTemp;
            }
            else if (enumTemp == enumIsDataRemove_DataIsNil) {
                return enumTemp;
            }
        }
        else if ([[objTemp.class description] isEqualToString:[KardsNodeData.class description]]) {
            if ([((KardsNodeData *)objTemp).kardsID isEqualToString:strID]) {
                [categoryArray removeObjectAtIndex:i];
                enumReturn = enumIsDataRemove_Successful;
                NSLog(@"Successful: %@", ((KardsNodeData *)objTemp).kardsName);
            }
        }
    }
    return enumReturn;
}

- (enumIsDataAdd)addNode:(KardsNodeData *)node {
    if (!categoryArray) {
        return eIsDataAddInvalid;
    }
    if (!node) {
        return eIsDataAddNull;
    }
    if ([categoryArray count] == 0) {
        [categoryArray addObject:node];
        return eIsDataAddSuccess;
    }
    else
    {
        // MinhPB 2012/10/12
        for (int i=0; i<[categoryArray count]; i++) {
            KardsNodeData *cjd_Temp = [categoryArray objectAtIndex:i];
            if ([cjd_Temp.kardsID isEqualToString:node.kardsID] ) 
                return eIsDataAddHasSameKardsIDInAGroup;
        }
        
        [categoryArray addObject:node];
        return eIsDataAddSuccess;
    }
}

- (enumIsDataAdd)addNode:(KardsNodeData *)node atKardsID:(NSString *)strID {
    if (!categoryArray || !strID) {
        return eIsDataAddInvalid;
    }
    if (!node) {
        return eIsDataAddNull;
    }
    for (int i=0; i<[categoryArray count]; i++) {
        KardsCategoryData *cjd_Temp = [categoryArray objectAtIndex:i];
        if ([cjd_Temp.kardsID isEqualToString:node.kardsID] ) 
            return eIsDataAddHasSameKardsIDInAGroup;
    }
    for (int i=0; i<[categoryArray count]; i++) {
        KardsCategoryData *cjd_Temp = [categoryArray objectAtIndex:i];
        enumIsDataAdd jda_Temp = [cjd_Temp addNode:node atKardsID:strID];
        if (jda_Temp == eIsDataAddSearchContinue) 
            continue;
        else
            return jda_Temp;
    }
    return eIsDataAddSearchFail;
}

- (enumIsDataAdd)addCategory:(KardsCategoryData *)node atKardsID:(NSString *)strID {
    if (!categoryArray || !strID) {
        return eIsDataAddInvalid;
    }
    if (!node) {
        return eIsDataAddNull;
    }
    for (int i=0; i<[categoryArray count]; i++) {
        KardsCategoryData *cjd_Temp = [categoryArray objectAtIndex:i];
        if ([cjd_Temp.kardsID isEqualToString:node.kardsID]) 
            return eIsDataAddHasSameKardsIDInAGroup;
    }
    for (int i=0; i<[categoryArray count]; i++) {
        KardsCategoryData *cjd_Temp = [categoryArray objectAtIndex:i];
        enumIsDataAdd jda_Temp = [cjd_Temp addCategory:node atKardsID:strID];
        if (jda_Temp == eIsDataAddSearchContinue) 
            continue;
        else
            return jda_Temp;
    }
    return eIsDataAddSearchFail;
}

- (enumIsDataAdd)addCategory:(KardsCategoryData *)node {
    if (!categoryArray || !node) {
        return eIsDataAddInvalid;
    }
    if (!node) {
        return eIsDataAddNull;
    }
    // MinhPB 2012/10/12
    for (int i=0; i<[categoryArray count]; i++) {
        KardsCategoryData *cjd_Temp = [categoryArray objectAtIndex:i];
        if ([cjd_Temp.kardsID isEqualToString:node.kardsID]) 
            return eIsDataAddHasSameKardsIDInAGroup;
    }
    
    [categoryArray addObject:node];
    return eIsDataAddSuccess;
}    

- (NSMutableArray *)AllCategoriesWithKardsID:(NSString *)strID {
    NSMutableArray *ma_Return = [NSMutableArray new];
    
    for (int i=0; i<[categoryArray count]; i++) {
		NSObject *objTemp = [categoryArray objectAtIndex:i];
        if ([[objTemp.class description] isEqualToString:[KardsCategoryData.class description]]) {
//            NSLog(@"((KardsCategoryData *)objTemp).kardsID %@", ((KardsCategoryData *)objTemp).kardsID);
            if ([((KardsCategoryData *)objTemp).kardsID isEqualToString:strID]) {
                [ma_Return addObject:objTemp];
            }
            else {
                [ma_Return addObjectsFromArray:[((KardsCategoryData *)objTemp) AllCategoriesWithKardsID:strID]];
            }
        }
    }
    return ma_Return;
}

- (NSMutableArray *)AllKardsWithKardsID:(NSString *)strID {
    NSMutableArray *ma_Return = [NSMutableArray new];
    
    for (int i=0; i<[categoryArray count]; i++) {
		NSObject *objTemp = [categoryArray objectAtIndex:i];
        if ([[objTemp.class description] isEqualToString:[KardsCategoryData.class description]]) {
            [ma_Return addObjectsFromArray:[((KardsCategoryData *)objTemp) AllKardsWithKardsID:strID]];
        }
        else if ([[objTemp.class description] isEqualToString:[KardsNodeData.class description]]) {
            if ([((KardsNodeData *)objTemp).kardsID isEqualToString:strID]) {
                [ma_Return addObject:objTemp];
            }
        }
    }
    return ma_Return;
}

- (NSMutableArray *)AllNode {
    NSMutableArray *ma_Return = [NSMutableArray new];
    
    for (int i=0; i<[categoryArray count]; i++) {
		NSObject *objTemp = [categoryArray objectAtIndex:i];
        if ([[objTemp.class description] isEqualToString:[KardsCategoryData.class description]]) {
            [ma_Return addObjectsFromArray:((KardsCategoryData *)objTemp).AllNode];
        }
    }
    return ma_Return;
}

- (NSMutableArray *)CurrentNode {
    NSMutableArray *ma_Return = [NSMutableArray new];
    
    for (int i=0; i<[categoryArray count]; i++) {
        NSObject *objTemp = [categoryArray objectAtIndex:i];
        if ([[objTemp.class description] isEqualToString:[KardsNodeData.class description]]) {
            [ma_Return addObject:objTemp];
        }
    }
    return ma_Return;
}

- (NSMutableArray *)CurrentCategory {
    NSMutableArray *ma_Return = [NSMutableArray new];
    
    for (int i=0; i<[categoryArray count]; i++) {
        NSObject *objTemp = [categoryArray objectAtIndex:i];
        if ([[objTemp.class description] isEqualToString:[KardsCategoryData.class description]]) {
            [ma_Return addObject:objTemp];
        }
    }
    return ma_Return;
}

- (void)resetAllData {
    for (int i=[categoryArray count]-1; i>=0; i--) {
		NSObject *objTemp = [categoryArray objectAtIndex:i];
        if ([[objTemp.class description] isEqualToString:[KardsCategoryData.class description]] && ![((KardsCategoryData *)objTemp).kardsID isEqualToString:STRING_NAME_DECK_KARDS_ME] && ![((KardsCategoryData *)objTemp).kardsID isEqualToString:STRING_NAME_DECK_MY_DEAL]) {
            [((KardsCategoryData *)objTemp) resetAllData];
            [categoryArray removeObject:objTemp];
        }
        else if ([[objTemp.class description] isEqualToString:[KardsNodeData.class description]]) {
            [categoryArray removeObject:objTemp];
        }
    }
}

- (enumIsDataRemove)removeCategories:(KardsCategoryData *)node {
    if (!node) {
        return enumIsDataRemove_DataIsNil;
    }
    
    enumIsDataRemove enumReturn = enumIsDataRemove_NotExist;
    for (int i=0; i<[categoryArray count]; i++) {
        NSObject *objTemp = [categoryArray objectAtIndex:i];
        if ([[objTemp.class description] isEqualToString:[KardsCategoryData.class description]]) {
            if ((KardsCategoryData *)objTemp == node) {
                [categoryArray removeObjectAtIndex:i];
                enumReturn = enumIsDataRemove_Successful;
                NSLog(@"Successful: %@", ((KardsCategoryData *)objTemp).kardsName);
            }
            else {
                enumIsDataRemove enumTemp = [((KardsCategoryData *)objTemp) removeCategories:node];
                if (enumTemp == enumIsDataRemove_Successful) {
                    enumReturn = enumTemp;
                }
                else if (enumTemp == enumIsDataRemove_DataIsNil) {
                    return enumTemp;
                }
            }
        }
    }
    return enumReturn;
}

- (enumIsDataRemove)removeKards:(KardsNodeData *)node {
    if (!node) {
        return enumIsDataRemove_DataIsNil;
    }
    
    enumIsDataRemove enumReturn = enumIsDataRemove_NotExist;
    for (int i=0; i<[categoryArray count]; i++) {
		NSObject *objTemp = [categoryArray objectAtIndex:i];
        if ([[objTemp.class description] isEqualToString:[KardsCategoryData.class description]]) {
            enumIsDataRemove enumTemp = [((KardsCategoryData *)objTemp) removeKards:node];
            if (enumTemp == enumIsDataRemove_Successful) {
                enumReturn = enumTemp;
            }
            else if (enumTemp == enumIsDataRemove_DataIsNil) {
                return enumTemp;
            }
        }
        else if ([[objTemp.class description] isEqualToString:[KardsNodeData.class description]]) {
            if ((KardsNodeData *)objTemp == node) {
                [categoryArray removeObjectAtIndex:i];
                enumReturn = enumIsDataRemove_Successful;
                NSLog(@"Successful: %@", ((KardsNodeData *)objTemp).kardsName);
            }
        }
    }
    return enumReturn;
}

- (enumIsDataRemove)removeDataFromServer {
    enumIsDataRemove enumReturn = enumIsDataRemove_NotExist;
    for (int i=[categoryArray count]-1; i>=0; i--) {
		NSObject *objTemp = [categoryArray objectAtIndex:i];
        if ([[objTemp.class description] isEqualToString:[KardsCategoryData.class description]]) {
            if (((KardsCategoryData *)objTemp).isLocalCopyType == enumIsLocalCopyType_Copy) {
                enumIsDataRemove enumTemp = [((KardsCategoryData *)objTemp) removeDataFromServer];
                if (enumTemp == enumIsDataRemove_Successful) {
                    enumReturn = enumTemp;
                }
                else if (enumTemp == enumIsDataRemove_DataIsNil) {
                    return enumTemp;
                }
            }
            else {
                [categoryArray removeObject:objTemp];
            }
        }
        else if ([[objTemp.class description] isEqualToString:[KardsNodeData.class description]]) {
            if (((KardsNodeData *)objTemp).isLocalCopyType != enumIsLocalCopyType_Copy) {
                [categoryArray removeObject:objTemp];
            }
        }
    }
    return enumReturn;
}

@end

#pragma mark - KardsDataManager

@implementation KardsDataManager

- (id)init {
    self = [super init];
    if (self) {
        rootData = [[KardsTableData alloc] init];
    }
    return self;
}

- (enumIsDataAdd)addNode:(KardsNodeData *)node {
    if (!rootData) {
        return eIsDataAddInvalid;
    }
    if (!node) {
        return eIsDataAddNull;
    }
    return [rootData addNode:node];
}

- (enumIsDataAdd)addNode:(KardsNodeData *)node atKardsID:(NSString *)strID {
    if (!rootData || !node || !strID) {
        return eIsDataAddInvalid;
    }
    if (!node) {
        return eIsDataAddNull;
    }
    return [rootData addNode:node atKardsID:strID];
}

- (enumIsDataAdd)addCategory:(KardsCategoryData *)node {
    if (!rootData) {
        return eIsDataAddInvalid;
    }
    if (!node) {
        return eIsDataAddNull;
    }
    return [rootData addCategory:node];
}

- (enumIsDataAdd)addCategory:(KardsCategoryData *)node atKardsID:(NSString *)strID {
    if (!rootData || !node || !strID) {
        return eIsDataAddInvalid;
    }
    if (!node) {
        return eIsDataAddNull;
    }
    if ([node.kardsID isEqualToString:strID]) {
        return eIsDataAddHasSameKardsIDInAGroup;
    }
    return [rootData addCategory:node atKardsID:strID];
}

- (enumIsDataRemove)removeCategoriesWithKardsID:(NSString *)strID {
    if (!strID) {
        return enumIsDataRemove_DataIsNil;
    }
    return [rootData removeCategoriesWithKardsID:strID];
}

- (enumIsDataRemove)removeKardsWithKardsID:(NSString *)strID {
    if (!strID) {
        return enumIsDataRemove_DataIsNil;
    }
    return [rootData removeKardsWithKardsID:strID];
}

- (void)dealloc {
    rootData = nil;
}

- (NSMutableArray *)AllCategoriesWithKardsID:(NSString *)strID {
    NSMutableArray *ma_Temp = [rootData AllCategoriesWithKardsID:strID];
//    NSLog(@"rootData.AllKardsHasKardsID = %i",[ma_Temp count]);
    NSMutableArray *ma_Sort = [SupportFunction sortArray:ma_Temp withKey:@"kardsName"];
    return ma_Sort;
}

- (NSMutableArray *)AllKardsWithKardsID:(NSString *)strID {
    NSMutableArray *ma_Temp = [rootData AllKardsWithKardsID:strID];
//    NSLog(@"rootData.AllKardsHasKardsID = %i",[ma_Temp count]);
    NSMutableArray *ma_Sort = [SupportFunction sortArray:ma_Temp withKey:@"kardsName"];
    return ma_Sort;
}

- (NSMutableArray *)AllNode {
    // sort and remove the same id
    NSMutableArray *ma_Temp = rootData.AllNode;
//    NSLog(@"rootData.AllNode = %i",[ma_Temp count]);
    for (int i=0;i<[ma_Temp count];i++) {
        KardsNodeData *njd_Temp1 = [ma_Temp objectAtIndex:i];
        for (int j=i+1;j<[ma_Temp count];j++) {
            KardsNodeData *njd_Temp2 = [ma_Temp objectAtIndex:j];
            if ([njd_Temp1.kardsID isEqualToString:njd_Temp2.kardsID]) {
                [ma_Temp removeObjectAtIndex:i];
                i--;
                NSLog(@"contact has the same user id: %@", njd_Temp2.kardsID);
                continue;
            }
        }
    }
    NSMutableArray *ma_Sort = [SupportFunction sortArray:ma_Temp withKey:@"kardsName"];
    return ma_Sort;
}

- (NSMutableArray *)CurrentNode {
    // sort and remove the same id
    NSMutableArray *ma_Temp = rootData.CurrentNode;
//    NSLog(@"rootData.CurrentNode = %i",[ma_Temp count]);
    NSMutableArray *ma_Sort = [SupportFunction sortArray:ma_Temp withKey:@"kardsName"];
    return ma_Sort;
}

- (NSMutableArray *)CurrentCategory {
    // sort and remove the same id
    NSMutableArray *ma_Temp = rootData.CurrentCategory;
//    NSLog(@"rootData.CurrentCategory = %i",[ma_Temp count]);
    NSMutableArray *ma_Sort = [SupportFunction sortArray:ma_Temp withKey:@"kardsName"];
    return ma_Sort;
}

- (NSMutableArray *)categoryArray {
    // sort and remove the same id
    NSMutableArray *ma_Temp = rootData.categoryArray;
//    NSLog(@"rootData.categoryArray = %i",[ma_Temp count]);
    return ma_Temp;
}

- (KardsCategoryData *)getMECategory {
	NSMutableArray *arrayTemp = [[KardsDataManager kardsShared] AllCategoriesWithKardsID:STRING_NAME_DECK_KARDS_ME];
	if (arrayTemp.count > 0) {
		return [arrayTemp objectAtIndex:0];
	}
	else {
//		ALERT(@"getMECategory", @"DATA is nil");
		return nil;
	}
}

- (KardsCategoryData *)getDealCategory
{
    NSMutableArray *arrayTemp = [[KardsDataManager kardsShared] AllCategoriesWithKardsID:STRING_NAME_DECK_MY_DEAL];
	if (arrayTemp.count > 0) {
		return [arrayTemp objectAtIndex:0];
	}
	else {
        //		ALERT(@"getMECategory", @"DATA is nil");
		return nil;
	}
}

- (NSString *)getNewCategoryID {
	return @"";
}

- (void)resetAllData {
    [rootData resetAllData];
}

- (enumIsDataRemove)removeCategories:(KardsCategoryData *)node {
    if (!node) {
        return enumIsDataRemove_DataIsNil;
    }
    return [rootData removeCategories:node];
}

- (enumIsDataRemove)removeKards:(KardsNodeData *)node {
    if (!node) {
        return enumIsDataRemove_DataIsNil;
    }
    return [rootData removeKards:node];
}

- (enumIsDataRemove)removeDataFromServer {
    return [rootData removeDataFromServer];
}

/////////////////////////////////

static KardsDataManager *_kardsShared;
+ (KardsDataManager *)kardsShared {
    if ( !_kardsShared ) {
        _kardsShared = [[KardsDataManager alloc] init];
    }
    return _kardsShared;
}

static KardsDataManager *_konnectShared;
+ (KardsDataManager *)konnectShared {
    if ( !_konnectShared ) {
        _konnectShared = [[KardsDataManager alloc] init];
    }
    return _konnectShared;
}
static KardsDataManager *_konnectPersonalShared;
+ (KardsDataManager *)konnectPersonalShared
{
    if (!_konnectPersonalShared) {
        _konnectPersonalShared = [[KardsDataManager alloc] init];
    }
    return _konnectPersonalShared;
}
static KardsDataManager *_konnectBusinessesShared;
+ (KardsDataManager *)konnectBusinessesShared
{
    if (!_konnectBusinessesShared) {
        _konnectBusinessesShared = [[KardsDataManager alloc] init];
    }
    return _konnectBusinessesShared;
}
static KardsDataManager *_konnectEventsShared;
+ (KardsDataManager *)konnectEventsShared
{
    if (!_konnectEventsShared) {
        _konnectEventsShared = [[KardsDataManager alloc] init];
    }
    return _konnectEventsShared;
}
static KardsDataManager *_konnectPlacesShared;
+ (KardsDataManager *)konnectPlacesShared
{
    if (_konnectPlacesShared) {
        _konnectPlacesShared = [[KardsDataManager alloc] init];
    }
    return _konnectPlacesShared;
}
static KardsDataManager *_konnectCustomShared;
+ (KardsDataManager *)konnectCustomShared
{
    if (_konnectCustomShared) {
        _konnectCustomShared = [[KardsDataManager alloc] init];
    }
    return _konnectCustomShared;
}

static KardsDataManager *_konnectPendingShared;
+ (KardsDataManager *)konnectPendingShared
{
    if (!_konnectPendingShared) {
        _konnectPendingShared = [[KardsDataManager alloc] init];
    }
    return _konnectPendingShared;
}

static KardsDataManager *_konnectSearchShared;
+ (KardsDataManager *)konnectSearchShared
{
    if (!_konnectSearchShared) {
        _konnectSearchShared = [[KardsDataManager alloc] init];
    }
    return _konnectSearchShared;
}

static KardsDataManager *_konnectHomeShared;
+ (KardsDataManager *)konnectHomeShared
{
    if (!_konnectHomeShared) {
        _konnectHomeShared = [[KardsDataManager alloc] init];
    }
    return _konnectHomeShared;
}

static KardsDataManager *_dealsShared;
+ (KardsDataManager *)dealsShared{
    if (!_dealsShared) {
        _dealsShared = [[KardsDataManager alloc] init];
    }
    return _dealsShared;
}

static KardsDataManager *_feedsShared;
+ (KardsDataManager *)feedsShared{
    if (!_feedsShared) {
        _feedsShared = [[KardsDataManager alloc] init];
    }
    return _feedsShared;
}

static KardsDataManager *_feedsCommentsShared;
+ (KardsDataManager *)feedsCommentsShared{
    if (!_feedsCommentsShared) {
        _feedsCommentsShared = [[KardsDataManager alloc] init];
    }
    return _feedsCommentsShared;
}

static KardsDataManager *_actMyDealsShared;
+ (KardsDataManager *)actMyDealsShared
{
    if (!_actMyDealsShared) {
        _actMyDealsShared = [[KardsDataManager alloc] init];
    }
    return _actMyDealsShared;
}

static KardsDataManager *_preMyDealsShared;
+ (KardsDataManager *)preMyDealsShared
{
    if (!_preMyDealsShared) {
        _preMyDealsShared = [[KardsDataManager alloc] init];
    }
    return _preMyDealsShared;
}

static KardsDataManager *_nearDealsShared;
+ (KardsDataManager *)dealNearLocationShared
{
    if (!_nearDealsShared){
        _nearDealsShared = [[KardsDataManager alloc] init];
    }
    return _nearDealsShared;
}

@end
