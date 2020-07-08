//
//  HTMLStringView.swift
//  Bible Buddy
//
//  Created by admin on 14.06.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import WebKit
import SwiftUI

struct HTMLStringView: UIViewRepresentable {
    let htmlContent: String
    
    var htmlStyling: String = "<head><style>p.p{color: black;font-size: 25px;display: inline-block;font-family: verdana;text-align: justify;padding: 30px; line-height: 2.0}span{color: black;font-weight: bold; font-size: 20}p.s{color: black;font-size: 40px;font-weight: bold;display: inline-block;font-family: verdana;padding: 30px; line-height: 2.0}p.s2{color: black;font-size: 20px;;display: inline-block;font-family: verdana;padding: 0px 30px; line-height: 2.0}</style></head>"
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(htmlStyling + htmlContent, baseURL: nil)
        uiView.isOpaque = false
        uiView.backgroundColor = UIColor(displayP3Red: 0.92, green: 1.00, blue: 1.00, alpha: 1.00)
    }
}
