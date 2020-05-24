//
//  SignInUpView.swift
//  Bible Buddy
//
//  Created by admin on 20.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct SignInUpView: View {
    
    var continueText: String
    var buttonText: String
    
    @State var email: String = ""
    @State var password: String = ""
    @State var error: String = ""
    @EnvironmentObject var session: SessionStore
    
    var body: some View {
        VStack {
            
            Text(continueText)
                .font(.system(size: 18))
                .foregroundColor(Color.black)
                .padding(.top, 70)
                .padding(.bottom, 40)
            
            VStack(spacing: 15) {
                TextField("Email address", text: $email)
                    .font(.system(size: 14))
                    .padding(15)
                    .background(RoundedRectangle(cornerRadius: 5)
                        .strokeBorder(Color.black, lineWidth: 1))
                    .background(Color(.white))
                
                SecureField("Password", text: $password)
                    .font(.system(size: 14))
                    .padding(15)
                    .background(RoundedRectangle(cornerRadius: 5)
                        .strokeBorder(Color.black, lineWidth: 1))
                    .background(Color(.white))
            }
            
            Button(action: (buttonText == "Sign up") ? signUp : signIn) {
                Text(buttonText)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 50)
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(.black)
                    .background(Color(#colorLiteral(red: 0.9198423028, green: 0.9198423028, blue: 0.9198423028, alpha: 1)))
                    .cornerRadius(5)
            }.padding(.top, 30)
            
            if (error != "") {
                ErrorText(errorText: error)
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .background(Color("basicBackgroundColor").edgesIgnoringSafeArea(.all))
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

