//
//  BubbleView.swift
//  Bible Buddy
//
//  Created by admin on 12.07.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct ChatText: UIViewRepresentable {

    @Binding var text: String?
    @Binding var attributedText: NSAttributedString?
    @Binding var desiredHeight: CGFloat

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> UITextView {

        let uiTextView = UITextView()
        uiTextView.delegate = context.coordinator

        // Configure text view as desired...
        uiTextView.font = UIFont(name: "HelveticaNeue", size: 15)

        return uiTextView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        if self.attributedText != nil {
            uiView.attributedText = self.attributedText
        } else {
            uiView.attributedText = self.attributedText
        }

        // Compute the desired height for the content
        let fixedWidth = uiView.frame.size.width
        let newSize = uiView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))

        DispatchQueue.main.async {
            self.desiredHeight = newSize.height
        }
    }

    class Coordinator : NSObject, UITextViewDelegate {

        var parent: ChatText

        init(_ view: ChatText) {
            self.parent = view
        }

        func textViewDidEndEditing(_ textView: UITextView) {
            DispatchQueue.main.async {
                self.parent.text = textView.text
                self.parent.attributedText = textView.attributedText
            }
        }
    }
}
