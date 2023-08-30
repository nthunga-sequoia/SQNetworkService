//
//  GeneralConstants.swift
//  Sequoia
//
//  Copyright © 2016 YMediaLabs. All rights reserved.
//

import Foundation
import UIKit

///These public generic comparable are usefull in for any non optional value & optioanl vlaue comparisions in whole project. Like, if we need to compare a optional textfiled length to a zero value, use need to force unwrap  the optioanl vlaue (ex: textField.text!.length >= 0 ). But in this case, direct optioanl value compare also will work (ex: textField.text?.length >= 0).
public func < <T: Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?): 
        return l < r
    case (nil, _?): 
        return true
    default: 
        return false
    }
}

public func >= <T: Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?): 
        return l >= r
    default: 
        return !(lhs < rhs)
    }
}

public func > <T: Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?): 
        return l > r
    default: 
        return rhs < lhs
    }
}

/// These methods are used to get unique elements of any type in any sequence type.
public extension Sequence where Iterator.Element: Hashable {
    var uniqueElements: [Iterator.Element] {
        return Array(
            Set(self)
        )
    }
}

extension Array {

    func uniques<T: Hashable>(by keyPath: KeyPath<Element, T>) -> [Element] {
        return reduce([]) { result, element in
            let alreadyExists = (result.contains(where: { $0[keyPath: keyPath] == element[keyPath: keyPath] }))
            return alreadyExists ? result : result + [element]
        }
    }
}

public extension Sequence where Iterator.Element: Equatable {
    var uniqueElements: [Iterator.Element] {
        return self.reduce([]) { uniqueElements, element in
            
            uniqueElements.contains(element)
                ? uniqueElements
             : uniqueElements + [element]
        }
    }
}

/// This method returns a dictionary of values in an array mapping to the
/// total number of occurrences in the array.
///
/// - parameter array: The array to source from.
/// - returns: Dictionary that contains the key generated from the element passed in the function.
public func frequencies<T>(_ array: [T]) -> [T: Int] {
    return frequencies(array) { $0 }
}

/// This method returns a dictionary of values in an array mapping to the
/// total number of occurrences in the array. If passed a function it returns
/// a frequency table of the results of the given function on the arrays elements.
///
/// - parameter array: The array to source from.
/// - parameter function: The function to get value of the key for each element to group by.
/// - returns: Dictionary that contains the key generated from the element passed in the function.
private func frequencies<T, U>(_ array: [T], function: (T) -> U) -> [U: Int] {
    var result = [U: Int]()
    for elem in array {
        let key = function(elem)
        if let freq = result[key] {
            result[key] = freq + 1
        } else {
            result[key] = 1
        }
    }
    return result
}

var isNetworkAvailable: Bool {
    return NetworkManager.reachability?.isReachable ?? false
}
/*
let log: SQLogger? = {
    #if DEBUG || DEV || TESTSERVER
        return SQLogger()
    #else
        return nil
    #endif
}()
*/
let tempDirectoryURL: URL = {
    let url = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
    return url
}()

let documentsDirectory: URL = {
    let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return urls[urls.endIndex - 1]
}()

let cacheDirectoryUrl: URL = {
    let urls = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
    return urls[urls.endIndex - 1]
}()

let cacheDirectory: String = {
    let paths = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)
    let cacheDirectory = paths.isEmpty == false ? paths[0]: ""
    return cacheDirectory
}()

let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
let appBuildNumber = Bundle.main.infoDictionary?[kCFBundleVersionKey as String] as? String

open class GeneralConstants {
    // MARK: - Global Constants
    static let bundleIdentifier = "com.sequoia.ios"
    static let enterpriseBundleIdentifier = "com.sequoia.ios.sequoiaapp.adhoc"
    static let debugBundleIdentifier = "com.sequoia.ios.betaDevMobile"
    static let wkWebviewCookies = "wkWebviewCookies"
    static let wkWebviewPool = "wkWebviewPool"
    
    static let clearDataTillOldBuildNumberBeta = 1090
    static let clearDataTillOldBuildNumberProd = 1088
    static let shouldDeleteAllDataOnce = true

    static let iosAppBitlyLink = "https://bit.ly/sequoiam"
    static let androidAppBitlyLink = "https://bit.ly/sequoiama"
    static let appLink = "https://itunes.apple.com/us/app/sequoia-mobile/id1185900896?ls=1&mt=8"
    static let sequoiaTerms = "https://docs.google.com/document/d/1tWMbxw-nS5bu6SiujligqR5cEk3PW5yj/edit?usp=share_link&ouid=104163799108510763987&rtpof=true&sd=true"
    static let sequoiaPrivacyPolicy = "https://docs.google.com/document/d/1a3vVKNcwjL96wSAUwpOGmovCX_kEI0Dt/edit?usp=sharing&ouid=104163799108510763987&rtpof=true&sd=true"
    static let aboutSequoiaURL = "https://www.sequoia.com/about/"
    static let sequoiaLogo = "https://s3.amazonaws.com/sequoia-static-files/sequoia-company-logos/app_logo%403x.png"
    static let micrositeHelp = "https://px-web-staging.sequoia-development.com/help"
    static let AppId = "1185900896"
    static let appleTestEmailId = "s1demo@sequoia.com"
    
    static let sequoiaWorkLifePortal = "https://seqee.prismhr.com/seq/cmd/login"
    static let splashViewTag: Int = 1000
    
    static let faqHealthCare: String = "/help/pir/faq?topic=healthcare"
    static let faqWellBeing: String = "/help/pir/faq?topic=wellbeing"
    static let faqIncomeProtection: String = "/help/pir/faq?topic=income-protection"
    static let faqTaxSavings: String = "/help/pir/faq?topic=tax-saving"
    static let faqRetirement: String = "/help/pir/faq?topic=retirement"
    static let faqGlobalTravel: String = "/help/pir/faq?topic=global-travel"
    static let faqDefaultURL: String = "/help/pir/faq"
    
    static let healthCare = "HealthCare"
    static let wellbeings = "Wellbeing"
    static let incomeProtection = "Income Protection"
    static let taxsavings = "Tax Savings"
    static let retirement = "Retirement"
    static let globalTravel = "Global Travel"
    
    static let servertypeTitleDict: [Int: String] = [1: "Production", 2: "Staging", 3: "Integration", 4: "Development", 5: "Pre-Production", 7: "Pre-Production2"]
    static let serverName = "Server"
    
    static let fullScreenHeight = UIScreen.main.bounds.size.height
    static let iPhoneXSafeAreaHeight = GeneralConstants.fullScreenHeight - GeneralConstants.iPhoneXHomeIndicatorHeight - GeneralConstants.iPhoneXStatusBarHeight
    static let screenSafeAreaHeight = UIDevice.current.isIphoneXOrAbove == true ? GeneralConstants.iPhoneXSafeAreaHeight : GeneralConstants.fullScreenHeight

