//
//  TextMessage.swift
//  Bible Buddy
//
//  Created by admin on 01.06.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct TextMessage: View {
    
    var textMessage: String
    
    var body: some View {
        Text(textMessage)
            .font(.system(size: 18))
            .foregroundColor(Color.black)
            .padding(.top, 70)
            .padding(.bottom, 40)
            .multilineTextAlignment(.center)
    }
}

struct TextMessage_Previews: PreviewProvider {
    static var previews: some View {
        TextMessage(textMessage: "Do you really want to delete your profile?")
    }
}
