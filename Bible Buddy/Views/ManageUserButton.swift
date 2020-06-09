//
//  ManageUserButton.swift
//  Bible Buddy
//
//  Created by admin on 01.06.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct ManageUserButton: View {
    
    var handleButton: () -> Void
    
    var buttonText: String
    
    var body: some View {
        
        Button(action: {self.handleButton()}) {
            Text(buttonText)
                .frame(minWidth: 0, maxWidth: .infinity)
                .frame(height: 50)
                .font(.system(size: 13, weight: .bold))
                .foregroundColor(.black)
                .background(Color(#colorLiteral(red: 0.9198423028, green: 0.9198423028, blue: 0.9198423028, alpha: 1)))
                .cornerRadius(5)
        }.padding(.top, 30)
    }
}
