//
//  ApiConstants.swift
//  Sequoia
//
//  Copyright © 2016 YMediaLabs. All rights reserved.
//

import UIKit

struct APIPathConstants {
    //** Auth **//
    // USER
    
    static let loginUser = "users/v2/login"
    static let loginUserV1 = "users/login"
    static let verifyUserSignInEmailPath = "v1/contacts/verify-email"
    static let verifyDependentSignup = "dependents/verify-sign-up"
    static let verifyDependentSignInEmailPath = "dependents/verify-email"
    static let registerUserPath = "contacts/save-password"
    static let registerBasicUserPath = "contacts/basic-user-details"
    static let dependantRegisterPath = "dependents/create-account"
    static let userForgotPasswordPath = "users/forgot-password"
    static let verifyDOB = "contacts/verify-dob"
    static let activationStatus =  "users/status"
    static let resendActivationLink =  "contacts/resend-activation-email"
    
    static let sendFeedbackAndBug =  "misc/feedback"
    static let changePassword =  "users/change-password"
    static let getNotificaitonSettings =  "idm/users/notification-settings" 
    static let getEmployerNotices =  "px-client/employer-notices" //Get Employer notices to be shown in the notification center screen.
    static let employerNoticeAck =  "px-client/employer-notices/ack"  //Update the notices from unread to read
    static let getEmployerNoticeReadCount =  "px-client/employer-notices/unread-count" //Get the unread notification count to be shown on the dashboard
    static let verifyEmployeeEmail = "v1/contacts/verify-email"
    static let toggleEmailOptOut = "users/update-email-status"
    
    //Logout
    static let logoutUserPath =  "users/logout"
    
    //** PUSH NOTIFICATIONS **//
    static let updatePushNotificationStatus =  "notification-service/notifications/push/update-notification-active-status"
    
    //** DASH BOARD **//
    static let getDependantsListPath =  "px-client/users/profile/invite-dependants/v2"
    static let changeDependentAccessPath =  "px-client/users/profile/invite-dependants/change-access/v2"
    static let urgentHelpApiPath =  "px-client/find-care/medical-support"
    static let emotionalSupportApiPath =  "px-client/find-care/emotional-support"
    static let virtualCareApiPath =  "px-client/find-care/virtual-care"
    static let getMedicalIdCard =  "px-client/users/idcards/medical"
    static let getDentalIdCard =  "px-client/users/idcards/dental"
    static let getVisionIdCard =  "px-client/users/idcards/vision"
    static let getGlobalIdCard =  "px-client/users/idcards/global"
    static let contactsApiPath =  "px-client/enrollment/contacts-list"
    static let getIdCardURLApiPath =  "benefits/v1/idcards/get-passes"
    static let getNotificationsPath =  "notification-service/notifications/push"
    static let deleteNotifications =  "notification-service/notifications/push/delete"
    static let updateReadStatusNotifications =  "notification-service/notifications/push/update-read-status"
    static let getUnReadNotificationsCount =  "notification-service/notifications/push/unread/count"
    static let getUnReadRightwayNotificationsCount =  "notification-service/notifications/push/unread/count?module=RIGHTAWAY"
    static let getOpenEnrollment = "admin-core/external/sso/bswift/redirect-url"
    static let recomendationsApiPath = "px-client/dashboard/recommended"
    static let versionUpdate = "px-client/generic/version"
    
    //** CARDS **//
    static let getClaimsHistory =  "px-client/users/tax-savings/fsa-claims/1"
    static let getUsetBenefits =  "px-client/microsite/pir/enrolled-tax-saving-balances"
    static let createClaim =  "px-client/users/tax-savings/fsa-claims"
    static let medicalBalancesApiPath = "px-client/users/healthcare/medical-balances"
    static let dentalBalancesApiPath = "px-client/users/healthcare/dental-balances"
    static let getNaviaUrlPath =  "px-client/users/tax-savings/add-commuter-funds"
    static let addMemberIdApiPath = "px-client/users/idcards/member-id"
    static let addIDcardImageApiPath = "px-client/upload/idCard"
    static let getS3ImageApiPath = "px-client/generic/file?type=blob"
    static let deleteIDCardImage = "px-client/users/idcard"
    static let prismHRRedirect = "sequoia-one/prismhr/redirect_url"
    
    //News Feeds
    static let getFeedData = "px-client/feed?country=US&limit=04&offset=0&status=published"
    
