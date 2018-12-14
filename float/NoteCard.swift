//
//  NoteCard.swift
//  float
//
//  Created by minsoo kim on 14/12/2018.
//  Copyright © 2018 minsoo kim. All rights reserved.
//

import Foundation
import UIKit

struct NoteCard {
    var noteCardID : String
    var noteCardText : String
    var noteCardSchedule : String?
    var noteCardIsTodo : Bool
    var noteCardIsAgenda : Bool
    var noteCardIsPinned : Bool
    private static func makeIdentifierByDate()->(String){
        let now = Date()
        let date = DateFormatter()
        date.locale = Locale(identifier: "ko_kr")
        date.timeZone = TimeZone(abbreviation: "KST")
        date.dateFormat = "yyMMddHHmmss"
        let kr = date.string(from:now)
        let ID = "nt" + kr + String(getUniqueIdentifier())
        return ID
    }
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        NoteCard.identifierFactory += 1
        return NoteCard.identifierFactory
    }
    
    init(text: String) {
        self.noteCardText = text
        self.noteCardID = NoteCard.makeIdentifierByDate()
        self.noteCardIsTodo  = false
        self.noteCardIsAgenda = false
        self.noteCardIsPinned  = false
    }
}
