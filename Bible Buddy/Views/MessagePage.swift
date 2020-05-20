//
//  Messagepage.swift
//  Bible Buddy
//
//  Created by admin on 19.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI
import Combine
import Firebase

struct MessagePage: View {
    @ObservedObject var message = DataFire()
    @State private var selection: Int? = nil
    var sender = ""
    
    @Binding var image: Data
    
    @State var write = ""
    
    var body: some View {
        
        VStack{
            List(message.messages) { i in
                if i.sender == self.sender {
                    ListMessage(msg: i.msg, Message: true, sender: i.sender, image: i.$image)
                }else {
                    ListMessage(msg: i.msg, Message: false, sender: i.sender, image: i.$image)
                }
            }//list
                NavigationLink(destination: ContentView(), tag:1, selection: self.$selection){
                    Text("")
                }
                .navigationBarTitle("Chat Room", displayMode: .inline)
                .navigationBarItems(trailing: Button(action: { let firebaseAuth = Auth.auth()
                    do {
                      try firebaseAuth.signOut()
                    } catch let signOutError as NSError {
                      print ("Error signing out: %@", signOutError)
                    }
                    self.selection = 1
                }){
                    Text("Log Out")
                })
            
            HStack{
                TextField("Type here...", text: self.$write).padding(10)
                    .background(Color(red: 233.0/255, green: 234.0/255, blue: 243.0/255))
                .cornerRadius(25)
                
                Button(action: {
                    if self.sender == Auth.auth().currentUser?.email! {
                        self.message.addInfo(msg: self.write, user: self.sender, image: self.image, date: Date().timeIntervalSince1970)
                        self.write = ""
                    }else{
                        print("Error!")
                        print(self.sender)
                    }
                }){
                    Image(systemName: "paperplane.fill").font(.system(size: 20))
                        .foregroundColor((self.write.count > 0) ? Color.blue : Color.gray)
                        .rotationEffect(.degrees(50))
                    
                }//button
                }/*HStack*/ .padding()
        }
    }//bodyView
}


struct MessagePage_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