    static let savedDoctors = "mydoctor/saved-doctors"
    static let saveDoctors = "mydoctor/save-doctors"
    static let deleteSavedDoctors = "mydoctor/delete-saved-doctors"

    static let getEnrollmetsPath = "px-client/my-benefits/enrolled-plans-summary"
    static let personalInfoCapability = "px-client/users/profile/personal-info/capability"
    static let getPersonalInfo = "px-client/users/profile/personal-info"
    static let getAminoDoctorsList = "px-client/find-care/book-an-appointment" //This is to get the amino saml response for the webview

    // This is for getting the SSO redirect url for apps like Rightway, Origin etc
    static let getSSOURL = "px-client/redirect-url"

    static let payrollApiPath =  "px-client/users/payroll"
    static let my401kFastLinkApiPath =  "px-client/balances/fastlink-token/:type"
    static let my401kApiPath =  "px-client/balances/accounts/v1/401k"
    static let myHSAApiPath =  "px-client/balances/accounts/v1/hsa"
    static let delink401kAccount = "px-client/balances/accounts/v1/:type"
    static let humanInterestSSOLink = "px-client/balances/sso-link"
    
    // MARK: CONTACTS
    static let getContactCases =  "px-client/advocate/cases/v2"
    static let getCaseReasons =  "px-client/advocate/case-reasons/v2"
    static let postNewCase =  "px-client/advocate/cases/v2"
    static let deleteAdvocateCase = "px-client/advocate/cases/v2"
    static let postComment =  "px-client/advocate/cases/comments/v2"
    static let postCommentWithAttachment = "px-client/advocate/cases/comments/v2" //--> same as above
    static let sendCaseReadStatus =  "px-client/advocate/cases/read/v2"
    
    
    static let getCaseAttachments =  "px-client/advocate/cases/attachment"
    static let getAttachments =  "px-client/generic/attachment"
            
    // MARK: - RTW
    static let getRTWCard = "rtw/client/pending-task"
    static let submitRTWTask = "rtw/client/task-response"
    static let getCohortStatus = "rtw/client/cohort-info"
    static let getOfficeLocations = "rtw/resv/client/locations"
    static let myCohorts = "rtw/client/users"
    static let pxDashboard = "rtw/client/dashboard"
    static let uploadFile = "rtw/client/medical/upload"
    static let makeReservation = "rtw/client/make-reservation"
    static let getReservation = "rtw/resv/client/reservations"
    static let getCohortReservation = "rtw/client/user-reservations"
    static let cancelReservation = "rtw/client/cancel-reservations"
    static let postCheckinQRCode = "rtw/client/checkin"
    static let getRTWAnnouncements = "rtw/client/announcement"
    static let getRTWAnnouncementsById = "rtw/announcement/:id"
    
    static let clientVaccinationHistory = "rtw/client/vaccination/history/v2"
    static let vaccinationVendors = "rtw/client/vaccination/vendors"
    static let uploadVaccinationToS3 = "rtw/client/vaccination/upload"
    static let uploadVaccineRecordPost = "rtw/client/vaccination-report/v2"
    static let availableVaccinationDossage = "rtw/client/vaccination/available-doses"
    
    //MARK: - Workplace
    static let getCardDetails = "rtw/client/task/info"
    static let getNumberOfEmployees = "rtw/client/space-bookings/employees"
    static let getClientRTWPages = "px-client/company/app-pages/rtw"
    static let getWorkplaceFeatures = "workplace/v1/current-plan-summary"
    static let getTestingRecordHistory = "rtw/client/test/history"
    static let getWorkplacePolicies = "rtw/client/resources"
    
    static let myReservationOnDate = "rtw/client/dashboard/reservations/me"
    static let userReservationsOnDate = "rtw/client/dashboard/reservations"
    static let reservationSummary = "rtw/client/dashboard/summary"
    
    // MARK: - New Reservation v2
    static let getAvailableSlots = "rtw/resv/client/reservations/availability"
    static let makeReservations = "rtw/resv/client/reservations"
    static let updateReservations = "rtw/resv/client/reservations"
    static let reservationConfigurations = "rtw/resv/client/capability"
    static let learnMoreConfigurations = "px-client/rtw/faq"
    static let fetchSignedUrl = "rtw/client/signed-url"
    static let getAdminCoreSignedUrl = "admin-core/doc-storage/sign-url"
    
    // MARK: - Consents
    static let getConsentDetails = "px-client/users/profile/carrier-consent"
    static let submitConsent = "px-client/users/profile/carrier-consent"

