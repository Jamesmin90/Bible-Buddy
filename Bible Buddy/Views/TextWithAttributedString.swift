//
//  TextWithAttributedString.swift
//  Bible Buddy
//
//  Created by Jannis Gutleben on 23.06.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct TextWithAttributedString: UIViewRepresentable {

    var attributedString: NSMutableAttributedString
    var width: CGFloat
    func makeUIView(context: Context) -> UILabel {
        let label = UILabel(frame: CGRect(x: 0, y:0, width: width, height: 300))
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.preferredMaxLayoutWidth = width
        label.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        return label
    }
    
    func updateUIView(_ uiView: UILabel, context: UIViewRepresentableContext<TextWithAttributedString>){
        uiView.attributedText = attributedString
    }
    
}
