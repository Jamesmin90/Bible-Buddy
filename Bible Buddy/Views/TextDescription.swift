//
//  TextDescriptionEvents.swift
//  Bible Buddy
//
//  Created by admin on 14.06.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct TextDescription: View {
    var descriptiontext : String
    var height: CGFloat
    var body: some View {
        Text(self.descriptiontext)
        .font(.headline)
        .frame(minWidth: 0, maxWidth: .infinity)
        .frame(height: self.height)
        .padding(.vertical, 10)
        .background(Color.gray.opacity(0.5))
        .cornerRadius(10)
        
    }
}