    // MARK: - Microsite
    static let micrositeData = "px-client/microsite"
    
    // MARK: - Wellbeing v2
    static let getSectionPlans = "px-client/microsite/pir/pages/:pageSlug/plans"
    static let getSectionDetails = "px-client/microsite/pir/pages/:pageSlug/sections/data?showRatings=true"
    static let getWellbeingCategories = "px-client/wellbeing/categories"
    
    // MARK: - Wellbeing Reviews
    static let getAllReviews = "px-client/users/wellbeing/:planId/reviews?community=false"
    static let getMyReviews = "px-client/users/wellbeing/:planId/my-reviews"
    static let writeAReview = "px-client/users/wellbeing/reviews"
    
    static let pxSettingsPath = "px-client/microsite/px-settings"
    static let healthCareSectionsPath = "px-client/microsite/pir/pages/:pageSlug/sections" // to get MDV plans
    static let healthCarePlanDetailsPath = "px-client/microsite/pir/pages/:pageSlug/plans" // to get plan details
    static let bookmarkedPlanList = "px-client/account/bookmarks"
    static let getGlobalDetails = "px-client/microsite/pir/pages/GlobalTravels/sections"
    
    // MARK: - SSO Login
    static let extendSession = "users/login/session/extend"
    static let getUserDetails = "users/login/saml/token"
    
    //MARK: - CBSite Webpage route
    static let taxSavings = "/benefits/pir/p/TaxSaving?enrolled=true"
    static let incomeProtection = "/benefits/pir/p/IncomeProtection?enrolled=true"
    static let retirement = "/benefits/pir/p/Retirement?enrolled=true"
    static let totalRewards = "/total-rewards/statement"
    
    //MARK: - PX Client APIs
    static let getPXAppAnnouncements = "px-client/announcements?limit=999&offset=0&status=published"
    
    static let findCareCapability = "px-client/find-care/capability?allowVericredSearch=true" //This will return the content of the
    static let findCareSearchTypes = "px-client/find-care/search-types/v2?allowVericredSearch=true" //This will return which all search user can do Doctor, Pharmacy, hospital etc
    static let findcaredoctorList = "px-client/find-care/search-care"/*searchCode: P, postalCode: 60169, distance: 10,searchTerm: Cornor*/
    static let saveBookmark = "px-client/find-care/my-doctors/save-bookmark" //Post doctorId: A322AD7D444FA9C8A58DFF06F4FD6364
    static let removeBookmark = "px-client/find-care/my-doctors/remove-bookmark" //Delete doctorId: A322AD7D444FA9C8A58DFF06F4FD6364
    static let myDoctors = "px-client/find-care/my-doctors"
    static let getMobileUXConfig = "px-client/generic/configurations"
    
    static let recommendedDoctor = "px-client/find-care/my-doctors/recommended"
    
    //MARK: - W2Forms for S1
    static let getW2Forms = "s1/client/v1/payroll/org/{OrgId}/employee/{employeeId}/w2/download"
    
    // MARK: - Provider Reviews
    static let getAllProviderReviews = "px-client/find-care/:providerId/reviews?limit=20&offset=0"
    static let getMyPreviousProviderReviews = "px-client/find-care/:providerId/my-reviews"
    static let providerWriteAReview = "px-client/find-care/reviews"
    
    //MARK: - discussion apis
    static let getListOfDiscussion = "px-client/users/wellbeing/{wellbeing_careerplanId}/discussions"
    static let postDiscussion = "px-client/users/wellbeing/discussions"
    static let editDiscussion = "px-client/users/wellbeing/discussions/{comment_id}"
    static let deleteDiscussion = "px-client/users/wellbeing/discussions/{comment_id}"
    
    //MARK: - Coworkers
    static let getSettingsPreferences = "rtw/client/settings"
    static let getCoworkersListing = "rtw/client/user/listing"
    static let followACoworker = "rtw/client/toggle/following"
    static let coworkerSchedule = "rtw/client/followings/schedule"
    static let getCoworkerFollowers = "rtw/client/followers"
    static let removeFollower = "rtw/client/undo-request"
    static let getCoworkerFollowing = "rtw/client/followings"
    static let acceptRequest = "rtw/client/accept-request"
    
    //MARK: - Total Rewards
    static let pxClientCapability = "px-client/capability"
    
