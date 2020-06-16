//
//  Bible.swift
//  ChristeninMuenchen
//
//  Created by admin on 12.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct BibleView: View {
    
    @State var error: String = ""
    @State var data: String = ""
    @State var content: String = ""
    
    var chapterId: String
    
    var body: some View {
        VStack {
            if (content == "") {
                LoadingView()
                
                // TODO ERROR HANDLING
            }
            else {
                HTMLStringView(htmlContent: content).font(.system(size: 12))
            }
        }
        .navigationBarTitle("Kapitelinhalt")
        .padding(.horizontal)
        .background(Color("basicBackgroundColor")
        .edgesIgnoringSafeArea(.all))
        .onAppear() { self.getDataFromUrl() }
    }
    
    func getDataFromUrl() {
        
        let urlTest = "https://api.scripture.api.bible/v1/bibles/542b32484b6e38c2-01/chapters/\(chapterId)"
        
        var request = URLRequest(url: URL(string: urlTest)!)
        request.setValue("ea17ec75497f6980cc7d63f8428656da", forHTTPHeaderField: "api-key")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                self.error = "Failed 1"
                return
            }
            
            var result: ChapterContent?
            do {
                result = try JSONDecoder().decode(ChapterContent.self, from: data)
            }
            catch {
                self.error = "Failed 2"
            }
            
            guard let json = result else {
                self.error = "Failed 3"
                return
            }
            
            self.content = json.data.content
            
        }
        task.resume()
    }
    
}
