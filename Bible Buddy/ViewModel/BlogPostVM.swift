//
//  BlogPostVM.swift
//  Bible Buddy
//
//  Created by jag on 29.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import Foundation
import Combine

class BlogPostVM: ObservableObject, Identifiable {
    @Published var post: BlogPost
    
    var id = ""
    
    private var cancellables = Set<AnyCancellable>()
    	
    init(post: BlogPost) {
        self.post = post
        
        $post
        .map { $0.id! }
        .assign(to: \.id, on: self)
        .store(in: &cancellables)
    }
}