    //MARK: - Sequoia Cloud
    static let getOrgId = "sequoiacloud/data/v1/idmap/sfdcAccountId/{SFDCAccountId}/orgId"
    static let getEmployeeId = "sequoiacloud/data/v1/idmap/sfdcContactId/{SFDCContactId}/employeeId"
    
    //MARK: - Finances
    static let getFinancesCapability = "px-client/finances/capability"
    static let getFinancesCustomPages = "px-client/custom-pages/finances"
    
    static let generateOTPToken = "idm/generate-token"
    static let getProfile = "uam/users/profile"
    
    //MARK: - Multifactor OTP on Email
    static let validateOtp = "idm/otp/validate"
    static let resendOtp = "idm/otp/resend"
    
    //MARK: - Custom Pages
    static let navMoreOptions = "px-client/capabilityV2/nav/more"
    
    //MARK: - Benefits Capability
    static let benefitsCapability = "px-client/capabilityV2/nav/benefits"
    
    //MARK: - Users Profile Capability
    static let usersProfileCapability = "px-client/users/profile/capability"
    
    static let myApps = "px-client/dashboard/my-apps"
    static let homeCapability = "px-client/capabilityV2/nav/home"
    static let benAdminProviders = "px-client/account/providers"
    static let gainsightGlobalContext = "admin-core/gainsight-attributes"
}

struct APIConstantsKeys {
    // MARK: Authentication
    static let forceUpgradeErrorCode = 426
    static let invalidSessionErrorCode = 401
    static let serverDatabaseErrorCode = 460
    static let oktaSessionErrorCode = 1005
    static let cancellAllRequestErrorCode = -999
    static let serverMaintenanceErrorCode = 430
    static let loginErrorWhenSSOEnabled = 1018
    static let tooManyRequest = 3004
    static let otpExpired = 3003
    
    static let data = "data"
    static let email = "email"
    static let login = "login"
    static let password = "password"
    static let phoneNumber = "phoneNumber"
    static let OTP = "otp"
    static let otpToken = "otpToken"
    static let nextValidationStage = "nextValidationStage"
    static let inviteCode = "inviteCode"
    static let oktaId = "oktaId"
    static let errorMessageKey = "errorMessage"
    static let messageKey = "message"
    static let deviceUUID = "deviceUUId"
    static let deviceTypeId = "deviceTypeId"
    static let isDependent = "isDependent"
    static let tokenKey  = "token"
    static let apiToken = "apiToken"
    static let fName    =   "fName"
    static let lName    =   "lName"
    static let firstName    =   "firstName"
    static let lastName     =   "lastName"
    static let tempToken    =   "tempToken"
    static let iconURL      =  "iconUrl"
    static let isIdpAuthenticationSuccess = "isIdpAuthenticationSuccess"
    static let ssoLink      =   "ssoLink"
    static let dob          =   "dob"
    static let tempSignupToken  = "tempSignupToken"
    static let signupToken  = "signupToken"
    static let isActivated      = "isActivated"
    static let isSSOEnabled      = "isSsoEnabled"
    static let isTerminated     = "isTerminated"
    static let postbackLink = "postbackLink"
    static let dependentDob = "dependentDob"
    static let buildNumber = "buildNumber"
    static let isSignedUp = "isSignedUp"
    static let isSsoEnabled = "isSsoEnabled"
    static let userType = "userType"
    static let contactType = "contactType"
    static let showWelcome = "showWelcome"
    static let appVersionNumber = "appVersionNumber"
    static let deviceOSVersion = "deviceOSVersion"
    static let deviceName = "deviceName"
    
    static let userDetails: String = "userDetails"
    static let companyDetails: String = "companyDetails"
    static let userModel: String = "userModel"
    static let isActivatedKey: String = "isActivated"
    static let userDetailsKey: String = "userDetails"
    static let basicUserDetailsKey: String = "basicUserDetails"
    static let userIdKey: String = "userId"
    static let oktaIdKey: String = "oktaId"
    static let contactIdKey: String = "contactId"
    static let contact_IdKey: String = "contact_id"
    static let userRoleKey: String = "userRole"
    static let assignedCompaniesKey: String = "assignedCompanies"
    static let oktaSessionTokenKey: String = "oktaSessionToken"
    static let oktaSessionIdKey: String = "oktaSessionId"
    static let apiTokenKey: String = "apiToken"
    static let fNameKey: String = "fName"
    static let lNameKey: String = "lName"
    static let firstNameKey: String = "firstName"
    static let lastNameKey: String = "lastName"
    static let dobKey: String = "dob"
    static let middleNameKey: String = "middleName"
    static let isEmployeeKey: String = "isEmployee"
    static let statusKey: String = "status"
    static let companyDetailsKey: String = "companyDetails"
    static let profileScreenBackgroundColorKey: String = "profileScreenBackgroundColor"
    static let companyColorKey: String = "companyColor"
    static let companyNameKey: String = "companyName"
    static let companyLogoKey: String = "companyLogo"
    static let isReviewEnabled: String = "isReviewEnabled"
    static let isRead: String = "isRead"
    static let lob: String = "lob"
    static let employeeUserId: String = "employeeUserId"
    static let secondaryEmail: String = "secondaryEmail"

