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
    //@Published
    var userProfileVM: UserProfileVM
    @Published var userProfile: UserProfile = UserProfile(id: "", vorName: "", surName: "", userName: "", pic: "", bookmark: "")
    @Published var dateString: String
    @Published var blogImage: Data = Data()
    
    var id = ""
    
    
    private var cancellables = Set<AnyCancellable>()
    	
    init(post: BlogPost) {
        self.post = post
        self.userProfileVM = UserProfileVM(userID: post.userID)
        
        var dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .medium
        let date = post.createdTime != nil ? post.createdTime!.dateValue() : Date()
        self.dateString = dateFormatter.string(from: date)
        
        $post
        .map { $0.id! }
        .assign(to: \.id, on: self)
        .store(in: &cancellables)
        	
        self.userProfileVM.$profile.sink { value in
            print("BlogPostVM updated for \(value.userName)")
            self.userProfile = value
        }.store(in: &cancellables)
        
        URLImage(urlString: post.imageURL).$data.sink{ data in
            self.blogImage = data
        }.store(in: &cancellables)
        
    }
    
    static func newBlogPost() -> BlogPostVM {
        BlogPostVM(post: BlogPost(title: "", body: "", userName: "", userID: "", category: "", imageURL: ""))
    }
}
