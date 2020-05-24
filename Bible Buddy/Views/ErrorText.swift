//
//  ErrorText.swift
//  Bible Buddy
//
//  Created by admin on 21.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct ErrorText: View {
    
    var errorText: String
    
    var body: some View {
        Text(errorText)
            .font(.system(size: 14, weight: .semibold))
            .foregroundColor(.red)
            .padding()
    }
}

struct ErrorText_Previews: PreviewProvider {
    static var previews: some View {
        ErrorText(errorText: "Error!")
    }
}
