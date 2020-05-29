//
//  BlogPostListVM.swift
//  Bible Buddy
//
//  Created by jag on 29.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import Foundation
import Combine

class BlogPostListVM: ObservableObject {
    @Published var repository: BlogPostRepository = FirestoreBlogPostRepository()
    @Published var blogPostVMs = [BlogPostVM]()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        repository.$blogposts.map { posts in
            posts.map { post in
                BlogPostVM(post: post)
            }
        }.assign(to: \.blogPostVMs, on: self)
        .store(in: &cancellables)
    }
}
