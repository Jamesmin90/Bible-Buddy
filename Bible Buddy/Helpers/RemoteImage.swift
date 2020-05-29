//
//  RemoteImage.swift
//  Bible Buddy
//
//  Created by admin on 27.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct RemoteImage: View {
    @ObservedObject var imageLoader: ImageLoader
    
    
    init(imageUrl: String){
        imageLoader = ImageLoader(imageUrl: imageUrl)
    }
    var body: some View{
        
        Image(uiImage: (imageLoader.data.count == 0) ? UIImage(named: "bbq")! : imageLoader.downloadImage!)
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(width:380, height: 150)
        .cornerRadius(12)
        
    }
    
    
}

struct RemoteImage_Previews: PreviewProvider {
    static var previews: some View {
        RemoteImage(imageUrl: "https://firebasestorage.googleapis.com/v0/b/bible-buddy-3cc17.appspot.com/o/Events%2Fworship.jpg?alt=media&token=a2c535e9-a0b9-47bd-83e6-53a6e187cb10")
    }
}


struct RemoteImage2: View {
    @ObservedObject var imageLoader: ImageLoader
    
    
    init(imageUrl: String){
        imageLoader = ImageLoader(imageUrl: imageUrl)
    }
    var body: some View{
        
        Image(uiImage: (imageLoader.data.count == 0) ? UIImage(named: "bible study")! : UIImage(data: imageLoader.data)! )
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(width:380, height: 250)
        .cornerRadius(12)
        
        
    }
    
    
}



