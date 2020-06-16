//
//  BibleContentOverview.swift
//  Bible Buddy
//
//  Created by admin on 15.06.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct BibleContentOverview: View {
    
    @State var error: String = ""
    @State var content: Books = Books(data: [])
    
    @State var buttonPressed: Bool = false
    
    @State var showChapters: Bool = false
    
    @State var testSelection: Int? = 0
    
    @State var isActive: Bool = false
    
    @State var chapters: Chapters = Chapters(data: [])
    
    var body: some View {
        VStack {
            Text("Wählen Sie bitte ein Buch aus der Bibel, welches Sie lesen möchten.").padding(50)
            
            Spacer()
            
            Button(action: {self.getDataFromUrl()}) {
                Text("1. Buch")
            }
            
            if (self.buttonPressed) {
                
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack {
                        ForEach(content.data, id: \.id) { book in
                            VStack {
                                NavigationLink(destination: BibleChaptersContentView(chapters: self.chapters).onAppear(perform: {
                                    print("TEST")
                                    self.getDataFromUrl2(bookId: "GEN")
                                })) {
                                    Text(book.nameLong)
                                        .frame(minWidth: 0, maxWidth: .infinity)
                                        .frame(height: 40)
                                        .font(.system(size: 13, weight: .bold))
                                        .foregroundColor(.black)
                                        .background(Color(#colorLiteral(red: 0.9198423028, green: 0.9198423028, blue: 0.9198423028, alpha: 1)))
                                        .padding(10)
                                }
                            }
                        }
                        
                    }
                }
            }
            //            }
        }.navigationBarTitle("Bücher")
    }
    
    func getDataFromUrl() {
        
        let urlTest = "https://api.scripture.api.bible/v1/bibles/542b32484b6e38c2-01/books"
        
        var request = URLRequest(url: URL(string: urlTest)!)
        request.setValue("ea17ec75497f6980cc7d63f8428656da", forHTTPHeaderField: "api-key")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                self.error = "Failed 1"
                return
            }
            
            var result: Books?
            do {
                result = try JSONDecoder().decode(Books.self, from: data)
            }
            catch {
                print("Decoding failed")
                self.error = "Failed 2"
            }
            
            guard let json = result else {
                self.error = "Failed 3"
                return
            }
            
            self.content = json
            
            self.buttonPressed = true
            
            //            self.getDataFromUrl2(bookId: "GEN")
        }
        task.resume()
    }
    
    
    
    
    
    
    
    func getDataFromUrl2(bookId: String) {
        
        let urlTest = "https://api.scripture.api.bible/v1/bibles/542b32484b6e38c2-01/books/\(bookId)/chapters"
        
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
            
            self.testSelection = 1
            
            //            self.buttonPressed = true
        }
        task.resume()
    }
}