    //As everywhere in the whole app we are using screenHeight, I modified the value in such a way to use this height as height needed for calculations, but not for showing any view on full screen, for that we should use fullScreenHeight variable
    static let screenHeight = UIDevice.current.isIphoneXOrAbove == true ? (UIScreen.main.bounds.size.height - GeneralConstants.iPhoneXHomeIndicatorHeight): UIScreen.main.bounds.size.height
    public static let screenWidth = UIScreen.main.bounds.size.width
    static let currentScreenBounds = CGRect(origin: CGPoint.zero, size: CGSize(width: screenWidth, height: screenHeight))
    static let navigaionbarConstantHeight: CGFloat = 64
    static let navigaionbarTitleMaxWidth: CGFloat = 0.46666666 * GeneralConstants.screenWidth //This ratio defined by considering iphone6s 175 constant width 175/375 = 0.46666666
    
    static let defaultAnimationDuration: Double = 0.25
    static let defaultDismissAnimationDuration: Double = 0.25
    static let defaultHeightToAnimate: CGFloat = 20
    static let activationRetryTimer: Double = 5
    static let acitiveSessionTimeDiff: Int = 900 // 900 seconds
    static let maximumSessionExpirationDays: Int = 60 // 60 days
    
    static let caseCreationMaxFileSize: Double = 10 // its 1MB
    static let claimCreationMaxFileSize: Double = 10 // its 10MB

    static let primaryUserAcceptConsent: String = "ID card access needs consent by "
    static let networkErrorMsg = "Server is not reachable, please try after sometime.".localized()
    static let downloadFailedErrorMsg = "Sorry, we are experiencing a problem retrieving your ID Card. If this persists, contact app support."
    static let invalidPasswordError = "Something went wrong, please login with password."
    static let noNetworkErrorCode = 600
    static let deviceInternetErrorCode = -1009
    static let phonecallErrorMessage = "Your mobile device is not set up to make phone calls. Please enable on your device."
    static let doctorOfficePlanDetailFooterText = "See your carrier plan summary for full benefit information. View plan summary"
    static let planDetailFooterText = "Coinsurance that's a percentage of the bill will only be active once you've met your deductible. Until then, you'll pay the full bill out of pocket. Fixed amount copays are what you can expect to pay regardless of your deductible."
    static let planDetailFooterActionSubString = "View plan summary"
    static let bAUExperienceMessage = "Great News! We have received all your enrollments and have switched you to the full Sequoia App experience."
    
    static let idCardOnlyExperienceMessage1 = "Since you did not take action during open enrollment, your elections are being carried over from last plan year and are still in process."
    static let idCardOnlyExperienceMessage2 = "\nYour previous plan year’s ID card is being displayed.\n"
    static let idCardOnlyExperienceMessage3 = "Please allow approximately two weeks for your updates to be processed."
    
    static let idCardOnlyExperienceForNonS1Message1 = "Carriers have processed your {year} elections, however your Member information is still in progress. Your prior plan year’s ID card is displayed."
    static let idCardOnlyExperienceForNonS1Message2 = "\nYou can use your prior plan year’s card if you did not change your elections.\n"
    static let idCardOnlyExperienceForNonS1Message3 = "Please allow approximately two weeks for your updates to be processed."
    
    static let reUploadMessage = "Looks like you have uploaded an ID card. Since you have changed your bookmark, please make sure you have the right ID card uploaded"
    
    // MARK: - NOTIFICATION OBSERVER KEY CONSTANTS -
    static let forceUpgradeObserverKey = "forceUpgrade"
    static let modelAuthenticationCompletionObserver = "modelAuthenticationCompleted"
    static let refreshTabBarControl = "refreshTabBarControl"
    static let registeredForRemoteNotifications = "registeredForRemoteNotifications"
    static let failedToRegisterForRemoteNotifications = "failedToRegisterForRemoteNotifications"
    static let walkThroughCompletionObserver = "walkThroughCompleted"
    static let pushNotificationRecieved = "pushNotificationRecieved"
    static let rightwayPushNotificationRecieved = "rightwayPushNotificationRecieved"
    static let rightwayRxPushNotificationRecieved = "rightwayRxPushNotificationRecieved"
    static let originAppPushNotificationRecieved = "originAppPushNotificationRecieved"
    static let userBenefitsReceived = "userBenefitsReceived"
    static let spotLightActionRecieved = "spotLightActionRecieved"
    static let universalLinkReceived = "universalLinkReceived"
    static let manualLogout = "manualLogout"
    static let callDisconnect = "CallDisconnected"
    static let payrollDataModelUpdate = "payrollDataModelUpdate"
    static let planBookmarked = "planBookmarked"
    static let dbCacheCleared = "dbCacheCleared"
    static let dashboradAnimationFinished = "dashboradAnimationFinished"
    static let dashboradProfileAnimationStarted = "dashboradProfileAnimationStarted"
    static let lastReservationLocation = "lastReservationLocation"
    static let isSequoiaConsentNotPresent = "isSequoiaConsentNotPresent"
    static let isConsentToBeShownPending = "isConsentToBeShownPending"
    static let micrositeApiCompleted = "micrositeApiCompleted"
    static let isNewVersionEnabledForGlobalNativeDashboard = "isNewVersionEnabledForGlobalNativeDashboard"
    static let transactionalFeatureFlagEnabledValue = "transactionalFeatureFlagEnabledValue"
    static let transactionalFeatureUIComponents = "transactionalFeatureUIComponents"
    static let newBadgeDataProcessed = "newBadgeDataProcessed"
    static let workplaceDefaultStartTime = "workplaceDefaultStartTime"
    static let workplaceDefaultEndTime = "workplaceDefaultEndTime"
    static let wellbeingReviewDiscussPosted = "wellbeingReviewDiscussPosted"
    static let refreshQuickLinks = "refreshQuickLinks"
    static let refreshForYou = "refreshForYou"
    static let showAlertForIDCardOnly = "showAlertForIDCardOnly"
    
    static let dashboardCapabilityAPIReturned = "dashboardCapabilityAPIReturned"
    
    // MARK: - Old Cache Data to be cleared for new update
    static let isOldCacheDataCleared = "isOldCacheDataCleared"
    static let lastBuildNumber = "lastBuildNumber"

