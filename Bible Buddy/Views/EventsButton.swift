//
//  EventsButton.swift
//  Bible Buddy
//
//  Created by James on 07.07.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI
import Firebase

struct EventsButton : View {
    
    @Binding var isSelected : Bool
    @Binding var postName: String
    
    var body: some View {
        Button(action: {
            self.isSelected.toggle()
            let db = Firestore.firestore()
            let Username = UserDefaults.standard.value(forKey: "userName") as! String
            if self.isSelected == true{
                
                db.collection("events").document("\(self.postName)").collection("Interessiert").document("\(Username)").setData(["Besuchen":Username]) { (err) in
                    
                    if err != nil{
                        
                        print((err?.localizedDescription)!)
                        print("fail")
                        return
                    }
                }
                db.collection("events").document("\(self.postName)").collection("Besuchen").document("\(Username)").delete(){
                    (err) in
                    
                    if err != nil{
                        
                        print((err?.localizedDescription)!)
                        print("fail")
                        return
                    }
                }
                
            } else{
                db.collection("events").document("\(self.postName)").collection("Interessiert").document("\(Username)").delete(){
                    (err) in
                    
                    if err != nil{
                        
                        print((err?.localizedDescription)!)
                        print("fail")
                        return
                    }
                }
                
            }
        }){
            Image(systemName: "flag")
            .frame(width: 40, height: 40)
        }
        .padding()
        .accentColor(isSelected ? .blue: .black)
        .background(isSelected ? Color.blue.opacity(0.2): Color.gray.opacity(0.5))
        .mask(Circle())
    }
}


struct EventsButton2 : View {
    
    @Binding var isSelected : Bool
    @Binding var postName: String
    
    var body: some View {
        Button(action: {
            self.isSelected.toggle()
            let db = Firestore.firestore()
            let Username = UserDefaults.standard.value(forKey: "userName") as! String
            if self.isSelected == true{
                
                db.collection("events").document("\(self.postName)").collection("Besuchen").document("\(Username)").setData(["Besuchen":Username]) { (err) in
                    
                    if err != nil{
                        
                        print((err?.localizedDescription)!)
                        print("fail")
                        return
                    }
                }
                db.collection("events").document("\(self.postName)").collection("Interessiert").document("\(Username)").delete(){
                    (err) in
                    
                    if err != nil{
                        
                        print((err?.localizedDescription)!)
                        print("fail")
                        return
                    }
                }
                
            } else{
                db.collection("events").document("\(self.postName)").collection("Besuchen").document("\(Username)").delete(){
                    (err) in
                    
                    if err != nil{
                        
                        print((err?.localizedDescription)!)
                        print("fail")
                        return
                    }
                }
                
            }
        }){
            Image(systemName: "checkmark")
            .frame(width: 40, height: 40)
        }
        .padding()
        .accentColor(isSelected ? .blue: .black)
        .background(isSelected ? Color.blue.opacity(0.2): Color.gray.opacity(0.5))
        .mask(Circle())
    }
}
