import Foundation

final class UserData {
    
    private enum SettingKeys: String {
        case user
    }
    
    static var user: User! {
        get {
            guard let savedData = UserDefaults.standard.object(forKey: SettingKeys.user.rawValue) as? Data, let decodedModel = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedData) as? User else {return nil }
            return decodedModel
        }
        set {
            let defaults = UserDefaults.standard
            let key = SettingKeys.user.rawValue
            
            if let user = newValue {
                if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: user, requiringSecureCoding: false){
                    defaults.set(savedData, forKey: key)
                    
                }
                
            }
        }
    }
}
