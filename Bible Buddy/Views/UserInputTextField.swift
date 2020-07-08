//
//  UserInputTextField.swift
//  Bible Buddy
//
//  Created by admin on 31.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct UserInputTextField: View {
    
    @Binding var userInput: String
    
    var textFieldText: String
    
    var body: some View {
        TextField(textFieldText, text: $userInput)
            .font(.system(size: 14))
            .padding(15)
            .background(RoundedRectangle(cornerRadius: 5)
                .strokeBorder(Color.black, lineWidth: 1))
            .background(Color(.white))
            .padding(.top, 8)
    }
}
