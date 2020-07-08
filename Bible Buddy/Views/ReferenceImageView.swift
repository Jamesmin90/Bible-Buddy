//
//  ReferenceImageView.swift
//  Bible Buddy
//
//  Created by admin on 07.07.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct ReferenceImageView: View {
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            Group {
                    ReferenceImageItem(image: "bible", madeFrom: "Icon made by Freepik from www.flaticon.com", link: "https://www.flaticon.com/free-icon/bible_2913087?term=bible&page=1&position=9")
                
                    ReferenceImageItem(image: "event", madeFrom: "Icon made by Freepik from www.flaticon.com", link: "https://www.flaticon.com/free-icon/calendar_1142731?term=event&page=1&position=29%20")

                    ReferenceImageItem(image: "chat", madeFrom: "Icon made by Freepik from www.flaticon.com", link: "https://www.flaticon.com/free-icon/chat_2950581?term=chat&page=1&position=65%20")
                    
                    ReferenceImageItem(image: "mail", madeFrom: "Icon made by Freepik from www.flaticon.com", link: "https://www.flaticon.com/de/kostenloses-icon/email_561127?term=email&page=1&position=1%20")
                    
                    ReferenceImageItem(image: "trash", madeFrom: "Icon made by Freepik from www.flaticon.com", link: "https://www.flaticon.com/free-icon/lock_483408?term=password&page=1&position=7%20")
                    
                    ReferenceImageItem(image: "profile", madeFrom: "Icon made by Freepik from www.flaticon.com", link: "https://www.flaticon.com/de/kostenloses-icon/benutzer_1077114?term=profil&page=1&position=16")
                    
                    ReferenceImageItem(image: "password", madeFrom: "Icon made by Those Icons from www.flaticon.com", link: "https://www.flaticon.com/free-icon/delete_1345874?term=delete&page=1&position=2%20")
                    
                    ReferenceImageItem(image: "blog", madeFrom: "Icon made by Flat Icons from www.flaticon.com", link: "https://www.flaticon.com/free-icon/blog_1809216?term=blog&page=1&position=38%20")
                    
                    ReferenceImageItem(image: "imageReference", madeFrom: "Icon made by Good Ware from www.flaticon.com", link: "https://www.flaticon.com/de/kostenloses-icon/bild_702697")
                    
                    ReferenceImageItem(image: "upload-image", madeFrom: "Icon made by Kiranshastry from www.flaticon.com", link: "https://www.flaticon.com/de/kostenloses-icon/hinzufugen_1578253?term=add%20picture&page=1&position=9")
            }
            
            Group {
                    ReferenceImageItem(image: "notes", madeFrom: "Icon made by Note icon icon by Icons8", link: "https://icons8.com/icons/set/note")
            }
        }
        .padding().padding(.top, 50)
        .background(Color("basicBackgroundColor")
        .edgesIgnoringSafeArea(.all))
        .navigationBarTitle("Referenzen", displayMode: .inline)
    }
}

struct ReferenceImageView_Previews: PreviewProvider {
    static var previews: some View {
        ReferenceImageView()
    }
}
