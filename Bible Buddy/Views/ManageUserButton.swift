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
            BasicTextField(text: buttonText)
        }.padding(.top, 20)
    }
}
