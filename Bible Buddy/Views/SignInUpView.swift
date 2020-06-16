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
    
    @State var userName: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var hidePassword: Bool = true
    @State var error: String = ""
    @State var creation = false
    @State var loading = false
    var continueText: String
    var buttonText: String
    
    var body: some View {
        
        VStack {
            
            TextMessage(textMessage: continueText)
            
            EmailField(email: self.$email)
            
            PasswordField(password: self.$password, hidePassword: self.$hidePassword)
            
            if (buttonText == "Anmelden") {
                UserName(userName: $userName)
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
            
            if error != nil{
            self.signInUpCompletionHandler(error: error)
            }
            checkUser{ (exists, userName, uid, pic) in
                
                if exists{
                     UserDefaults.standard.set(true, forKey: "status")
                     
                     UserDefaults.standard.set(userName, forKey: "userName")
                    
                     UserDefaults.standard.set(uid, forKey: "uid")
                    
                     UserDefaults.standard.set(pic, forKey: "pic")
                     
                     NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
                }
                else{
                    self.loading.toggle()
                    self.creation.toggle()
                }
            }
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


struct SignInUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignInUpView(continueText: "123", buttonText: "Sign In")
    }
}

