//
//  Bible.swift
//  ChristeninMuenchen
//
//  Created by admin on 12.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//
// Created by Clara
import SwiftUI

struct BibleChapterContent: View {
    
    @EnvironmentObject var session: SessionStore
    @ObservedObject var bookmarkFirebase = BookmarkFirestore()
    @ObservedObject var bible = Bible()
    @State var bookmarkWasSet: Bool = false
    @State var chapterId: String
// Clara
// Created by Jannis
    @State var showNotes: Bool = false
    @State var showAddNote: Bool = false
// Jannis
// Created by Clara
    var body: some View {
        VStack {
            
            if(bible.error != "") {
                Spacer()
                ErrorText(errorText: bible.error)
                Spacer()
            }
                
            else if (bible.chapterContent?.data.content == nil || bible.chapterContent?.data.content == "") {
                LoadingView()
            }
                
            else {
                
                HTMLStringView(htmlContent: (bible.chapterContent?.data.content)!)
                
                HStack {
                    
                    if (self.bible.chapterContent?.data.previous?.id != nil && self.bible.chapterContent?.data.previous?.id != "") {
                        Button(action: {
                            self.getChapterContent(chapterId: (self.bible.chapterContent?.data.previous!.id)!)
                        }) {
                            BasicTextField(text: "vorheriges Kapitel")
                        }
                    }
                    
                    Spacer()
                    
                    if (self.bible.chapterContent?.data.next?.id != nil && self.bible.chapterContent?.data.next?.id != "") {
                        Button(action: {
                            self.getChapterContent(chapterId: (self.bible.chapterContent?.data.next!.id)!)
                        }) {
                            BasicTextField(text: "nächstes Kapitel")
                        }
                    }
                }.padding(.top, 5)
            }
        }
        .navigationBarTitle(self.bible.chapterContent?.data.reference ?? "")
        .padding(.horizontal)
        .background(Color("basicBackgroundColor")
        .edgesIgnoringSafeArea(.all))
        .onAppear() { self.getChapterContent(chapterId: self.chapterId) }
// Clara
// Created by Jannis
        .sheet(isPresented: $showNotes) {
            NoteView(notelistVM: NoteListVM(session: self.session, chapterRef: self.chapterId), showAsLinks: false)
            }
        .navigationBarItems(trailing: self.bible.chapterContent?.data.content != nil ? AnyView(self.navigationBarButtons) : AnyView(EmptyView()))
// Jannis
// Created by Clara
        .alert(isPresented: self.$bookmarkWasSet) {
            Alert(title: Text(""), message: (self.bookmarkFirebase.error == "") ? Text("Das Lesezeichen wurde erfolgreich gesetzt.") : Text(self.bookmarkFirebase.error), dismissButton: .default(Text("OK"), action: {self.bookmarkWasSet = false}))
        }
    }
// Clara
// Created by Jannis & Clara
    var navigationBarButtons: some View {
        HStack {
            if(session.session != nil) {
                addButton
                showNotesButton
                bookmarkButton
            }
            readButton
        }
        
        
    }
    
    var bookmarkButton: some View {
        
        Button(action: {
            self.bookmarkFirebase.updateBookMarkOfUser(bookmark: (self.bible.chapterContent?.data.id)!)
            self.bookmarkWasSet = true
        }) {
            Image(systemName: "bookmark")
                .padding(.horizontal, 5)
        }
    }
  
    var readButton: some View {
        NavigationLink(
        destination: SpeechTextView(synthVM: SpeechSynthVM(text: (bible.chapterContent?.data.content)!), chapterRef: self.$chapterId)) {
            Image(systemName: "speaker.2")
            .padding(.horizontal, 5)
        }
    }
    
    var addButton: some View {
        HStack{
            NavigationLink(
                destination: NoteAddView(showSelf: $showAddNote, chapterRef: self.$chapterId), 
                isActive: $showAddNote) {
                    EmptyView()
            }
            Button(action: {
                self.showAddNote.toggle()
            }) {
                Image(systemName: "square.and.pencil")
                .padding(.horizontal, 5)
            }
        }
    }
    
    var showNotesButton: some View {
        Button(action: { self.showNotes.toggle() }) {
            Image(systemName: "square.on.square")
                .padding(.horizontal, 5)
        }
    }
// Jannis & Clara
// Created by Clara
    func getChapterContent(chapterId: String) {
        
        let urlCombined = URLComponents(string: "https://api.scripture.api.bible/v1/bibles/542b32484b6e38c2-01/chapters/\(chapterId)")
        
        self.bible.getDataFromUrl(url: urlCombined!, type: ChapterContent.self)
    }
}
//Clara
