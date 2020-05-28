//
//  Events.swift
//  Bible Buddy
//
//  Created by admin on 21.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
// displays content on EventsView

import Foundation

struct Events{
    
    let name: String
    let imageURL: String
    let geo: String
    let date: String
    let location: String
    let signup: String
    let description: String
    
}

extension Events{
    static func all() -> [Events]{
    
        return [
            Events(name: "Bible Study", imageURL: "bible study", geo: "", date: "Date/Time: Donnerstag Abende // 19:30-21:00", location: "Location: LMU", signup: "Sign up:", description: "Jede Woche genießen wir die Gemeinschaft miteinander und beschäftigen uns mit Themen, die für unser christliches Leben wesentlich sind, um unseren Glauben zu stärken."),
            Events(name: "Worship", imageURL: "worship", geo: "", date: "Date/Time: Freitag, 23. Mai 2020, 19:30-21:00", location: "Location: Olympiahalle", signup: "Sign up:", description:"Johannes 4,24 sagt Gott ist Geist, und die ihn anbeten, müssen in Geist und Wahrheit anbeten. Kommt und seht euch das an! "),
            Events(name: "BBQ", imageURL: "bbq", geo: "", date: "Date/Time: 20. Juni 2020, 12:00-15:00", location: "Location: Hirschgarten, Munich", signup: "Sign up:", description:"BBQ, Kameradschaft, Getränke, Fussball, Frisbee, etc."),
            Events(name: "Summer Retreat", imageURL: "retreat", geo: "", date: "Date: 24. Juli - 26. Juli 2020", location: "Location: De Hoof 18, 5712 LM Someren, Netherlands", signup: "Sign up:", description:"350 Uni-Studenten aus Deutschland, Großbritannien, Frankreich, Spanien, Italien, den Niederlanden, Polen, Lettland, der Slowakei und Kroatien. 4 Hauptsitzungen, 3 Breakout-Sitzungen, 2 Vormittagsmissionen und 1 Vision. "),
            Events(name: "Church History Trip", imageURL: "church history", geo: "", date: "Date: 1. August - 15. August 2020", location: "Location: Rome, Cambridge, London, Eisenach, Herrnhut, Gut Elim, Konstanz, Prague", signup: "Sign up:", description:"Begleiten Sie uns auf unserer Reise durch Europa und sehen Sie, wie Gott sich in den letzten 500 Jahren in der Kirche bewegt hat. "),
            
    
        ]
    }
}
