//
//  SignInUpView.swift
//  Bible Buddy
//
//  Created by admin on 20.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct SignInUpView: View {
    
    @EnvironmentObject var session: SessionStore
    
    @State var email: String = ""
    @State var password: String = ""
    @State var hidePassword: Bool = true
    
    @State var error: String = ""
    
    var continueText: String
    var buttonText: String
    
    var body: some View {
        
        VStack {
            
            TextMessage(textMessage: continueText)
            
            EmailField(email: self.$email)
            
            PasswordField(password: self.$password, hidePassword: self.$hidePassword)
            
            if (buttonText == "Anmelden") {
                NavigationLink(destination: ForgotPasswordView(continueText: "Geben Sie bitte Ihre Email-Adresse ein", buttonText: "Passwort zurücksetzen")) {
                    HStack {
                        Text("Passwort vergessen?")
                            .foregroundColor(.gray)
                            .font(.system(size: 15))
                        Spacer()
                    }.padding(.horizontal, 10)
                }.navigationBarTitle(Text(buttonText), displayMode: .inline)
            }
            
            ManageUserButton(handleButton: {
                (self.buttonText == "Registrieren") ? self.signUp() : self.signIn()
            }, buttonText: buttonText)
            
            if (error != "") {
                ErrorText(errorText: error)
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .background(Color("basicBackgroundColor")
        .edgesIgnoringSafeArea(.all))
    }
    
    func signIn() {
        session.signIn(email: email, password: password) {
            (result, error) in
            self.signInUpCompletionHandler(error: error)
        }
    }
    
    func signUp() {
        session.signUp(email: email, password: password) {
            (result, error) in
            self.signInUpCompletionHandler(error: error)
        }
    }
    
    func signInUpCompletionHandler(error: Error?) {
        if let error = error {
            self.error = error.localizedDescription
        } else {
            self.email = ""
            self.password = ""
        }
    }
}
