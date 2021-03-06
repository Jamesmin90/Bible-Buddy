//
//  checkUser.swift
//  Bible Buddy
//
//  Created by James on 15.06.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import Foundation
import Firebase

func checkUser(completion: @escaping (Bool,String,String,String)->Void){
    
    let db = Firestore.firestore()
    
    db.collection("users").getDocuments { (snap, err) in
        
        if err != nil{
                    
                    print((err?.localizedDescription)!)
                    return
                }
                
                for i in snap!.documents{
                    
                    if i.documentID == Auth.auth().currentUser?.uid{
                        
                        completion(true,i.get("userName") as! String,i.documentID,i.get("pic") as! String)
                        return
                    }
                }
                
                completion(false,"","","")
            }
            
        }
