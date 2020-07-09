//
//  SpeechTestView.swift
//  Bible Buddy
//
//  Created by jag on 23.06.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//


import SwiftUI

struct SpeechTestView: View {
    @EnvironmentObject var session: SessionStore
    @ObservedObject var synthVM: SpeechSynthVM
    @State var showNotes: Bool = false
    @State var showAddNote: Bool = false
    
    @Binding var chapterRef: String
    
    var body: some View {
        ZStack{
            Color("basicBackgroundColor").edgesIgnoringSafeArea(.all)
        VStack{
            Spacer()
            Text(self.synthVM.prevText)
            GeometryReader{ geometry in
                TextWithAttributedString(attributedString: self.synthVM.attrString, width: geometry.size.width)
                }.frame(maxHeight: 300).padding()
            Text(self.synthVM.nextText)
            Spacer()
            playbackButton
            
        }
        }
        .navigationBarItems(
            trailing:
            HStack{
            addButton
            Button(action: { self.showNotes.toggle() }) { Image(systemName: "square.on.square") }
            })
            .sheet(isPresented: $showNotes) {
                NoteView(notelistVM: NoteListVM(session: self.session, chapterRef: self.chapterRef), showAsLinks: false)
                //Text(self.chapterId)
        }
    }
    
    var playbackButton: some View {
        switch synthVM.status {
        case .Stopped:
            return Button(action: {
                self.synthVM.speak()
            }) {
                Image(systemName: "play.circle.fill").font(.system(size: 42))
            }
        case .Speaking:
            return Button(action: {
                self.synthVM.pause()
            }) {
                Image(systemName: "pause.circle.fill").font(.system(size: 42))
            }
        case .Paused:
            return Button(action: {
                self.synthVM.resume()
            }) {
                Image(systemName: "play.circle.fill").font(.system(size: 42))
            }
        }
    }
    
    var addButton: some View {
        HStack{
            NavigationLink(
                destination: NoteAddView(showSelf: $showAddNote, chapterRef: $chapterRef),
            isActive: $showAddNote) {
                //Text("Add")
                EmptyView()
            }
            Button(action: {
                self.showAddNote.toggle()
            }) {
                Image(systemName: "square.and.pencil")
            }
        }
    }
}

