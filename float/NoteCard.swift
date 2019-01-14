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
    var noteCardIsTodoDone : Bool
    var noteCardIsAgenda : Bool
    var noteCardIsPinned : Bool
    var noteCardBody : String
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
    var siblingNotes : [NoteCard]
    mutating func addSibling(add card: NoteCard, atFirstPlace firstPlaceHolder : Bool) {
        if self.siblingNotes.count > 0 {
            if firstPlaceHolder {
                self.siblingNotes.insert(card, at: 0)
            }else{
                self.siblingNotes.append(card)
            }
        }else{
            self.siblingNotes = [card]
        }
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
        self.noteCardIsTodoDone = false
        self.siblingNotes = []
        self.noteCardBody = ""
    }
}
