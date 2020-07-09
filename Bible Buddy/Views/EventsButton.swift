//
//  EventsButton.swift
//  Bible Buddy
//
//  Created by James on 07.07.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI
import Firebase

struct EventsButton<JMButton: View>: View {
    
    let action: () -> Void
    let content: JMButton
    @State var isSelected = false
    var postName: String
    
    init(action: @escaping () -> Void, @ViewBuilder content: () -> JMButton, postName: String){
        self.action = action
        self.content = content()
        self.postName = postName
    }
    
    var body: some View {
        Button(action: {
            self.isSelected.toggle()
            let db = Firestore.firestore()
            let Username = UserDefaults.standard.value(forKey: "userName") as! String
            if self.isSelected == true{
            
                db.collection("events").document("\(self.postName)").collection("Interessiert").document("\(Username)").setData(["Interessiert":Username]) { (err) in
                    
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
            content
            .padding()
            .accentColor(isSelected ? .blue: .black)
            .background(isSelected ? Color.blue.opacity(0.2): Color.gray.opacity(0.5))
            .mask(Circle())
            
        }
            
    }
}

struct EventsButton2<JMButton2: View>: View {
    
    let action: () -> Void
    let content: JMButton2
    @State var isSelected = false
    var postName: String
    
    init(action: @escaping () -> Void, @ViewBuilder content: () -> JMButton2, postName: String){
        self.action = action
        self.content = content()
        self.postName = postName
    }
    
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
            content
            .padding()
            .accentColor(isSelected ? .blue: .black)
            .background(isSelected ? Color.blue.opacity(0.2): Color.gray.opacity(0.5))
            .mask(Circle())
            
        }
    }
}
