

import UIKit

let KEY_USERNAME = "com.redong.app.username"

let KEY_PASSWORD = "com.redong.app.password"


class MJKeyChainHelper: NSObject {

    func getKeyChainQuery(service:String) -> NSMutableDictionary {
       
        return NSMutableDictionary(objects: [kSecClassGenericPassword,service,service,kSecAttrAccessibleAfterFirstUnlock], forKeys: [kSecClass as NSString,kSecAttrService as NSString,kSecAttrAccount as NSString,kSecAttrAccessible as NSString])
    }
    func saveUserName(username:String,userNameService:String,
                      pwd:String,pwdService:String) {
        var keyChainQuery = self.getKeyChainQuery(userNameService)
        
        SecItemDelete(keyChainQuery)
        keyChainQuery.setObject(NSKeyedArchiver.archivedDataWithRootObject(username), forKey: kSecValueData as String)     
        SecItemAdd(keyChainQuery, nil)
        keyChainQuery = self.getKeyChainQuery(pwdService)
        SecItemDelete(keyChainQuery)
        keyChainQuery.setObject(NSKeyedArchiver.archivedDataWithRootObject(pwd), forKey: kSecValueData as String)
        SecItemAdd(keyChainQuery, nil)
    }
    
    
}