    // MARK: DASH BOARD
    static let employeeId = "employeeId"
    static let oktaSessionToken = "oktaSessionToken"
    static let oktaSessionId = "oktaSessionId"
    static let dependentId = "dependentId"
    static let dependentID = "dependentID"
    static let isLimited = "isLimited"
    static let roleId = "roleId"
    static let healthCardId = "healthCardId"
    static let healthCardType = "healthCardType"
    static let card_typesKey = "card_types"
    static let notification_ids = "notification_ids"
    static let categoryId = "categoryId"
    static let searchStrings = "searchStrings"
    static let subCategoryId = "subCategoryId"
    static let isLimitedAccess = "isLimitedAccess"
    
    // MARK: CARDS
    static let faqTitle = "title"
    static let benefitID = "benefitId"
    static let benefitType = "benefitType"
    static let beginServiceDate = "beginServiceDate"
    static let endServiceDate = "endServiceDate"
    static let serviceCost = "serviceCost"
    static let provider = "provider"
    static let serviceTypeId = "serviceTypeId"
    static let forWhom = "forWhom"
    static let json = "json"
    static let limit = "limit"
    static let offset = "offset"
    static let secondaryIns = "secondaryIns"
    static let knowledgeArticleId = "knowledgeArticleId"
    static let contactId = "contactId"
    static let memberId = "memberId"
    static let planType = "planType"
    static let carrierPlanId = "carrierPlanId"
    static let isBookmark = "isBookmark"
    static let year = "year"

    // MARK: FIND A DENTIST
    static let zipCode = "zipCode"
    static let distance = "distance"
    static let dentistName = "name"
    static let planNameKey = "planNameKey"
    static let pageNumber = "pageNumber"
    static let pageSize = "pageSize"
    static let isInsideNetwork = "isInsideNetwork"
    static let specialityId = "specialityId"
    
    // MARK: PROFILE
    static let feedback = "feedback"
    static let feedbackType = "feedbackType"
    static let oldPassword = "oldPassword"
    static let newPassword = "newPassword"
    static let comment = "comment"
    static let canFollowUp = "canFollowUp"
    static let rating = "rating"
    static let confirmPassword = "confirmPassword"
    static let pushNotificationStatus = "pushNotificationStatus"
    static let pushNotifications = "pushNotifications"
    static let unreadCount = "unReadCount"
    static let anyRightwayNotificationReceived = "newNotification"
    static let attchmentId = "attachmentIds"
    static let searchText = "searchString"
    static let invitedContactId = "invitedContactId"
    static let inviteeContactId = "inviteeContactId"
    static let inviteLink = "inviteLink"
    static let searchTextKey = "searchText"
    
    // MARK: CLAIMS
    static let planTypeId = "planTypeId"
    
    // MARK: FAQ
    static let contentTag = "contentTag"
    
    // MARK: CONTACTS
    static let caseAttachmentId = "attachmentId"
    static let caseAttachmentFileName = "attachmentFileName"
    static let commentBody = "commentBody"
    static let parentId = "parentId"
    static let reason = "reason"
    static let description = "description"
    static let attachmentFileName = "attachmentFileName"
    static let caseNumber = "caseNumber"
    static let caseId = "caseId"

    // MARK: FASTLINK
    static let fastLinkType = "fastLinkType"
    static let rsession = "rsession"
    static let token = "token"
    static let redirectReq = "redirectReq"
    static let app = "app"
    
    // MARK: FAILURE API KEYS
    
    static let apiRequest = "apiRequest"
    static let apiResponse = "apiResponse"
    static let stackTrace = "stackTrace"
    
    static let oldEmail = "oldEmail"
    static let newEmail = "newEmail"
    static let userName = "userName"

