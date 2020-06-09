//
//  UpdateEmailPasswordView.swift
//  Bible Buddy
//
//  Created by admin on 31.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct UpdateEmailPasswordView: View {
    
    @EnvironmentObject var session: SessionStore
    
    @Environment(\.presentationMode) var presMode: Binding<PresentationMode>
    
    @State var email: String = ""
    @State var password: String = ""
    @State var hidePassword: Bool = true
    
    @State var error: String = ""
    
    @State var showAlert: Bool = false
    
    var continueText: String
    var buttonText: String
    
    var body: some View {
        
        VStack {
            
            TextMessage(textMessage: continueText)
            
            VStack(spacing: 15) {
                
                if (buttonText == "Passwort ändern") {
                    PasswordField(password: self.$password, hidePassword: self.$hidePassword)
                } else {
                    EmailField(email: self.$email)
                }
                
                ManageUserButton(handleButton: {
                    (self.buttonText == "Passwort ändern") ? self.updatePassword() : self.updateEmail()
                }, buttonText: buttonText)
            }
            
            if (error != "") {
                ErrorText(errorText: error)
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .background(Color("basicBackgroundColor")
        .edgesIgnoringSafeArea(.all))
        .alert(isPresented: self.$showAlert) {
            Alert(title: Text(""), message: Text("Änderung erfolgreich abgeschlossen"), dismissButton: .default(Text("OK"), action: {self.presMode.wrappedValue.dismiss()}))
        }
    }
    
    func updateEmail() {
        session.updateEmail(email: email) {
            (error) in
            self.signInUpCompletionHandler(error: error)
        }
    }
    
    func updatePassword() {
        session.updatePassword(password: password) {
            (error) in
            self.signInUpCompletionHandler(error: error)
        }
    }
    
    func signInUpCompletionHandler(error: Error?) {
        if let error = error {
            self.error = error.localizedDescription
        } else {
            self.error = ""
            self.email = ""
            self.password = ""
            self.showAlert = true
        }
    }
}


struct UpdateEmailPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateEmailPasswordView(continueText: "Please enter your new password", buttonText: "Update password")
    }
}
