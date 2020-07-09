//
//  NoteCard.swift
//  Bible Buddy
//
//  Created by jag on 07.07.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct NoteCard: View {
    @ObservedObject var noteVM: NoteVM
    
    var body: some View {
        
        VStack {
            
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text(noteVM.note.chapterRef)
                        .font(.headline)
                        .foregroundColor(.secondary)
                    }
                .layoutPriority(100)
                
                Spacer()
                
                VStack(alignment: .trailing){
                    Text(noteVM.dateString)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                
                
            }
            .padding()
            .background(Color(.white))
            
            Text(noteVM.note.noteText).padding()
        }.cornerRadius(10)
            .background(Color(.white))
         .overlay(
             RoundedRectangle(cornerRadius: 10)
                 .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
         )
         .padding([.top, .horizontal])
    }
}

struct NoteCard_Previews: PreviewProvider {
    static var previews: some View {
        NoteCard(noteVM: NoteVM(note: Note(id: "", userID: "123", chapterRef: "GEN.1", noteText: "Note")))
    }
}
