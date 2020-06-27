//
//  SignInUpView.swift
//  Bible Buddy
//
//  Created by admin on 20.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI
import Firebase

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
        let storage = Storage.storage().reference()
        
        let uid = Auth.auth().currentUser?.uid
        
        session.signIn(email: email, password: password) {
            (result, error) in
            self.signInUpCompletionHandler(error: error)
        }
        
        storage.child("Profiles").child(uid!).downloadURL { (url, err) in
        
        if err != nil{
            
            print((err?.localizedDescription)!)
            return
        }
        
        checkUser { (exists, userName, uid, url) in
            if exists{
                UserDefaults.standard.set(true, forKey: "status")
                UserDefaults.standard.set(userName, forKey: "userName")
                UserDefaults.standard.set(uid, forKey: "uid")
                UserDefaults.standard.set("\(url)", forKey: "pic")
                NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
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

