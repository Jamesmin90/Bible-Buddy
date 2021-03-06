//
//  BasicTextField.swift
//  Bible Buddy
//
//  Created by Clara Schönberger on 26.06.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct BasicTextField: View {
    
    var text: String
    
    var body: some View {
        Text(text)
            .frame(minWidth: 0, maxWidth: .infinity)
            .frame(height: 45)
            .font(.system(size: 13, weight: .bold))
            .foregroundColor(.black)
            .background(Color("basicForegroundColor"))
            .cornerRadius(5)
            .padding(10)
    }
}

struct BasicTextField_Previews: PreviewProvider {
    static var previews: some View {
        BasicTextField(text: "Test")
    }
}
