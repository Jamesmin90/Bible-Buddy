//
//  SpeechTestView.swift
//  Bible Buddy
//
//  Created by jag on 23.06.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//


import SwiftUI

struct SpeechTestView: View {
    @ObservedObject var synthVM: SpeechSynthVM
    var body: some View {
        VStack{
            GeometryReader{ geometry in
                ScrollView {
                    TextWithAttributedString(attributedString: self.synthVM.attrString, width: geometry.size.width)
                }
            }
            
            Button(action: {
                self.synthVM.speak()
            }) {
                Text("speak")
            }
        }
    }
}

