//
//  PasswordField.swift
//  Bible Buddy
//
//  Created by admin on 01.06.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct PasswordField: View {
    
    @Binding var password: String
    @Binding var hidePassword: Bool
    
    var body: some View {
        
        HStack {
            
            if self.hidePassword {
                SecureField("Passwort", text: $password)
                    .font(.system(size: 14))
                    .padding(15)
            } else {
                TextField("Passwort", text: $password)
                    .font(.system(size: 14))
                    .padding(15)
            }
            
            Spacer()
            
            Button(action: {self.hidePassword.toggle()}) {
                Image(systemName: self.hidePassword ? "eye.slash.fill" : "eye.fill")
                    .foregroundColor(self.hidePassword ? Color.secondary : Color.green)
                    .padding(.horizontal, 20)
            }
            
        }
        .background(RoundedRectangle(cornerRadius: 5)
        .strokeBorder(Color.black, lineWidth: 1))
        .background(Color(.white))
        .padding(.top, 8)
    }
}
