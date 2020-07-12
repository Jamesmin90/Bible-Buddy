//
//  Bible.swift
//  Bible Buddy
//
//  Created by Clara Schönberger on 21.06.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import Foundation

class Bible: ObservableObject {
    
    @Published var books: Books = Books(data: [])
    @Published var chapters: ChaptersList = ChaptersList(data: [])
    @Published var chapterContent: ChapterContent? = nil
    @Published var searchResult: BibleSearchResult? = nil
    @Published var error: String = ""
    
    var errorMessage: String = "Es ist leider etwas schief gelaufen. Bitte versuchen Sie es später noch einmal."
    
    func getDataFromUrl<T: Decodable>(url: URLComponents, type: T.Type) {
        
        var request = URLRequest(url: (url.url)!)
        request.setValue("ea17ec75497f6980cc7d63f8428656da", forHTTPHeaderField: "api-key")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            DispatchQueue.main.async {
                
                guard let data = data, error == nil else {
                    self.error = self.errorMessage
                    return
                }
                
                var result: T?
                do {
                    result = try JSONDecoder().decode(T.self, from: data)
                }
                catch {
                    self.error = self.errorMessage
                    
                }
                
                guard let json = result else {
                    self.error = self.errorMessage
                    return
                }
                
                if (type is ChapterContent.Type) {
                    self.chapterContent = json as? ChapterContent
                }
                else if(type is ChaptersList.Type) {
                    self.chapters = json as! ChaptersList
                }
                else if(type is Books.Type) {
                    self.books = json as! Books
                }
                else if(type is BibleSearchResult.Type) {
                    self.searchResult = json as? BibleSearchResult
                }
                else {
                    self.error = self.errorMessage
                }
            }
        }
        task.resume()
    }
}
