//
//  NoteRepository.swift
//  Bible Buddy
//
//  Created by Jannis Gutleben on 06.07.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import Foundation

class BaseNoteRepository {
  @Published var notes = [Note]()
}

protocol NoteRepository: BaseNoteRepository {
  func addNote(_ note: Note)
}
