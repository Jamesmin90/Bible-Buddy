//
//  NoteListVM.swift
//  Bible Buddy
//
//  Created by Jannis Gutleben on 07.07.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import Foundation
import Combine

class NoteListVM: ObservableObject {
    @Published var repository: NoteRepository
    @Published var noteVMs = [NoteVM]()
    
    private var cancellables = Set<AnyCancellable>()
    
    init(session: SessionStore) {
        repository = FirestoreNoteRepository(userId: session.session!.uid)
        
        repository.$notes.map { notes in
            notes.map { note in
                NoteVM(note: note)
            }
        }.assign(to: \.noteVMs, on: self)
        .store(in: &cancellables)
    }
    
    init(session: SessionStore, chapterRef: String) {
        repository = FirestoreNoteRepository(userId: session.session!.uid, chapterRef: chapterRef)
        
        repository.$notes.map { notes in
            notes.map { note in
                NoteVM(note: note)
            }
        }.assign(to: \.noteVMs, on: self)
        .store(in: &cancellables)
    }
    
    
    func addNote(note: Note) {
        repository.addNote(note)
    }
    
    func setUserId(userID: String) {
        
    }
}

