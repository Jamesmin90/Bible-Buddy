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
                EmailField(email: self.$email)
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
    }
    
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
        }
    }
}


struct DeleteProfileView_Previews: PreviewProvider {
    static var previews: some View {
        DeleteProfileView()
    }
}