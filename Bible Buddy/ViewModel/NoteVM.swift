//
//  BoteVM.swift
//  Bible Buddy
//
//  Created by Jannis Gutleben on 06.07.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import Foundation
import Combine

class NoteVM: ObservableObject, Identifiable {
    @Published var note: Note
    @Published var dateString: String
    
    var id = ""
    
    private var cancellables = Set<AnyCancellable>()
        
    init(note: Note) {
        self.note = note
        
        var dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .medium
        let date = note.createdTime != nil ? note.createdTime!.dateValue() : Date()
        self.dateString = dateFormatter.string(from: date)
        
        $note
        .map { $0.id! }
        .assign(to: \.id, on: self)
        .store(in: &cancellables)
    }
    
    static func newNote() -> NoteVM {
        NoteVM(note: Note( userID: "", chapterRef: "", noteText: ""))
    }
}
