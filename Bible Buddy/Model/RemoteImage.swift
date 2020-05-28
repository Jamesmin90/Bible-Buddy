//
//  RemoteImage.swift
//  Bible Buddy
//
//  Created by admin on 27.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct RemoteImage: View {
    @ObservedObject var imageLoader = ImageLoader()
    
    var placeholder: Image
    
    init(url: String, placeholder: Image = Image(systemName:"people")){
        self.placeholder = placeholder
        imageLoader.fetchImage(url: url)
    }
    
    var body: some View {
        if let image = self.imageLoader.downloadImage{
                            
            return Image(uiImage:image).resizable().aspectRatio(contentMode: .fill).frame(width:380, height: 150).cornerRadius(12)
           
        }
        return placeholder
    }
}

struct RemoteImage_Previews: PreviewProvider {
    static var previews: some View {
        RemoteImage(url: "")
    }
}
