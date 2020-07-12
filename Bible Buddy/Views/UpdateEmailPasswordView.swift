//
//  UpdateEmailPasswordView.swift
//  Bible Buddy
//
//  Created by Clara Schönberger on 31.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct UpdateEmailPasswordView: View {
    
    @EnvironmentObject var session: SessionStore
    
    @Environment(\.presentationMode) var presMode: Binding<PresentationMode>
    
    @State var newEmail: String = ""
    @State var newPassword: String = ""
    @State var hidePassword: Bool = true
    @State var reauthenticationEmail = ""
    @State var reauthenticationPassword: String = ""
    
    @State var error: String = ""
    
    @State var showAlert: Bool = false
    
    @State var reauthenticationNecessary = false
    
    @State private var activeAlert: ActiveAlert = .updateWasSuccessful
    
    var continueText: String
    var buttonText: String
    
    var body: some View {
        
        VStack {
            
            TextMessage(textMessage: continueText)
            
            VStack(spacing: 15) {
                
                if (reauthenticationNecessary) {
                    UserInputTextField(userInput: self.$reauthenticationEmail, textFieldText: "Email-Adresse")
                    PasswordField(password: self.$reauthenticationPassword, hidePassword: self.$hidePassword)
                }
                    
                else {
                    if (buttonText == "Passwort ändern") {
                        PasswordField(password: self.$newPassword, hidePassword: self.$hidePassword)
                    } else {
                        UserInputTextField(userInput: self.$newEmail, textFieldText: "Email-Adresse")
                    }
                }
                
                ManageUserButton(handleButton: {
                    if (self.reauthenticationNecessary) {
                        self.reauthenticateAndUpdate()
                    } else {
                        (self.buttonText == "Passwort ändern") ? self.updatePassword() : self.updateEmail()
                    }
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
        .alert(isPresented: $showAlert) {
            switch activeAlert {
            case .updateWasSuccessful:
                return Alert(title: Text(""), message: Text("Änderung erfolgreich abgeschlossen"), dismissButton: .default(Text("OK"), action: {
                    self.presMode.wrappedValue.dismiss()
                }))
            case .showReauthentication:
                return Alert(title: Text(""), message: Text("Wir benötigen Ihre Zugangsdaten für eine erneute Authentifizierung, um die Änderung erfolgreich abschließen zu können."), dismissButton: .default(Text("OK"), action: {
                    self.error = ""
                    self.hidePassword = true
                    self.reauthenticationNecessary = true
                    self.showAlert = false
                }))
            }
        }
    }
    
    func updateEmail() {
        session.updateEmail(email: newEmail) {
            (error) in
            self.signInUpCompletionHandler(error: error)
        }
    }
    
    func updatePassword() {
        session.updatePassword(password: newPassword) {
            (error) in
            self.signInUpCompletionHandler(error: error)
        }
    }
    
    func reauthenticateAndUpdate() {
        session.reauthenticate(email: reauthenticationEmail, password: reauthenticationPassword) {
            (result, error) in
            self.signInUpCompletionHandler(error: error)
        }
    }
    
    func signInUpCompletionHandler(error: Error?) {
        if (error != nil) {
            guard let errorCode = AuthErrorCode(rawValue: error!._code) else { return }
            if (errorCode == AuthErrorCode.requiresRecentLogin && self.reauthenticationNecessary == false) {
                self.activeAlert = .showReauthentication
                self.showAlert = true
            }
            else if let error = error {
                self.error = error.localizedDescription
            }
        }
        else {
            if (reauthenticationNecessary) {
                self.reauthenticationNecessary = false
                (self.buttonText == "Passwort ändern") ? self.updatePassword() : self.updateEmail()
            }
            else {
                self.error = ""
                self.newEmail = ""
                self.newPassword = ""
                self.activeAlert = .updateWasSuccessful
                self.showAlert = true
            }
        }
    }
}

enum ActiveAlert {
    case updateWasSuccessful, showReauthentication
}


struct UpdateEmailPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateEmailPasswordView(continueText: "Please enter your new password", buttonText: "Update password")
    }
}
