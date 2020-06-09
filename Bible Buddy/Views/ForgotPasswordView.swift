//
//  ForgotPasswordView.swift
//  Bible Buddy
//
//  Created by admin on 29.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @EnvironmentObject var session: SessionStore
    
    @State var email: String = ""
    @State var errorMessage: String = ""
    
    @State var showAlert: Bool = false
    
    var continueText: String
    var buttonText: String
    
    var body: some View {
        
        VStack {
            
            TextMessage(textMessage: continueText)
            
            EmailField(email: self.$email)
            
            ManageUserButton(handleButton: {self.resetPassword()}, buttonText: buttonText)
            
            if (errorMessage != "") {
                ErrorText(errorText: errorMessage)
            }
            
            Spacer()
            
        }
        .padding(.horizontal)
        .background(Color("basicBackgroundColor")
        .edgesIgnoringSafeArea(.all))
        .alert(isPresented: self.$showAlert) {
            Alert(title: Text(""), message: Text("Es wurde erfolgreich eine Email zum Zurücksetzen Ihres Passwortes versendet."), dismissButton: .default(Text("OK"), action: {self.session.moveToRootView = true}))
        }
    }
    
    func resetPassword() {
        session.resetPassword(email: email) {
            (error) in
            self.signInUpCompletionHandler(error: error)
            
        }
    }
    
    func signInUpCompletionHandler(error: Error?) {
        if let error = error {
            self.errorMessage = error.localizedDescription
        } else {
            self.errorMessage = ""
            self.showAlert = true
        }
    }
}
