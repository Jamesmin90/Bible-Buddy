//
//  BlogPostStore.swift
//  Bible Buddy
//
//  Created by Jannis Gutleben on 28.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import Foundation

class BaseBlogPostRepository {
  @Published var blogposts = [BlogPost]()
}

protocol BlogPostRepository: BaseBlogPostRepository {
  func addBlogPost(_ blogpost: BlogPost)
  func removeBlogPost(_ blogpost: BlogPost)
  func updateBlogPost(_ blogpost: BlogPost)
}


