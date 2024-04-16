//
//  Event.swift
//  MySIG
//
//  Created by Hans Arthur Cupiterson on 03/04/24.
//

import Foundation

struct EventSIG: Hashable{
    var id: Int
    
    var name: String
    var desc: String
    var eventStatus: String
    
    var listRemindedUser: [Int]
    var location: String
    var date: Date
    var time: String
    var maxSlots: Int
    var sigId: Int
    
    var listRegisteredParticipantId: [Int]
}
