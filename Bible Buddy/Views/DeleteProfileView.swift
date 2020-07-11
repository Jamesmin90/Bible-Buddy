//
//  DeleteProfileView.swift
//  Bible Buddy
//
//  Created by admin on 31.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseAuth

// Created by Clara
struct DeleteProfileView: View {
    
    @EnvironmentObject var session: SessionStore
    
    @State var email: String = ""
    @State var password: String = ""
    @State var hidePassword: Bool = true
    
    @State var error: String = ""
    
    @State var showReauthenticationAlert = false
    @State var reauthenticationNecessary = false
    
    var body: some View {
        
        VStack {
            
            TextMessage(textMessage: "Möchten Sie wirklich Ihr Profil entgültig löschen?")
            
            if (reauthenticationNecessary) {
                UserInputTextField(userInput: self.$email, textFieldText: "Email-Adresse")
                PasswordField(password: self.$password, hidePassword: self.$hidePassword)
            }
            
            ManageUserButton(handleButton: {
                (self.reauthenticationNecessary) ? self.reauthenticateAndDelete() : self.deleteUser()
            }, buttonText: "Ja - endgültig löschen")
            
            if (error != "") {
                ErrorText(errorText: error)
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .background(Color("basicBackgroundColor")
        .edgesIgnoringSafeArea(.all))
        .alert(isPresented: self.$showReauthenticationAlert) {
            Alert(title: Text(""), message: Text("Wir benötigen Ihre Zugangsdaten für eine erneute Authentifizierung, um Ihr Profil entfültig löschen zu können."), dismissButton: .default(Text("OK"), action: {self.reauthenticationNecessary = true}))
        }
    }
    
    func reauthenticateAndDelete() {
        session.reauthenticate(email: email, password: password) {
            (result, error) in
            self.signInUpCompletionHandler(error: error)
        }
    }
    
    
    func deleteUser() {
        session.delete() {
            (error) in
            self.signInUpCompletionHandler(error: error)
        }
// Clara


        

        
    }

// Created by Clara
    func signInUpCompletionHandler(error: Error?) {
        if (error != nil) {
            guard let errorCode = AuthErrorCode(rawValue: error!._code) else { return }
            if (errorCode == AuthErrorCode.requiresRecentLogin && self.reauthenticationNecessary == false) {
                self.showReauthenticationAlert = true
            }
            else if let error = error{
                self.error = error.localizedDescription
            }
        } else {
            if (reauthenticationNecessary) {
                deleteUser()
            }
// Created by James
            let id = UserDefaults.standard.value(forKey: "uid") as? String
            let db = Firestore.firestore()
            db.collection("users").document(id!).delete() { (err) in
                
                if err != nil{
                    print((err!.localizedDescription))
                    return
                }
                print("Erfolgreich gelöscht")
            }
            
            let storageRef = Storage.storage().reference()
            let desertRef = storageRef.child("Profiles").child(id!)
            
            desertRef.delete { err in
              if err != nil{
                  
                  print((err?.localizedDescription)!)
                  return
              }
            }
// James
        }
    }
}


struct DeleteProfileView_Previews: PreviewProvider {
    static var previews: some View {
        DeleteProfileView()
    }
}

// Clara
