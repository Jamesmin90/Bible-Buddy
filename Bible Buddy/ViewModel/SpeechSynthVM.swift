//
//  SpeechSynthVM.swift
//  Bible Buddy
//
//  Created by jag on 19.06.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import Foundation
import AVFoundation
import SwiftUI

class SpeechSynthVM : NSObject, ObservableObject {
    @Published var attrString = NSMutableAttributedString()
    @Published var status = SpeechSynthStatus.Stopped
    var text: String = ""
    var prevText: String = ""
    var nextText: String = ""
    var sentences: [String] = []
    var position = 0
    private var speechSynthesizer = AVSpeechSynthesizer()
    
    enum SpeechSynthStatus {
        case Stopped
        case Speaking
        case Paused
    }
    
    init(text: String) {
        super.init()
        self.text = self.stripHTML(htmlText: text)
        self.sentences = self.text.components(separatedBy: "\n")
        self.text = sentences[0]
        self.nextText = sentences[1]
        self.attrString = NSMutableAttributedString(string: self.text)
        self.speechSynthesizer.delegate = self
    }
    
    func speak() {
        let voice = AVSpeechSynthesisVoice(language: "German")
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = voice
        speechSynthesizer.speak(utterance)
    }
    
    func pause() {
        if speechSynthesizer.isSpeaking {
            speechSynthesizer.pauseSpeaking(at: .immediate)
        }
    }
    
    func resume() {
        if speechSynthesizer.isPaused {
            speechSynthesizer.continueSpeaking()
        }
    }
    
    func stripHTML(htmlText: String) -> String {
        let value = NSMutableString(string: htmlText)
        let pattern = "<span.*?>[0-9]{1,3}</span>"
        let regex = try? NSRegularExpression(pattern: pattern)
        regex?.replaceMatches(in: value, options: .reportProgress, range: NSRange(location: 0,length: value.length), withTemplate: "\n")
        // Prints, We are big now aa#1#**aalot of salesaa#/1#*aa the money and cards aa#2#aaRober Langdon and Ambra Vidalaa#/2#**aa.
        let pattern2 = "<.*?>"
        let regex2 = try? NSRegularExpression(pattern: pattern2)
        regex2?.replaceMatches(in: value, options: .reportProgress, range: NSRange(location: 0,length: value.length), withTemplate: "")
        return value as String
    }
}

extension SpeechSynthVM : AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        self.status = .Speaking
    }
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didPause utterance: AVSpeechUtterance) {
        self.status = .Paused
    }
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didContinue utterance: AVSpeechUtterance) {
        self.status = .Speaking
    }
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {}
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
        print("Going to say \(utterance.speechString)")
        let mutableAttributedString = NSMutableAttributedString(string: utterance.speechString)
        mutableAttributedString.addAttribute(.foregroundColor, value: UIColor.red, range: characterRange)
        self.attrString = mutableAttributedString
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        print("Did finish speak")
        let mutableAttributedString = NSMutableAttributedString(string: utterance.speechString)
        mutableAttributedString.removeAttribute(.foregroundColor, range: NSRange(location: 0, length: utterance.speechString.count))
        self.attrString = mutableAttributedString
        self.status = .Stopped
        
        if (hasMore()) {
            updateTexts()
            speak()
        }
    }
    
    func updateTexts() {
        if (position > 0 && hasMore()) {
            prevText = sentences[position - 1]
            text = sentences[position]
            nextText = sentences[position + 1]
            position += 1
        }
    }
    
    func hasMore() -> Bool {
        if ((position + 1) < sentences.count) {
            return true
        } else {
            return false
        }
    }
}