    // MARK: All Regular expression constants
    static let emailIdRegExp: String = "^[a-zA-Z0-9_\\+-~`!#$%^&\\*()_=']+(\\.[a-zA-Z0-9_\\+-~`!#$%^&\\*()_=']+)*@[a-zA-Z0-9-]+(\\.[a-zA-Z0-9-]+)*\\.([a-zA-Z]{2,10})$"//"^(.*)*@[a-zA-Z0-9-]+(\\.[a-zA-Z0-9-]+)*\\.([a-zA-Z]{2,10})$"
    static let passwordRegExp: String = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$"//"^.*(?=.{8,40})(?=.*\\d)(?=.*[a-zA-Z])(?=.*[@#$%&]).*$"
//"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$"
    static let zipCodeRegExp: String = "^[0-9]{5}(-[0-9]{4})?$"
    
    // MARK: Coredata constants
    static let coreDataModelName = "Sequoia"
    
    // MARK: - DashBoard Constants
    static let callDashboardApis = "callDashboardApis"

    // MARK: - Userdefaults constants
    static let biometricType = UIDevice.current.isIphoneXOrAbove == true ? "FaceID" : "TouchId"
    static let isNewTabBarLoaded = "NewTabBarLoaded"
    static let skipMFE = "mfeSkipped"
    static let iSBiometricAuthenticationEnabled = "iSBoimetricAuthenticationEnabled"
    static let isBiometricVerificationCompleted = "isBoimetricVerificationCompleted"
    static let isPasswordChanged = "isPasswordChanged"
    static let iSTouchIdEnabled = "iSTouchIdEnabled"
    static let iSTouchIdKeyChanged = "iSTouchIdKeyChanged"
    static let isTouchIdVerificationCompleted = "isTouchIdVerificationCompleted"
    static let isDependant = "isDependant"
    static let isNotFreshAppInstallation = "isNotFreshAppInstallation"
    static let isDashboardObserverAdded = "isDashboardObserverAdded"
    static let isNewUser = "isNewUser"
    static let lastInActiveTime = "lastInActiveTime"
    static let existingGlobalUserLogin = "existingGlobalUserLogin"
    static let isTempAuthenticationShown = "isTempAuthenticationShown"
    static let recentSearchKey = "recentSearchs"
    static let isPushNotificationsRegistered = "isPushNotificationsRegistered"
    static let deviceToken = "deviceToken"
    static let pushNotificationStatus = "pushNotificationStatus"
    static let emailOptOutStatus = "sendEmailStatus"
    static let loggedInAsPreviousUser = "loggedInAsPreviousUser"
    static let biometricShown = "biometricShown"
    static let isNotificationRegistered = "isNotificationRegistered"
    static let isLightVideoBackground = "isLightVideoBackground"
    static let isFirstAppWalkThroughCompleted = "isFirstAppWalkThroughCompleted"
    static let isAnimationAppWalkThroughCompleted = "isAnimationAppWalkThroughCompleted"
    static let imageIndex = "ImageIndex"
    static let selectedServerType = "selectedServerType"
    static let selectedAWSType = "selectedAWSType"
    static let appTerminated = "appTerminated"
    static let notificationUserinfo = "notificationUserinfo"
    static var localUrl: String = "localUrl"
    static let whatsNewBuildKey = "whatsNewBuildKey"
    static let alreadyReviewed = "alreadyReviewed"
    static let nextReviewTimeStamp = "nextReviewTimeStamp"
    static let inAppNextReviewTimeStamp = "inAPPNextReviewTimeStamp"
    static let dailyReviewTimeStamp = "dailyReviewTimeStamp"
    static let reviewDict = "reviewDict"
    static let shouldNotSortApplicableCatgeories = "shouldNotSortApplicableCatgeories"
    static let dataBaseVersion = "dataBaseVersion"
    static let showPreOEBanner = "showPreOEBanner"
    static let preOEBannerThumbnailURL = "preOEBannerThumbnailURL"
    static let preOEBannerDescription  = "preOEBannerDescription"
    static let finishedShowingPreOEBanner = "finishedShowingPreOEBanner"
    static let appExperience = "appExperience"
    static let idCardExperience = "idCardExperience"
    static let uiExperience = "uiExperience"
    static let showDoctorDeleteTutorial = "showDoctorDeleteTutorial"
    static let isdoctorSaveOptionViewed = "isdoctorSaveOptionViewed"
    
    // MARK: - Authentication Constants
    static let signInTitle = "Welcome Back".localized()
    static let emailPlaceHolderText = "company email".localized()
    static let passwordPlaceHolderText = "password".localized()
    static let secureCodeEmployeeDescription = "Awesome! We sent a code to you".localized()
    static let DOBPlaceholderText = "Enter your Date of Birth MM/DD/YYYY".localized()
    static let DOBFormatString = "MM/DD/YYYY".localized()
    static let InProcessWithText = "In Process with "
    static let InProcessText = "In Process "
    static let oldValue = "oldValue"
    static let newValue = "newValue"
    
    static let basicPlanDescription: String = "These insurance plans are offered by your employer, Bookmark a plan for easy reference and access to associated contacts."
    static let singleBasicPlanDescription: String = "This insurance plan is offered by your employer. Reference plan information and access associated contacts."

    // MARK: - Generic validation constants
    static let invalidInformationErrorCode = 1900
    static let downloadFailureErrorCode = 1901
    static let emptyResponseErrorCode = 1902
    static let emptyResponseErrorDomain = "EmptyResponseErrorDomain"
    static let coredataErrorDomain = "CoreDataErrorDomain"
    static let validationErrorDomain      = "validationErrorDomain"
    static let noNetworkErrorDomain = "noNetworkErrorDomain"
    static let emailValidationErrorDomain = "emailValidationErrorDomain"
    static let zipCodeValidationErrorDomain = "zipCodeValidationErrorDomain"
    static let phoneNumberValidationErrorDomain = "phoneNumberValidationErrorDomain"
    static let passwordValidationErrorDomain = "passwordValidationErrorDomain"
    static let confirmEmailValidationErrorDomain = "confirmEmailValidationErrorDomain"
    static let generalResponseErrorDomain = "generalResponseErrorDomain"
    static let lastNameValidationErrorDomain = "lastNameValidationErrorDomain"
    static let firstNameValidationErrorDomain = "firstNameValidationErrorDomain"
    static let invalidNameValidationErrorDomain = "invalidNameValidationErrorDomain"
    static let dobValidationErrorDomain = "dobValidationErrorDomain"
    static let dependentSignupError = " dependentSignupErrorDomain"
    static let downloadFailureErrorDomain = "downloadFailureErrorDomain"
    static let mobileUserNameMismatchErrorDomain = "mobileUserNameMismatchErrorDomain"
    static let oldUserEmailErrorDomain = "oldUserEmailErrorDomain"
    static let emptySSOLinkErrorDomain = "emptySSOLinkErrorDomain"
    static let passwordMismatch = "passwordMismatch"
    static let emptyEmailErrorMsg         = "Please enter your email address.".localized()
    static let invalidEmailErrorMsg       = "The email address entered is invalid. Please re-enter.".localized()
    static let invalidZipCodeErrorMsg       = "Please enter a valid zip code.".localized()
    static let invalidPasswordErrorMsg       = "Your password must be 8+ characters and contain a lowercase letter, an uppercase letter, a number and no parts of your work email.".localized()
    static let emptyPasswordErrorMsg      = "Please enter your password.".localized()
    static let validInformationErrorMsg     = "The information entered is invalid.".localized()
    static let changeEmailSameErrorMsg      = "The email addresses you entered do not match, please make sure you typed your email address correctly.".localized()
    static let changePasswordSameErrorMsg   = "The passwords do not match. Please re-enter.".localized()
    static let updatePasswordSameErrorMsg       = "The old password and new password cannot be the same. Please enter a different new password.".localized()
    static let emptyDOBErrorMsg         = "Please Enter Your DOB".localized()
    static let emptyFirstNameErrorMsg         = "Please Enter Your First Name".localized()
    static let emptyLastNameErrorMsg         = "Please Enter Your Last Name".localized()
    static let invalidDOBErrorMsg = "Please re-enter a valid date.".localized()
    static let invalidNameErrorMsg = "Please re-enter a valid name.".localized()
    static let invalidFirstNameErrorMsg = "Please re-enter a valid first name.".localized()
    static let invalidLastNameErrorMsg = "Please re-enter a valid last name.".localized()
    static let memberIDExistsMsg = "Member ID already exists. Please re-enter to update."
    static let iDCardActivationText = "Your Digital ID Card is fully populated with your current plan information and is shareable via email or text. You can also add it to your Apple Wallet.\n\nYour Digital ID Card will replace stored images of your physical card."
    static let emptySSOlinkErrorMsg = "Oops there seems to be an error."
    static let defaultDob = "01/01/1990"
    static let SSNmemberIDSupportMessage = "Some care providers accept SSN in place of Member IDs. Please check with your provider."

    // MARK: - NIB NAMES & REUSE IDENTIFIERS
    
    static let linkAccountCVCellNib = "LinkAccountCVCell"
    static let accountsHeaderViewNib = "AccountHeaderView"
    static let accountsBalanceCVCellNib = "AccountsBalanceCVCell"
    static let searchRecentCellNIb          =   "SearchRecentCVCell"
    static let searchRecentCVHeaderViewNib  =   "SearchRecentCVHeaderView"
    static let cardsHeaderViewNib  =   "CardsHeaderView"
    static let claimsHeaderViewNib = "ClaimsHeaderView"
    static let caseHeaderViewNib = "CaseHeaderView"
    static let newCaseHeaderViewNib = "NewCaseHeaderView"
    static let subCategoryCellNib = "SubCategoryCell"
    static let healthCardSubCategoryCellNib =   "HealthCardSubCategoryCell"
    static let bannerCollectionviewCell =   "BannerCollectionviewCell"
    static let healthCardSubCategoryNewCVCell = "HealthCardSubCategoryNewCVCell"
    static let healthCardPlanCellNib    =   "HealthCardPlanCell"
    static let basicIdCardCVCellNib = "BasicIdCardCVCell"
    static let healthAndBenifitCardDetailHeaderViewNib  =   "HealthAndBenifitCardDetailHeaderView"
    static let viewIDCardLabelViewNib = "ViewIDCardLabelView"
    static let anthemHmoCardViewNib = "AnthemHmoCardView"
    static let highmarkCardViewNib = "HighmarkCardView"
    static let anthemNonHmoCardViewNib = "AnthemNonHMOCardView"
    static let empireNonHMOCardViewNib = "EmpireNonHMOCardView"
    static let empireHMOCardViewNib = "EmpireHMOCardView"
    static let cignNonHMOCardViewNib = "CignaNonHMOCardView"
    static let uhcNonHMOCardViewNib = "UhcNonHMOCardView"
    static let cignaHMOCardViewNib = "CignaHMOCardView"
    static let uhcHMOCardViewNib = "UhcHMOCardView"
    static let geoBlueCardViewNib = "geoBlueCardView"
    static let medicalOverViewCVCellNib =   "MedicalOverViewCVCell"
    static let balancesCVCellNib = "BalancesCVCell"
    static let overViewCVCellNib =   "OverviewCVCell"
    static let healthCardNetworkPlanDetailCVCellNib =   "HealthCardNetworkPlanDetailCVCell"
    static let healthCardCostPlanDetailCVCellNib =   "HealthCardCostPlanDetailCVCell"
    static let healthCardOtherPlanDetailCVCellNib =   "HealthCardOtherPlanDetailCVCell"
    static let healthCardPlanDetailHeaderVIewNib =   "HealthCardPlanDetailHeaderVIew"
    static let healthCardPlanDetailsNetworkHeaderView =   "HealthCardPlanDetailsNetworkHeaderView"
    static let basicPlanHeaderViewNib = "BasicPlanHeaderView"
    static let basicPlanDetailCellNib = "BasicPlanDetailCell"
    static let questionAndAnswerCVCellNib = "QuestionAndAnswerCVCell"
    static let onboardingAuthenticationCVCell = "OnboardingAuthenticationCVCell"
    static let sqOnboardingAuthenticationCVCell = "SQOnboardingAuthenticationCVCell"
    static let cardMemberDetailTVCellNib   =   "CardMemberDetailTVCell"
    static let cardPlanDetailsTVCellNib   =   "CardPlanDetailsTVCell"
    static let geoBlueCardDetailsTVCellNib = "GeoBlueCardTVCell"
    static let cardCodeTVCellNib   =   "CardCodeTVCell"
    static let cardContactsTVCellNib   =   "CardContactsTVCell"
    static let cardOtherContactsTVCellNib = "CardOtherContactsTVCell"
    static let planDetailKeyValueTVCellNib = "PlanDetailKeyValueTVCell"
    static let claimsCVCellNib = "ClaimsCVCell"
    static let claimDetailTVCellNib = "ClaimDetailsTVCell"
    static let inviteEmailTVCellNib = "InviteEmailTVCell"
    static let healthCardGroupedPlanDetailCVCellNib =  "HealthCardGroupedPlanDetailCVCell"
    static let healthCardGroupedPlanDetailViewNib =  "HealthCardGroupedPlanDetailView"
    static let healthCardGroupedOtherPlanDetailViewNib =  "HealthCardGroupedOtherPlanDetailView"
    static let searchPaginationView = "SearchPaginationView"
    static let myDentalOverViewNib  =   "MyDentalOverView"
    static let healthCardOverviewCellNib   =   "HealthCardOverviewCell"
    static let inNetworkDentalOverviewCellIdentifier   =   "inNetworkDentalOverviewCellIdentifier"
    static let outNetworkDentalOverviewCellIdentifier   =   "outNetworkDentalOverviewCellIdentifier"
    static let framesAndLensesSelectionHeaderViewNib =   "FramesAndLensesSelectionHeaderView"
    static let dummyCVFooterViewNib     =   "DummyCVFooterView"
    static let sqHeaderView     =   "SQHeaderView"
    static let basicPlanFooterViewNib = "BasicPlanFooterView"
    static let contactListTVCellNib     =   "ContactListTVCell"
    static let healthCardOverviewHeaderViewNib     =   "HealthCardOverviewHeaderView"
    static let healthCardHeaderViewNib     =   "HealthCardHeaderView"
    static let balancesFooterViewNib     =   "BalancesFooterView"
    static let myDentalOverviewCVCellNib = "MyDentalOverviewCVCell"
    static let myDentalRoleoverAmountCVCellNib =   "MyDentalRoleoverAmountCVCell"
    static let linkAccountMessageViewNib = "LinkAccountMessageView"
    static let healthCardFooterViewNib = "HealthCardFooterView"
    static let glossaryHeaderView = "GlossaryHeaderView"
    static let splashView = "SplashView"
    static let dentalBalanceStaticCVCellNib = "DentalBalanceStaticCVCell"
    static let dentalBalanceCVCellNib = "DentalBalanceCVCell"
    static let medicalHorizontalBalanceCVCellNib = "MedicalHorizontalBalanceCVCell"
    static let medicalTextSubTextCVCell = "MedicalTextSubTextCVCell"
    static let swipableCVC = "SwipableCardsWithLabelCVC"
    static let doubleLabelCVCell = "DoubleLabelCVCell"
    static let infoGlossaryView = "InfoGlossaryView"
    static let sqDropDownTitleTVCell = "SQDropdownTitleCell"
    static let titleStrings: [String] = ["Deductible", "Out of pocket Max"]
    
    static let subTitleStrings: [String] = ["Your deductible is the amount of you'll need to pay for care before your health plan begins to pay for covered health care costs. An individual deductible is for you alone. A family deductible is for all the members of your family who are covered by your health plan.", "An out-of-pocket maximum is the most you'll pay for covered health care costs during one plan year. If you meet the out-of-pocket maximum your health plan will pay for your covered health care costs for the rest of the year."]
    static let dentaltitleStrings: [String] = ["Deductible", "Annual Benefit Maximum", "Rollover Amount Balance"]
    static let dentalSubTitleStrings: [String] = ["Amount you\'ll need to pay before your dental plan begins to pay for covered dental costs.", "Maximum amount your dental plan will pay in a calendar/policy year, per person.", "Allows you to rollover a portion of your unused annual maximum benefit into a maximum rollover account for future dental services."]
    static let dataProviderText = "Data provided by your carrier. Please contact your provider for exact amounts due."

    static let newHireEffectiveDateViewNib = "NewHireEffectiveDateView"
    static let forceUpgradeViewNib = "ForceUpgradeView"
    static let metlifeDisclaimerViewNib = "MetlifeDisclaimerView"
    
    static let otherBenefitsCVCellNib = "OtherBenefitsListCVCell"
    static let subcategoryCollectionHeaderViewNib = "SubcategoryCollectionHeaderView"
    static let multipleDetailsCardHeaderViewNib = "MultipleDetailsCardHeaderView"
    static let multipleDetailsOuterHeaderViewNib = "MultipleDetailsOuterHeaderView"
    static let preTaxHeaderViewNib = "PreTaxHeaderView"
    static let preTaxDetailsCVCellNib = "PreTaxDetailsCVCell"
    static let fsaPreTaxDetailsCVCellNib = "FSAPreTaxDetailsCVCell"
    static let currentBalanceCVCellNib = "CurrentBalanceCVCell"
    static let commuterCVCellNib = "CommuterCVCell"
    static let planDetailKeyValueCVCellNib = "PlanDetailKeyValueCVCell"
    static let linkedFundCVCellNib = "LinkedFundCVCell"
    static let otherBenefitsGroupedPlanDetailCVCellNib = "OtherBenefitsGroupedPlanDetailCVCell"
    static let otherBenefitsDetailsGroupedViewNib = "OtherBenefitsDetailsGroupedView"
    static let otherBenefitsGroupingViewNib = "OtherBenefitsGroupingView"
    static let otherBenefitsGroupingCVCellNib = "OtherBenefitsGroupingCVCell"
    static let dependentIDCardHeaderView = "DependentIDCardHeaderView"
    
    static let switchTVCellNib = "SwitchTVCell"
    static let findMyLocationTVCellNib = "FindMyLocationTVCell"
    static let newClaimDropDownTableViewCellNib = "NewClaimDropDownTableViewCell"
    static let borderedNewClaimDropDownTableViewCellNib = "BorderedNewClaimDropDownTableViewCell"
    static let locationTVCell = "LocationTVCell"
    static let findAProviderDisclaimerTVCellNib = "FindAProviderDisclaimerTVCell"
    static let newClaimAddImageTableViewCellNib = "NewClaimAddImageTableViewCell"
    static let newClaimDatesTableViewCellNib = "NewClaimDatesTableViewCell"
    static let borderedNewCLaimDateTableViewCell = "BorderedNewCLaimDateTableViewCell"
    static let newClaimDOBTVCellNib = "NewClaimDOBTVCell"
    static let borderedNewClaimDOBTVCell = "BorderedNewClaimDOBTVCell"
    static let claimsIdCVCellNib = "ClaimsIdCVCell"
    static let claimDateCellNib = "ClaimDateCell"
    static let claimsHeaderReusableViewNib = "ClaimsHeaderReusableView"
    static let claimsCodeHeaderReusableViewNib = "ClaimsCodeHeaderReusableView"
    static let caseTextViewTVCellNib = "CaseTextViewTVCell"
    static let createCaseBannerTVCellNib = "CreateCaseBannerTVCell"
    static let contextualFAQCVCellNib  =   "ContextualFAQCVCell"
    static let contextualGlossaryCVCellNib  =   "ContextualGlossaryCVCell"
    static let contextualHeaderReusableViewNib  = "ContextualHeaderReusableView"
    static let faQBaseHeaderViewNib   =   "FaQBaseHeaderView"
    static let faqSearchHeaderViewNib = "FAQSearchHeaderView"
    static let newMessageTableViewCellNib = "MessageTVCell"
    static let caseDescriptionTVCellNib = "CaseDescriptionTVCell"
    static let caseDetailDefaultTVCellNib = "CaseDetailDefaultTVCell"
    static let dynamicCaseImageTVCellNib = "DynamicCaseImageTVCell"
    
    static let payrollListCVCellNib = "PayrollListCVCell"
    static let payrollKeyValueCVCellNib = "PayrollKeyValueCVCell"
    static let payrollWithSeperatorCVCellNib = "PayrollWithSeperatorCVCell"
    static let payrollHeaderViewNib = "PayrollHeaderView"
    static let payrollListHeaderViewNib = "PayrollListHeaderView"
    static let parollAddCellNib = "ParollAddCell"
    static let claimsLinkCell = "ClaimsLinkCell"
    
    static let cardsPlanCellNib    =   "CardsPlanCell"
    static let SQImageLabelCVCellNib    =   "SQImageLabelCVCell"
    static let rightwayCardsPlanCell    =   "RightwayCardsPlanCell"
    static let lineCollectionReusableViewNib = "LineCollectionReusableView"
    static let my401kSectionHeaderViewNib = "My401kSectionHeaderView"
    static let linkedFundsHeaderViewNib = "LinkedFundsHeaderView"
    
    static let bulletPointCVCellNib    =   "BulletPointCVCell"
    static let virtualCareDetailHeaderViewNib    =   "VirtualCareDetailHeaderView"
    
    static let settingsDefaultTVCellNib = "SettingsDefaultTVCell"
    static let settingsSwitchTVCellNib = "SettingsSwitchTVCell"
    static let settingsSectionHeaderViewNib = "SettingsSectionHeaderView"
    static let confirmationHeaderViewNib = "ConfirmationView"
    static let contactListCVCellNib = "ContactListCVCell"
    static let messageCenterListCVCellNib = "MessageCenterListCVCell"
    static let pastCasesCVCellNib = "PastCasesCVCell"
    static let casesPlaceholderCVCellNib = "CasesPlaceholderCVCell"
    static let contactPrimaryCVCellNib = "ContactPrimaryCVCell"
    static let contactSecondaryCVCellNib = "ContactSecondaryCVCell"
    static let contactFooterViewNib = "ContactFooterView"
    static let contactHelpHeaderViewCRV = "HelpHeaderViewCRV"
    static let messageCVCellNib = "MessageCVCell"
    static let attachmentCVCellNib = "AttachmentCVCell"
    
    static let cardsTitleViewNib = "CardsTitleView"
    
    static let providerDetailsCVCellNib = "ProviderDetailsCVCell"
    static let providerDetailsTVCellNib = "ProviderDetailsTVCell"
    static let searchPaginationCVCellNib = "PaginationCVCell"
    static let doctorsListCVCellNib = "DoctorListCVCell"
    static let doctorsListTVCellNib = "DoctorListTVCell"
    static let providerDetailsV2CVCell = "ProviderDetailsV2CVCell"
    static let providerDetailsShimmerCell = "ProviderDetailsShimmerCell"
    static let providerDetailsOldShimmerCell = "ProviderDetailsOldShimmerCell"
    static let basicIdCardCVCellWHeadingV2 = "BasicIdCardCVCellWHeadingV2"
    static let pbasicIdCardCVCellWHeadingV2 = "PBasicIdCardCVCellWHeadingV2"
    static let phealthIdCardWHeadingCVCellV2 = "PHealthIdCardWHeadingCVCell"
    static let healthIdCardWHeadingCVCellV2 = "HealthIdCardWHeadingCVCell"
    static let sqOnboardingAuthenticationTVC = "SQOnboardingAuthenticationTVC"
    static let sqOnboardingFooterView = "SQOnboardingFooterView"
    static let weeklyCalendarHeaderView = "WeeklyCalendarHeaderView"
    static let coworkerFollowingTVCell = "CoworkerFollowingTVCell"
    static let followerListTVCell = "FollowerListTVCell"
    static let coworkerFollowingWithCalendarCell = "CoworkerFollowingWithCalendarCell"
    static let coworkersHeaderView = "CoworkersHeaderView"
    static let w2FormCell = "W2FormCVCell"
    static let w2FormEmptyCell = "W2FormEmptyCell"
    
    static let notificationsTVCellNib = "NotificationsTVCell"

    static let findProviderHeaderViewNib = "FindProviderHeaderView"
    static let mapCardViewNib = "MapCardView"
    static let searchCategoryCVCellNib = "SearchCategoryCVCell"
    
    static let whatsNewCVCellNib = "WhatsNewCVCell"
    
    static let guidanceFeaturedCVCellNib = "GuidanceFeaturedCVCell"
    static let guidanceEmptyCVCellNib = "GuidanceEmptyCVCell"
        
    //News Feed
    static let enrollementCollectionViewCell = "SQEnrollementCollectionViewCell"
    static let newsFeedCollectionViewCell = "SQFeedCollectionViewCell"
    static let newsFeedOECellReusableItendifier = "oeCell"
    static let newsFeedCellReusableItendifier = "feedCell"
    static let forYouCollectionViewCell = "ForYouCollectionViewCell"
    static let quickLinksTableViewCell = "QuickLinksTableViewCell"
    static let quickLinkCollectionViewCell = "QuickLinkCollectionViewCell"
    
    //RTW
    static let rtwFeedCellReusableItendifier = "rtwCell"
    static let returnToWorkCollectionViewCell = "SQReturnToWorkCollectionViewCell"
    static let rtwReservattionFeedCellReusableItendifier = "rtwReservationCell"
    static let returnToWorkReservationCollectionViewCell = "SQRTWReservationCollecttionViewCell"
    static let returnToWorkTableViewCell = "SQRTWTableViewCell"
    static let returnToWorkTableViewCellResuableIdentifier = "rtwTableViewCell"
    static let globalWellbeingTableViewCell = "SQGlobalWellbeingTableViewCell"
    static let globalWellbeingCollectionViewCell = "SQGlobalWellbeingCollectionViewCell"
    static let globalWellbeingTableViewCellResuableIdentifier = "globalWellbeingTableViewCell"
    static let SQQuestionaireCollectionviewCell = "SQQuestionaireCollectionviewCell"
    static let questionaireCollectionviewCellIdentifier = "questionaireCell"
    static let SQQuestionaireCollectionviewCell2 = "SQQuestionaireCollectionViewCell2"
    static let questionaireCollectionviewCellIdentifier2 = "questionaireCell2"
    static let SQCohortsTableviewCell = "SQCohortsTableviewCell"
    static let myCohortCell = "myCohortCell"
    static let SQCohortsExpandedTableViewCell = "SQCohortsExpandedTableViewCell"
    static let myCohortExpandedCell = "myCohortExpandedCell"
    static let SQMyCohortSectionHeaderView = "SQMyCohortSectionHeaderView"
    static let RTWDashboardTitleSubtilteCell = "RTWDashboardTitleSubtilteCell"
    static let titleSubtitleCell = "titleSubtitleCell"
    static let emptyMakeReservationCell = "emptyMakeReservationCell"
    static let emptySingleMakeReservationCell = "emptySingleMakeReservationCell"
    static let emptyDoubleMakeReservationCell = "emptyDoubleMakeReservationCell"
    static let RTWDashboardTitleTableViewCell = "RTWDashboardTitleTableViewCell"
    static let titleCell = "titleCell"
    static let SQRTWDshboardCohortCollectionViewCell = "SQRTWDshboardCohortCollectionViewCell"
    static let dashboardCohortCell = "dashboardCohortCell"
    static let RTWDashboardCohortsCell = "RTWDashboardCohortsCell"
    static let dashboardCohortTableViewCellIdentifier = "dashboardCohortTableviewCell"
    static let RTWDashboardCardCell = "RTWDashboardCardCell"
    static let dashboardCardTableViewCellIdentifier = "cardCell"
    
    static let RTWDashboardCaptainCohortCell = "RTWDashboardCaptainCohortCell"
    static let dashboardCaptainCohortCell = "captainCohortCell"
    
    static let SQRTWReservationDashboardCell = "SQRTWReservationDashboardCell"
    static let SQRTWReservationDashboard2Cell = "SQRTWReservationDashboard2Cell"
    static let SQRTWReservationDashboard1Cell = "SQRTWReservationDashboard1Cell"
    
    static let SQQuestionTableviewCell = "SQQuestionTableviewCell"
    static let SQQuestionOptionsCell = "SQQuestionOptionsCell"
    
    static let SQRTWAnnouncementBannerTableViewCell = "SQRTWAnnouncementBannerTableViewCell"
    static let SQRTWAnnouncementDetailTableViewCell = "SQRTWAnnouncementDetailTableViewCell"
    static let SQAppAnnouncementDetailTableViewCell = "SQAppAnnouncementTVCell"
    static let SQRTWVaccinationTableViewCell = "RTWVaccinationTableViewCell"
    static let SQRTWVaccinationHeaderView = "CommonVaccinationHeaderView"
    static let NotificationCell = "NotificationCell"
    static let NotificationTableViewCell = "NotificationTableViewCell"
    static let sqInboxTVCell = "SQInboxTVCell"
    
    static let claimsBalanceHeaderCell = "ClaimsBalanceHeaderCell"
    static let claimsBalanceTableViewCell = "ClaimsBalanceTableViewCell"
    static let claimsBalanceCell = "ClaimsBalanceCell"
    static let claimsHeaderCell = "ClaimsHeaderCell"
    static let sqFiledClaimCell = "SQFiledClaimCell"
    
    //DiscountRX
    static let imageAndLabelCell = "ImageAndLabelTVC"
    static let discountTypeTVC = "DiscountTypeTVC"
    static let rxSettingsTVC = "RxSettingsTVC"
    static let couponTVC = "CouponTVC"
    
    //Wellbeing
    static let wellbeingTVC = "WellbeingTVC"
    static let wellbeingPlanListCell = "WellbeingPlanListCell"
    static let ratingsAndReviewTVCell = "ReviewsTVC"
    static let sqAssetsCollectionViewCell = "SQAssetsCollectionViewCell"
    static let emptyTableViewCell = "emptyTableViewCell"
    static let emptyTVCell = "EmptyTableViewCell"
    
    static let healthIDCardCVCell = "HealthIDCardCVCell"
    static let medicalIdCardCVCellNib = "MedicalIDCardCVCell"
    
    static let medicalIDcardDoubleLabelTVC = "DoubleLabelWithAButtonCell"
    static let contactDetailsTVC = "ContactDetailsCell"
    static let contactDetailsNewTVC = "ContactDetailsNewCell"
    static let pcontactDetailsNewTVC = "PContactDetailsNewCell"
    static let healthCareCommonTVC = "HealthCareCommonCell"
    static let medicalIdCardTVC = "MedicalIdCardCell"
    static let uploadYourCardCell = "UploadIDCardCell"
    static let switchNetworkTVCellNib = "SwitchNetworkCell"
    
    //DashboardV2UI
    static let announcementCollectionViewCell = "AnnouncementsCollectionViewCell"
    static let oeTableViewCell = "OETableViewCell"
    static let quickViewCollectionViewCell = "QuickViewCollectionViewCell"
    static let dashboardHeaderTVC = "DashboardHeaderTVC"
    static let forYouTableViewCell = "ForYouTableViewCell"
    static let newsFeedTableViewCell = "NewsFeedTableViewCell"
    static let trendingTableViewCell = "TrendingLinksTableViewCell"
    
    // MARK: - ALERT CONSTANTS -
    static let appName = "Sequoia".localized()
    static let nextButtonTitle = "Next".localized()
    static let signInButtonTitle = "Sign In".localized()
    static let okButtonTitle = "OK".localized()
    static let yesButtonTitle = "Yes".localized()
    static let noButtonTitle = "No".localized()
    static let contactSupport = "Contact".localized()
    static let cancelButtonTitle = "Cancel".localized()
    static let dismissButtonTitle = "Dismiss".localized()
    static let closeButtonTitle = "Close".localized()
    static let contactUsButtonTitle = "Contact Us".localized()
    static let openEmailButtonTitle = "Open Email"
    static let backToLogin = "Back to login"
    static let Upgrade = "Upgrade"
    static let supportMailSubject = "Sequoia Mobile Application"
    static let EmailButtonTitle = "Email"
    static let gotItButtonTitle = "Got It"
    static let officeAnnouncementTitle = "Office Announcement"
    static let announcementsTitle = "Announcements"
    
    static let dontAllowButtonTitle = "Don't Allow".localized()
    static let enableButtonTitle = "Enable".localized()
    static let touchIdConfirmationAlertMessage = "Do you wish to use Touch ID to get access to the app? You can always change this in the Settings later."
    static let touchIdConfirmationAlertTitle = "Enable Touch ID"
    
    static let faceIdConfirmationAlertMessage = "Do you wish to use Face ID to get access to the app? You can always change this in the Settings later."
    static let faceIdConfirmationAlertTitle = "Enable Face ID"

    static let automaticSessionExpireMsg = "Your session has been expired. Please sign in again."
    static let pushNotificationSystemSettingsAlertMsg = "Please enable Notifications for sequoia app in system settings."
    static let supportEmail = "supportEmail"
    static let supportNumber = "supportNumber"
    
    static let oldEmail = "oldEmail"
    static let newEmail = "newEmail"
    static let userName = "userName"
    static let errorRequest = "errorRequest"
    static let errorResponse = "errorResponse"
    static let stackTrace = "stackTrace"
    static let isEmployee = "isEmployee"
    
    static let reservationSuccessMessage = "Your office reservation has been submitted, a self-screening will be required prior to coming into the office. \n\nLook out for a self-screening notification on your reservation day."
    
    static let emailComposerErrorMessage = "Your device could not send e-mail.Please check e-mail configuration and try again."
    
    static let emailSubjectString = "Error details"
    static let emailBodyFirstLine = "The following error has occurred:"

    // MARK: - DATE FORMAT CONSTANTS -
    static let invalidDobDateFormat = "MM/dd/yyyy"
    static let apiDobDateFormat = "yyyy-MM-dd"
    static let apiDobDateFormat2 = "MM-dd-yyyy"
    static let apiDobDateFormat3 = "yyyy-MM-dd'T'00:00:00Z"
    static let apiDobDateFormat4 = "yyyy-MM-dd'T'00:00:00"
    static let apiDobDateFormat5 = "yyyy-MM-dd'T'HH:mm:ss"
    static let payrollDateFormat = "MMM. d, yyyy"
    static let payrollDisplayDateFormat = "MMMM d, yyyy"
    static let idCardEffectiveDateFormat = "MM/dd/yyyy"
    static let postPlanYearFormat = "MMM. yyyy"
    static let claimDateFormatWithTime = "MMM dd yyyy h:mm a"
    static let claimDateFormat = "MMM dd yyyy"


    // MARK: - HEALTH CARD DETAIL CONSTANTS -
    static let planDetails = "PLAN DETAILS"
    static let inNet = "IN NET."
    static let outOfNet   = "OUT OF NET."
    static let other = "OTHER"
    static let cost = "COST"
    static let inNetworkCost = "IN NETWORK COSTS"
    static let outOfNetworkCost = "OUT OF NETWORK COSTS"
    static let untilYouReachText = "Until you reach your deductible, you’ll be paying the full cost out of pocket."
    static let afterYouReachBenefitMaxText = "After you reach your benefit max, you will be paying out of pocket."
    static let individual = "Individual"
    static let family = "Family"
    static let you = "You"
    static let deductible = "Deductible"
    static let annualBenefitMaximum = "Annual Benefit Maximum"
    static let deductibleLimitText = "Limit"
    static let annualMaxLimitText = "Benefit Max."
    static let rollOverMaxLimitText = "Rollover Max."
    static let outOfPocketMaxLimitText = "OOP Max."
    static let outOfNetwork = "OUT OF NETWORK"
    static let inNetwork = "IN NETWORK"
    
    static let outOfPocketCost = "Out of Pocket Cost"
    static let rollOverAmountUsed = "Rollover Amount Balance"
    static let rollOverNoteMessgae = "You have an additional $%@ towards your annual benefit maximum this year that rolled over from the previous year."
    
    static let noPkPassErrorMsg = "PkPass is not available for this device"
    static let downloadFailureText = "Sorry, we are experiencing a problem retrieving your ID Card. If this persists, contact app support."
//    static let anthemProviderType = "Anthem Blue Cross of CA"
    static let guardianProviderType = "Guardian"
    
    // MARK: - DIGITAL ID CARD'S CAMERA VIEW CONSTANTS
    static let frontCardFullText = "Front of Card"
    static let frontCardAttributedText = "Front"
    static let backCardFullText = "Back of Card"
    static let backCardAttributedText = "Back"
    static let cameraViewDescriptionText = "Position your card within the box in front of a dark background."
    static let previewViewDescriptionText = "Looking good? Make sure key information is easy to read."
    static let previewViewAttributedText = "Looking good?"
    
    // MARK: - OTHER BENEFITS DETAIL CONSTANS -
    static let preIncomeTypes = [GeneralConstants.commuterType, GeneralConstants.hsaType, GeneralConstants.fsaType, GeneralConstants.wellnessHRAType]
    static let incomeTypes = [GeneralConstants.stdType, GeneralConstants.ltdType, GeneralConstants.lifType]
    
    static let defaultDoubleValue = 0.00001
    static let commuterType = "Commuter"
    static let hsaType = "HSA"
    static let fsaType = "FSA"
    static let wellnessHRAType = "HRA"
    static let stdType = "STD"
    static let ltdType = "LTD"
    static let lifType = "LIFE_INSURANCE"
    
    static let volumeTitle = "Volume / Coverage"
    static let maxBenefitTitle = "Maximum Benefit"
    static let eleminationPeriodTitle = "Elimination Period"
    static let benefitPeriodTitle = "Benefit Period"
    
    ///Lif DataSource
    static let basicCoverageAmount = "Basic Coverage Amount"
    static let employeeSuplimental = "Employee Supplemental"
    static let spouseSupplemental = "Spouse Supplemental"
    static let childSupplemental = "Child Supplemental"
    static let maxCoverage = "Up to "
    
    ///Commuter DataSource
    static let parkingMaxTitle = "Monthly Pre-Tax Parking Limit"
    static let transitMaxTitle = "Monthly Pre-Tax Transit Limit"
    static let bicycleReimbursementTitle = "Bicycle Reimbursement"
    
    ///FSA DataSource
    static let maximumContribution = "Maximum contribution"
    static let maximumLimit = "Max Pre-Tax Contribution (Per Plan Year)"
    static let carryOverAmount = "Carryover Amount"
    static let runOutPeriod = "Runout Period"
    static let gracePeriod = "Grace Period"
    static let irsmaxContibution = "IRS Contribution Max"
    
    // MARK: - MyGlobal-
    static let medicalBenefitMaxTitle = "Medical Benefit Max."
    static let medicalDeductabelTitle = "Medical Deductible"
    static let medicalCoinsuranceTitle = "Medical Coinsurance*"
    static let rxCoinsuranceTitle = "Rx Coinsurance*"
    static let dentalAccidentTitle = "Dental Accident*"
    static let dentalPainAlleviationTitle = "Dental Pain Alleviation*"
    static let accidentalTitle = "Accidental Death & Dismemberment"
    static let medicalEvacuationTitle = "Medical Evacuation"
    static let repatriation = "Repatriation"
    static let sojournTitle = "Sojourn Travel"
    
    static let dollar = "$"
    static let days = " Days"
    
    // MARK: - FAQ CONSTANTS -
    static let faqSegmentDatasource: [String] = ["Popular", "By Topic", "Glossary"]
    static let contextualFaqSegmentDatasource: [String] = ["FAQ", "GLOSSARY"]
    static let faqNavTitle = "FAQ".localized()
    static let glossaryNavTitle = "Glossary".localized()
    
    // MARK: - ID Cards Constants
    static let viewMedicalCard = "View Your Medical ID Card"
    static let viewMedicalCardNewUI = "View Card"
    static let viewMedicalCard_1_5 = "View Your Card"
    static let viewDentalCard = "View Your Dental ID Card"
    static let viewVisionCard = "View Your Vision ID Card"
    static let uploadMedicalCard = "Upload Your Medical ID Card"
    static let uploadMedicalCardNewUI = "+ Upload Card"
    static let uploadMedicalCard_1_5 = "+ Upload Your Card"
    static let uploadDentalCard = "Upload Your Dental ID Card"
    static let uploadVisionCard = "Upload Your Vision ID Card"
    static let idCardTypes: [MedicalIDCardsType] = [.anthem, .uhc, .cigna, .empire, .highmark]

    static let contactid = "contactid"
    static let providerName = "providerName"
    static let memberId = "memberId"
    static let planType = "planType"
    static let updatedMemberID = "updatedMemberID"
    static let updatedCardImageUrl = "updatedCardImageUrl"
    static let idCardImageUrl = "idCardImageUrl"
    
    // MARK: - CONTACT CASE CONSTANTS
    static let openCases = "openCases"
    static let pastCases = "pastCases"
    
    static let engagementModel: String = "engagementModel"

    // MARK: - Error Code
    static let forceUpgradeRequired = 2001
    static let forceUpgradeRecommended = 2002
    
    //To find top most visible view controller
    static let topVisibleVC = sqAppDelegate?.appWindow?.visibleViewController?.navigationController ?? sqAppDelegate?.appWindow?.visibleViewController ?? sqAppDelegate?.rootNavigationVC
    
    //Local error message for Firebase analytics
    static let biometricAvailablityFailed = GeneralConstants.biometricType + " availablity failed"
    static let biometricAuthenticationFailed = GeneralConstants.biometricType + " authentication failed"
    
    //For WKWebView
    static let wkwebkitHeaderString = "<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0'></header>"
    
    static let filterSelected = "SelectedFilter"
    
    //For Rightway
    static let isAnyRightwayNotificationReceived = "isAnyRightwayNotificationReceived"
    
    //RTW
    static let genericConsentShownForTheSession = "genericConsentShownForTheSession"
    
    //SSO
    static let ssoLoginNavtitle = "Login with SSO"
    
    class func getPXUrl() -> String {
        let serverType: Int = UserDefaults.standard.integer(forKey: GeneralConstants.selectedServerType)
        let type = Server(rawValue: serverType) ?? Server.productionServer
        
        switch type {
        case .testServer:
            return BaseAPIUrls.testPXUrl
        case .developmentServer:
            return BaseAPIUrls.devPXUrl
        case .stagingServer:
            return BaseAPIUrls.stagingPXUrl
        case .stageServer:
            return BaseAPIUrls.stagePXUrl
        case .qastagingServer:
            return BaseAPIUrls.qastagingPXUrl
        case .uatServer:
            return BaseAPIUrls.uatPXUrl
        case .preprodServer:
            return BaseAPIUrls.preprodPXUrl
        case .productionServer:
            return BaseAPIUrls.prodPXUrl
        case .localServer:
            return BaseAPIUrls.qastagingPXUrl
        }
    }
    
    class func getPXLoginUrl() -> String {
        let serverType: Int = UserDefaults.standard.integer(forKey: GeneralConstants.selectedServerType)
        let type = Server(rawValue: serverType) ?? Server.productionServer
        
        switch type {
        case .testServer:
            return BaseAPIUrls.testPXLoginUrl
        case .developmentServer:
            return BaseAPIUrls.devPXLoginUrl
        case .stagingServer:
            return BaseAPIUrls.stagingPXLoginUrl
        case .stageServer:
            return BaseAPIUrls.stagePXLoginUrl
        case .qastagingServer:
            return BaseAPIUrls.qastagingPXLoginUrl
        case .uatServer:
            return BaseAPIUrls.uatPXLoginUrl
        case .preprodServer:
            return BaseAPIUrls.preprodPXLoginUrl
        case .productionServer:
            return BaseAPIUrls.prodPXLoginUrl
        case .localServer:
            return BaseAPIUrls.qastagingPXLoginUrl
        }
    }

    
    //MARK: - Onboarding skip
    static let onboardingSkipped = "onboardingSkipped"
    static let apiTokenDefaults = "apiTokenDefaults"
    static let otpVerificationRequired = "otp_verification_required"
}
