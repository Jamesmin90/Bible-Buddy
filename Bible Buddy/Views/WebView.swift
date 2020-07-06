//
//  WebView.swift
//  Bible Buddy
//
//  Created by admin on 06.07.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    
    @State var url: String
    
    func makeUIView(context: UIViewRepresentableContext<WebView>) -> WebView.UIViewType {
        WKWebView(frame: .zero)
    }
    
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<WebView>) {
        let request = URLRequest(url: URL(string: self.url)!)
        uiView.load(request)
    }
    
    
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(url: "https://airtable.com/shrGyghlUB8Z75sjm")
    }
}
