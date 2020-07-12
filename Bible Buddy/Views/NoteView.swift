//
//  NoteView.swift
//  Bible Buddy
//
//  Created by Jannis Gutleben on 06.07.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct NoteView: View {
    @EnvironmentObject var session: SessionStore
    
    @ObservedObject var notelistVM: NoteListVM

    var showAsLinks: Bool
    
    var body: some View {
        ZStack{
            
            Color(#colorLiteral(red: 0.4620226622, green: 0.8382837176, blue: 1, alpha: 0.22)).edgesIgnoringSafeArea(.all)
            List{
                if(showAsLinks == true) {
                ForEach(notelistVM.noteVMs) { noteVM in
                    NavigationLink(destination: BibleChapterContent(chapterId: noteVM.note.chapterRef)){
                        NoteCard(noteVM: noteVM)
                    }
                }
                } else {
                    ForEach(notelistVM.noteVMs) { noteVM in
                            NoteCard(noteVM: noteVM)
                    }

                }
            }.navigationBarTitle("Notizen", displayMode: .inline)
                .onAppear {
                    UITableView.appearance().separatorStyle = .none
            }
        }
    }
    
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Test")
    }
}
