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
            Text(self.synthVM.prevText)
            GeometryReader{ geometry in
                    TextWithAttributedString(attributedString: self.synthVM.attrString, width: geometry.size.width)
                }
            
            Text(self.synthVM.nextText)
            playbackButton
            
        }
    }
    
    var playbackButton: some View {
        switch synthVM.status {
        case .Stopped:
            return Button(action: {
                self.synthVM.speak()
            }) {
                Text("speak")
            }
        case .Speaking:
            return Button(action: {
                self.synthVM.pause()
            }) {
                Text("pause")
            }
        case .Paused:
            return Button(action: {
                self.synthVM.resume()
            }) {
                Text("resume")
            }
        }
    }
}

