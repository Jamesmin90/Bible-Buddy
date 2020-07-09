//
//  textFieldStyle.swift
//  Bible Buddy
//
//  Created by Jannis Gutleben on 12.06.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct MyTextFieldStyle: ViewModifier{
    
    func body(content: Content) -> some View {
        content
        .font(.system(size: 14))
        .padding(15)
        .background(RoundedRectangle(cornerRadius: 5)
            .strokeBorder(Color.black, lineWidth: 1))
        .background(Color(.white))
    }
    
    
}

