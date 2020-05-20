//
//  ChatView.swift
//  Bible Buddy
//
//  Created by admin on 17.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI
import Firebase


struct RegisterView: View {
    @State var show = false
    @State var image: Data = .init(count: 0)
    @State var name: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State private var selection: Int? = nil
    @State var authenticationDidFail: Bool = false
    @State var authenticationDidSucceed: Bool = false
    

    
    var body: some View {
        ZStack{
            VStack{
                SetUp_login()
                
                if self.image.count != 0{
                    Image(uiImage: UIImage(data: self.image)!).resizable()
                        .frame(width: 55, height: 55)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                }else{
                    Button(action: {
                        self.show.toggle()
                    }){
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 55, height: 55)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                    }
                }//else
                
                TextField("Username...", text: self.$name).padding(10)
                    .background(Color(red: 233.0/255, green: 234.0/255, blue: 243.0/255))
                    .cornerRadius(20)
                TextField("Email...", text: self.$email).padding(10)
                .background(Color(red: 233.0/255, green: 234.0/255, blue: 243.0/255))
                .cornerRadius(20)
               
                TextField("Password...", text: self.$password).padding(10)
                .background(Color(red: 233.0/255, green: 234.0/255, blue: 243.0/255))
                .cornerRadius(20)
                
                NavigationLink(destination: MessagePage(sender: self.name, image: self.$image), tag:1, selection: self.$selection){
                    HStack{
                        
                        
                        Button(action: {
                            let email = self.email
                            let password = self.password
                            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                                if let e = error{
                                    self.authenticationDidFail = true
                                }else{
                                    self.selection = 1
                                }
                              
                            }                            
                        }){
                            Text("Enter").padding(12)
                            .foregroundColor(.white)
                            .background((self.name.count > 0) ? Color.blue : Color.gray)
                            .cornerRadius(8)
                        }//button
                    }//HStack
                }
            }/*VStack*/ .background(Color.white)
                .cornerRadius(20)
                .padding()
        }
            
        .sheet(isPresented: self.$show, content: {
            ImagePicker(show: self.$show, image: self.$image)
        })
        
    }//bodyView
    
    
    
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}

struct SetUp_login: View {
    var body: some View {
        Text("Let's get you set up")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .padding(.bottom, 20)
    }
}



/*
struct messageTextfield: View {
    @Binding var text: String

    var body: some View {
        TextField("What would you like to say?", text: self.$text)
            .padding()
            .background(SwiftUI.Color.white)
            .cornerRadius(10)
    }
}*/
/*
 @State private var text: String = ""
 @State var messages: [Message] = []
 let db = Firestore.firestore()
 NavigationView{
    VStack {
        List{
            Text(".")
        }
        HStack{
            messageTextfield(text: $text)

            Button(action:{
                let messageBody = self.text
                let messageSender = Auth.auth().currentUser?.email
                if Auth.auth().currentUser != nil {
                    self.db.collection(K.FStore.collectionName).addDocument(data: [K.FStore.senderField: messageSender,
                        K.FStore.bodyField: messageBody,
                        K.FStore.dataField: Date().timeIntervalSince1970]) { (error) in
                        if let e = error{
                            print("There was an issue saving data to firestore, \(e)")
                        }else{
                            print("Successfully sved data.")
                            
                            DispatchQueue.main.async {
                                self.text = ""
                            }
                            
                        }
                    }
                }
                
                self.db.collection(K.FStore.collectionName)
                    .order(by: K.FStore.dataField)
                    .addSnapshotListener{(querySnapshot, error) in
                    self.messages = []
                    if let e = error {
                        print("there was an issue retrieving data from Firestore. \(e)")
                    }else {
                        if let snapshotDocuments = querySnapshot?.documents{
                            for doc in snapshotDocuments{
                                let data = doc.data()
                                if let messageSender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String{
                                    let newMessage = Message(sender: messageSender, body: messageBody)
                                    self.messages.append(newMessage)
                                }
                            }
                        }
                    }
                }
            }){
                Image(systemName: "paperplane.fill").font(.system(size:25))
                    
            }
        }.padding()
            .background(SwiftUI.Color.init(UIColor(red: 0.15, green: 0.20, blue: 0.22, alpha: 0.9)).edgesIgnoringSafeArea(.all)

        );
    }
.navigationBarTitle(Text("Chat Room"), displayMode: .inline)
}*/

/* func loadMessages() {
    
    self.messages = []
    
    db.collection(K.FStore.collectionName).getDocuments{(querySnapshot, error) in
        if let e = error {
            print("there was an issue retrieving data from Firestore. \(e)")
        }else {
            if let snapshotDocuments = querySnapshot?.documents{
                for doc in snapshotDocuments{
                    let data = doc.data()
                    if let messageSender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String{
                        let newMessage = Message(sender: messageSender, body: messageBody)
                        self.messages.append(newMessage)
                    }
                }
            }
        }
        
    }
    
}*/
