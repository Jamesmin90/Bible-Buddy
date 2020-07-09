//
//  Bible.swift
//  ChristeninMuenchen
//
//  Created by admin on 12.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct BibleChapterContent: View {
    
    @EnvironmentObject var session: SessionStore
    
    @ObservedObject var bible = Bible()
    @State var showNotes: Bool = false
    @State var showAddNote: Bool = false
    @State var chapterId: String
    
    @ObservedObject var bookmarkFirebase = BookmarkFirestore()
    
    @State var bookmarkWasSet: Bool = false
    
    var chapterId: String
    
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
        .navigationBarItems(
            trailing:
            HStack{
            addButton
            Button(action: { self.showNotes.toggle() }) { Image(systemName: "square.on.square") }
            bible.chapterContent?.data.content != nil ? AnyView(self.readButton) : AnyView(EmptyView())
            })
            .sheet(isPresented: $showNotes) {
                NoteView(notelistVM: NoteListVM(session: self.session, chapterRef: self.chapterId), showAsLinks: false)
                //Text(self.chapterId)
        .navigationBarItems(trailing: bible.chapterContent?.data.content != nil ? AnyView(self.readButton) : AnyView(EmptyView()))
        .alert(isPresented: self.$bookmarkWasSet) {
            Alert(title: Text(""), message: (self.bookmarkFirebase.error == "") ? Text("Das Lesezeichen wurde erfolgreich gesetzt.") : Text(self.bookmarkFirebase.error), dismissButton: .default(Text("OK"), action: {self.bookmarkWasSet = false}))
        }
    }
    
    var readButton: some View {
        
        HStack {
            
            if (session.session != nil) {
                Button(action: {
                    self.bookmarkFirebase.updateBookMarkOfUser(bookmark: (self.bible.chapterContent?.data.id)!)
                    self.bookmarkWasSet = true
                }) {
                    Image("bookmark")
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: 20, height: 20)
                        .padding(.horizontal, 20)
                }
            }
            
            NavigationLink(
            destination: SpeechTestView(synthVM: SpeechSynthVM(text: (bible.chapterContent?.data.content)!))) {
                Image(systemName: "speaker.2")
            }
        }
    }
    
    func getChapterContent(chapterId: String) {
        
        let urlCombined = URLComponents(string: "https://api.scripture.api.bible/v1/bibles/542b32484b6e38c2-01/chapters/\(chapterId)")
        
        self.bible.getDataFromUrl(url: urlCombined!, type: ChapterContent.self)
    }
    var readButton: some View {
        NavigationLink(
        destination: SpeechTestView(synthVM: SpeechSynthVM(text: (bible.chapterContent?.data.content)!), chapterRef: self.$chapterId)) {
            Image(systemName: "speaker.2")
        }
    }
    
    var addButton: some View {
        HStack{
            NavigationLink(
                destination: NoteAddView(showSelf: $showAddNote, chapterRef: self.$chapterId), 
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
