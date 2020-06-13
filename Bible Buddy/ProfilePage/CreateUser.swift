//
//  CreateUser.swift
//  Bible Buddy
//
//  Created by admin on 13.06.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import Foundation
import Firebase


func CreateUser(name: String, imagedata : Data,completion : @escaping (Bool)-> Void){
    
    let db = Firestore.firestore()
    
    let storage = Storage.storage().reference()
    
    let uid = Auth.auth().currentUser?.uid
    
    storage.child("Profiles").child(uid!).putData(imagedata, metadata: nil) { (_, err) in
        
        if err != nil{
            
            print((err?.localizedDescription)!)
            return
        }
        
        storage.child("Profiles").child(uid!).downloadURL { (url, err) in
            
            if err != nil{
                
                print((err?.localizedDescription)!)
                return
            }
            
            db.collection("users1").document(uid!).setData(["name":name,"pic":"\(url!)","uid":uid!]) { (err) in
                
                if err != nil{
                    
                    print((err?.localizedDescription)!)
                    return
                }
                
                completion(true)
                
                UserDefaults.standard.set(true, forKey: "status")
                
                UserDefaults.standard.set(name, forKey: "UserName")
                
                UserDefaults.standard.set(uid, forKey: "UID")
                
                UserDefaults.standard.set("\(url!)", forKey: "pic")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    
                    NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
                }
            }
        }
    }
}
