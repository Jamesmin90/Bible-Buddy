//
//  ErrorText.swift
//  Bible Buddy
//
//  Created by Clara Schönberger on 21.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct ErrorText: View {
    
    var errorText: String
    
    var body: some View {
        
        HStack {
            Spacer()
            Text(errorText)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.red)
                .padding()
            Spacer()
        }
    }
}

struct ErrorText_Previews: PreviewProvider {
    static var previews: some View {
        ErrorText(errorText: "Error!")
    }
}
