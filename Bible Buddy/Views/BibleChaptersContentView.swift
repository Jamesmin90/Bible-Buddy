//
//  BibleChaptersContentView.swift
//  Bible Buddy
//
//  Created by admin on 15.06.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct BibleChaptersContentView: View {
    
    var bookId: String
    
    @State var chapters: Chapters = Chapters(data: [])
    
    @State var error: String = ""
    
    var body: some View {
        
        VStack {
            
            if (chapters.data.count == 0) {
                
                LoadingView()
                
                // TODO: ERROR MESSAGE
                
            } else {
                
                TextMessage(textMessage: "Welches Kapitel möchten Sie lesen?")
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack {
                        
                        ForEach(chapters.data, id: \.id) { chapter in
                            
                            
                            VStack {
                                NavigationLink(destination: BibleView(chapterId: chapter.id)) {
                                     Text(chapter.reference)
                                         .frame(minWidth: 0, maxWidth: .infinity)
                                         .frame(height: 40)
                                         .font(.system(size: 13, weight: .bold))
                                         .foregroundColor(.black)
                                         .background(Color(#colorLiteral(red: 0.9198423028, green: 0.9198423028, blue: 0.9198423028, alpha: 1)))
                                         .padding(10)
                                 }
                             }
                            
//                            Text(chapter.reference)
//                                .frame(minWidth: 0, maxWidth: .infinity)
//                                .frame(height: 40)
//                                .font(.system(size: 13, weight: .bold))
//                                .foregroundColor(.black)
//                                .background(Color(#colorLiteral(red: 0.9198423028, green: 0.9198423028, blue: 0.9198423028, alpha: 1)))
//                                .padding(10)
//                                .padding(.horizontal, 10)
                        }
                    }
                }
            }
        }
        .navigationBarTitle("Kapitel")
        .padding(.horizontal)
        .background(Color("basicBackgroundColor")
        .edgesIgnoringSafeArea(.all))
        .onAppear() { self.getDataFromUrl2() }
    }
    
    func getDataFromUrl2() {
        
        let urlTest = "https://api.scripture.api.bible/v1/bibles/542b32484b6e38c2-01/books/\(self.bookId)/chapters"
        
        var request = URLRequest(url: URL(string: urlTest)!)
        request.setValue("ea17ec75497f6980cc7d63f8428656da", forHTTPHeaderField: "api-key")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                self.error = "Failed 1"
                return
            }
            
            var result: Chapters?
            do {
                result = try JSONDecoder().decode(Chapters.self, from: data)
            }
            catch {
                print("Decoding failed")
                self.error = "Failed 2"
            }
            
            guard let json = result else {
                self.error = "Failed 3"
                return
            }
            
            self.chapters = json
        }
        task.resume()
    }
}
