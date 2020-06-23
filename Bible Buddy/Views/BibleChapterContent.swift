//
//  Bible.swift
//  ChristeninMuenchen
//
//  Created by admin on 12.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct BibleChapterContent: View {
    
    @ObservedObject var bible = Bible()
    
    var chapterId: String
    
    var body: some View {
        VStack {
            
            if(bible.error != "") {
                Spacer()
                ErrorText(errorText: bible.error)
                Spacer()
            }
                
            else if (bible.chapterContent?.data.content == nil || bible.chapterContent?.data.content == "") {
                LoadingView()
            }
                
            else {
                HTMLStringView(htmlContent: (bible.chapterContent?.data.content)!)
            }
        }
        .navigationBarTitle("Kapitelinhalt")
        .padding(.horizontal)
        .background(Color("basicBackgroundColor")
        .edgesIgnoringSafeArea(.all))
        .navigationBarItems(trailing: bible.chapterContent?.data.content != nil ? AnyView(self.readButton) : AnyView(EmptyView())
        )
        .onAppear() { self.bible.getDataFromUrl(urlEndpoint: "chapters/\(self.chapterId)", type: ChapterContent.self) }
    }
    
    var readButton: some View {
        NavigationLink(
            destination: SpeechTestView(synthVM: SpeechSynthVM(text: (bible.chapterContent?.data.content)!))) {
            Image(systemName: "speaker.2")
        }
    }
}
