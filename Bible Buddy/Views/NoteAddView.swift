//
//  NoteAddView.swift
//  Bible Buddy
//
//  Created by jag on 08.07.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct NoteAddView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var showSelf: Bool
    @EnvironmentObject var session: SessionStore
    @State private var textStyle = UIFont.TextStyle.body
    
    @State var noteVM: NoteVM = NoteVM.init(note: Note(id: UUID().uuidString, userID: "", chapterRef: "", noteText: ""))
    @Binding var chapterRef: String
    
    @State private var showingImagePicker = false
    @State private var libraryImage: UIImage?
    
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            Form(){

                
                VStack(alignment: .leading) {
                    Text("Notiz für:").font(.headline)
                    Text(chapterRef)
                }
                VStack(alignment: .leading) {
                    Text("Text").font(.headline)
                    TextView(text: $noteVM.note.noteText, textStyle: $textStyle).frame(height: 300).modifier(MyTextFieldStyle())
                }
            }
            
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
                let noteListVM = NoteListVM(session: self.session)
                self.noteVM.note.userID = self.session.session != nil ? self.session.session!.uid : ""
                self.noteVM.note.chapterRef = self.chapterRef
                noteListVM.addNote(note: self.noteVM.note)
                    
                }
            
                
            ) {
                Text("Hinzufügen")
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding()
                    .frame(width: 220, height: 60)
                    .background(Color.gray)
                    .cornerRadius(6.0)
            }
        
        .navigationBarTitle("Notiz hinzufügen")
        
    }.buttonStyle(PlainButtonStyle())
    //.background(Color("basicBackgroundColor"))
    
}

}

