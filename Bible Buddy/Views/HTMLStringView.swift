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

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(htmlContent, baseURL: nil)
    }
}
