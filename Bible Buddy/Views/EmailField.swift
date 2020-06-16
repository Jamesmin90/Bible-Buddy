//
//  EmailField.swift
//  Bible Buddy
//
//  Created by admin on 31.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct EmailField: View {
    
    @Binding var email: String
    
    var body: some View {
        TextField("Email-Adresse", text: $email)
            .font(.system(size: 14))
            .padding(15)
            .background(RoundedRectangle(cornerRadius: 5)
                .strokeBorder(Color.black, lineWidth: 1))
            .background(Color(.white))
    }
}

struct UserName: View {
    
    @Binding var userName: String
    
    var body: some View {
        TextField("UserName", text: $userName)
            .font(.system(size: 14))
            .padding(15)
            .background(RoundedRectangle(cornerRadius: 5)
            .strokeBorder(Color.black, lineWidth: 1))
            .background(Color(.white))
    }
}