    // MARK: - FIND A DOCTOR
    static let providerTypeId = "providerTypeId"
    static let providerTypeCode = "providerTypeCode"
    static let specialityCode = "specialityCode"
    static let sortSequence = "sortSequence"
    static let isAsc = "isAsc"
    static let id = "id"
    static let providerName = "providerName"
    static let doctorName = "doctorName"
    static let doctorIds = "doctorIds"
    
    // MARK: SEQUOIA GUIDANCE
    static let page = "page"
    static let filter = "filter"
    static let type = "type"
    static let byType = "byType"
    static let featured = "featured"
    
    // MARK: - CONTACT SEQUOIA
    static let fullName = "fullName"
    static let errorRequest = "errorRequest"
    static let errorResponse = "errorResponse"
    
    // MARK: - Rightway
    static let appName = "appName"
    static let flowName = "flowName"
    static let operationId = "operationId"
    
    static let slugName = "slugName"
    
    // MARK: - RTW
    static let taskId = "taskId"
    static let spaceId = "spaceId"
    static let modalChoiceId = "modalChoiceId"
    static let cohort = "cohort"
    static let isCohortActive = "isCohortActive"
    static let locationId = "locationId"
    static let resStartTime = "resStartTime"
    static let resEndTime = "resEndTime"
    static let reservationStartTime = "reservationStartTime"
    static let reservationEndTime = "reservationEndTime"
    static let response = "response"
    static let cohortId = "cohortId"
    static let reservationType = "reservationType"
    static let reservationTypeId = "reservationTypeId"
    static let location = "location"
    static let computedCohortId = "computedCohortId"
    static let submittedProofUrl = "submittedProofUrl"
    static let file = "file"
    static let hasReserved = "hasReserved"
    static let date = "date"
    static let reservations = "reservations"
    static let reservationId = "reservationId"
    static let vendorName = "vendorNameSlug"
    static let doseDetails = "doseDetails"
    static let vaccineAttachmentKey = "attachmentKey"
    static let vaccinationTypeKey = "vaccinationType"
    
    // MARK: - Consent
    static let consentContactID = "contactID"
    static let consentID = "consentID"
    static let consentStatus = "consentStatus"
    
    //MARK: - Wellbeing
    static let micrositeID = "micrositeId"
    static let pageSlug = "pageSlug"
    static let vendorId = "vendorId"
    static let sfdcCarrierPlanId = "sfdcCarrierPlanId"
    static let planId = "planId"
    static let showRatings = "showRatings"
    static let customProgramDetails = "customProgramDetails"
    
    // MARK: - Email opt out
    static let sendEmailStatus = "sendEmailStatus"
    
    // MARK: - Announcement
    static let allAnnouncements = "all"
    static let announcementId = "id"
    
    // MARK: - Find Care APIs
    static let postalCode = "postalCode"
    static let searchCode = "searchCode"
    static let searchTerm = "searchTerm"
    static let doctorId = "doctorId"
    static let version = "version"
    
    //MARK: - Ratings & Reviews
    static let isAnonymous = "isAnonymous"
    static let reviewRating = "reviewRating"
    static let reviewTitle = "reviewTitle"
    static let reviewDescription = "reviewDescription"
    static let recommendToNetwork = "recommendToNetwork"
    static let providerId = "id"
    
    //MARK: - Coworkers
    static let isAccountPrivate = "isAccountPrivate"
    static let toShowWeekendReservation = "toShowWeekendReservation"
    static let follow = "follow"
    static let userIds = "userIds"
    static let startDate = "startDate"
    static let endDate = "endDate"
    static let followerId = "followerId"
    
    //MARK: -Total Rewards
    static let countryCode = "country"
}

class ApiConstants {
    static let deviceUDIDKey = "deviceUDIDKey"
    static var deviceUniqueIdentifier: String {
        //Need to make unique once the backend people make changes to handle device uniqueness.
       var udid = KeychainWrapper.defaultKeychainWrapper.string(forKey: deviceUDIDKey)
        if udid == nil || udid?.isEmpty == false {
            if let uniqueIdentifier = UIDevice.current.identifierForVendor?.uuidString {
                udid = uniqueIdentifier
                KeychainWrapper.defaultKeychainWrapper.set(uniqueIdentifier, forKey: deviceUDIDKey)
            }
        }
        return udid ?? ""
    }
    static let deviceTypeID: Int = 2
    static let networkErrorCode: Int = 600 // Defined in network manager, if we change in network we should use same here for app.

}
