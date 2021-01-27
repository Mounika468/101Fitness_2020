//
//  AWSUserSingleton.swift
//  1O1 Fitness
//
//  Created by Mounika.x.muduganti on 27/12/19.
//  Copyright © 2019 Mounika.x.muduganti. All rights reserved.
//

import Foundation
import AWSMobileClient

class AWSUserSingleton{
    
    static let shared = AWSUserSingleton()
    
    //Initializer access level change now
    private init(){}
    func getUserToken()->String
    {
        
        var token = ""
        AWSMobileClient.sharedInstance().getTokens { (tokens, error) in
            if let error = error {
                            print("Error getting token \(error.localizedDescription)")
                        } else if let tokens = tokens {
                            print(tokens.accessToken!.tokenString!)
             let userdefaults = UserDefaults.standard
                if let savedValue = userdefaults.string(forKey: UserDefaultsKeys.accessToken){
                 userdefaults.removeObject(forKey: UserDefaultsKeys.accessToken)
             }
                token = tokens.accessToken!.tokenString!
             userdefaults.set(tokens.accessToken!.tokenString!, forKey:UserDefaultsKeys.accessToken)
         }
             
        }
       return token
    }
    func refreshToken( finished : @escaping (String) -> Void) {
        var token = ""
        AWSMobileClient.sharedInstance().getTokens { (tokens, error) in
            if let error = error {
                            print("Error getting token \(error.localizedDescription)")
                finished("")
                        } else if let tokens = tokens {
                            print(tokens.accessToken!.tokenString!)
             let userdefaults = UserDefaults.standard
                if let savedValue = userdefaults.string(forKey: UserDefaultsKeys.accessToken){
                 userdefaults.removeObject(forKey: UserDefaultsKeys.accessToken)
             }
                            token = tokens.accessToken!.tokenString!
             userdefaults.set(tokens.accessToken!.tokenString!, forKey:UserDefaultsKeys.accessToken)
                            finished(token)
         }
             
        }
        
        AWSMobileClient.sharedInstance().changePassword(currentPassword: "", proposedPassword: "") { (error) in
            if let error = error {
                            print("Error getting token \(error.localizedDescription)")
            }
        }
    }
    
    func getUserattributes()
    {
        
         AWSMobileClient.sharedInstance().getTokens { (tokens, error) in
                    if let error = error {
                                    print("Error getting token \(error.localizedDescription)")
                                } else if let tokens = tokens {
                                    print(tokens.accessToken!.tokenString!)
                     let userdefaults = UserDefaults.standard
                        if let savedValue = userdefaults.string(forKey: UserDefaultsKeys.accessToken){
                         userdefaults.removeObject(forKey: UserDefaultsKeys.accessToken)
                     }
                     userdefaults.set(tokens.accessToken!.tokenString!, forKey:UserDefaultsKeys.accessToken)
                 }
                }
        AWSMobileClient.sharedInstance().getUserAttributes { (attributes, error) in
             if(error != nil){
                print("ERROR: \(error?.localizedDescription)")
             }else{
                if let attributesDict = attributes{
                    print(attributesDict["sub"])
                    let userdefaults = UserDefaults.standard
                    if userdefaults.string(forKey: UserDefaultsKeys.subId) != nil{
                        userdefaults.removeObject(forKey: UserDefaultsKeys.subId)
                    }
                    userdefaults.set(attributesDict["sub"], forKey:UserDefaultsKeys.subId)
                    if userdefaults.string(forKey: UserDefaultsKeys.name) != nil{
                        userdefaults.removeObject(forKey: UserDefaultsKeys.name)
                    }
                    userdefaults.set(attributesDict["name"], forKey:UserDefaultsKeys.name)
                    if userdefaults.string(forKey: UserDefaultsKeys.email) != nil{
                        userdefaults.removeObject(forKey: UserDefaultsKeys.email)
                    }
                    userdefaults.set(attributesDict["email"], forKey:UserDefaultsKeys.email)
                }
             }
        }
    }
    
}

