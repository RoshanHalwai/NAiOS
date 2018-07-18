


enum VisitorListFBKeys_History : String {
    case dateAndTimeOfVisit
    case fullName
    case inviterUID
    case mobileNumber
    case profilePhoto
    case status
    case uid
    case handedThings
    
    var key : String {
        switch self {
        // Use Internationalization, as appropriate.
        case .dateAndTimeOfVisit: return "dateAndTimeOfVisit"
        case .fullName: return "fullName"
        case .inviterUID:
            return "inviterUID"
        case .mobileNumber:
            return "mobileNumber"
        case .profilePhoto:
            return "profilePhoto"
        case .status:
            return "status"
        case .uid:
            return "uid"
        case .handedThings:
            return "handedThings"
            
            
        }
    }
}
class NammaApartmentVisitor_History {
    
    //defining strings according to firebase names which is inside the visitor Node.
    private var dateAndTimeOfVisit: String?
    private var fullName: String?
    private var inviterUID: String?
    private var mobileNumber: String?
    private var profilePhoto: String?
    private var status: String?
    private var uid: String?
    private var Things: String?
   
    //initilaize the variables
    init(dateAndTimeOfVisit: String?,fullName: String?,inviterUID: String?,mobileNumber: String?,profilePhoto: String?,status: String?,uid: String?,Things:String) {
        
        self.dateAndTimeOfVisit = dateAndTimeOfVisit!
        self.fullName = fullName!
        self.inviterUID = inviterUID
        self.mobileNumber = mobileNumber
        self.profilePhoto = profilePhoto
        self.status = status
        self.uid = uid
        self.Things = Things
    }
    
    //Get FullName
    func getfullName() -> String {
        return fullName!
    }
    //Get DateAndTime
    func getdateAndTimeOfVisit() -> String {
        return dateAndTimeOfVisit!
    }
    //Get Photo
    func getprofilePhoto() -> String? {
        return profilePhoto!
    }
    //Get inviterUID
    func getinviterUID() -> String {
        return inviterUID!
    }
    //Get mobileNumber
    func getmobileNumber() -> String {
        return mobileNumber!
    }
    //Get status
    func getstatus() -> String {
        return status!
    }
    //Get uid
    func getuid() -> String {
        return uid!
    }
    func getThings() -> String {
        return Things!
    }
}
