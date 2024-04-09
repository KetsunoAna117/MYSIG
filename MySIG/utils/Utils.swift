//
//  Utils.swift
//  MySIG
//
//  Created by Hans Arthur Cupiterson on 03/04/24.
//

import Foundation
import SwiftUI

struct Utils {
    // USER
    func validateUser(email: String, password: String, appStoreData: AppDataStore) -> User?{
        return appStoreData.users.first(where: { $0.email.lowercased() == email.lowercased() && $0.password == password })
    }
    
    func getUserFromId(id: Int, appStoreData: AppDataStore) -> User? {
        return appStoreData.users.first(where: { $0.id == id })
    }
    
    func getUserFromSIG(sigData: SIG, appStoreData: AppDataStore) -> User? {
        return appStoreData.users.first(where: { $0.id == sigData.picId })
    }
    
    func getUsersRegisteredForEvent(eventData: EventSIG, appStoreData: AppDataStore) -> [User] {
        var registeredUsers: [User] = []
        
        for userId in eventData.listRegisteredParticipantId {
            if let user = appStoreData.users.first(where: { $0.id == userId }) {
                registeredUsers.append(user)
            }
        }
        
        return registeredUsers
    }
    
    func validateIfUserIsSIGPIC(userId: Int, sigId: Int, appStoreData: AppDataStore) -> Bool {
        let sig = getSigById(sigId: sigId, appStoreData: appStoreData)
        if(sig?.picId == userId){
            return true
        }
        return false
    }
    
    func addEventToUser(userId: Int, eventId: Int, appStoreData: AppDataStore) {
            
            if var user = appStoreData.users.first(where: { $0.id == userId }) {
                var updatedBookedEventId = user.bookedEventId
                updatedBookedEventId.append(eventId)
                user.bookedEventId = updatedBookedEventId
                appStoreData.currentActiveUser = user
                
                if var event = appStoreData.events.first(where: { $0.id == eventId }){
                    var updatedListRegisteredParticipantId = event.listRegisteredParticipantId
                    updatedListRegisteredParticipantId.append(userId)
                    event.listRegisteredParticipantId = updatedListRegisteredParticipantId
                }
                
            }
            
        }
        
        func removeEventFromUser(userId: Int, eventId: Int, appStoreData: AppDataStore) {
            if var user = appStoreData.users.first(where: { $0.id == userId }) {
                var updatedBookedEventId = user.bookedEventId
                updatedBookedEventId.removeAll(where: { $0 == eventId })
                user.bookedEventId = updatedBookedEventId
                appStoreData.currentActiveUser = user
                
                if var event = appStoreData.events.first(where: { $0.id == eventId }) {
                    var updatedListRegisteredParticipantId = event.listRegisteredParticipantId
                    updatedListRegisteredParticipantId.removeAll(where: { $0 == userId })
                    event.listRegisteredParticipantId = updatedListRegisteredParticipantId
                }
            }
        }
    
//    func addEventToUser(userId: Int, eventId: Int, appStoreData: AppDataStore) {
//        
//        if var user = appStoreData.users.first(where: { $0.id == userId }) {
//            user.bookedEventId.append(eventId)
//            appStoreData.currentActiveUser = user
//            
//            if var event = appStoreData.events.first(where: { $0.id == eventId }){
//                event.listRegisteredParticipantId.append(userId)
//            }
//            
//        }
//        
//    }
//    
//    func removeEventFromUser(userId: Int, eventId: Int, appStoreData: AppDataStore) {
//        if var user = appStoreData.users.first(where: { $0.id == userId }) {
//            user.bookedEventId.removeAll(where: { $0 == eventId })
//            appStoreData.currentActiveUser = user
//            
//            if var event = appStoreData.events.first(where: { $0.id == eventId }) {
//                event.listRegisteredParticipantId.removeAll(where: { $0 == userId })
//            }
//        }
//    }
    
    
    // DATE
    func formatDate(from date: String) -> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.date(from: date)
    }
    
    func getDayName(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
    }
    
    func getDay(from date: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: date)
        return components.day ?? 0
    }
    
    func getMonth(from date: Date) -> String {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month], from: date)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        dateFormatter.calendar = calendar
        
        if let monthDate = calendar.date(from: components) {
            return dateFormatter.string(from: monthDate)
        } else {
            return ""
        }
    }
    
    func getYear(from date: Date) -> String {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: date)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        dateFormatter.calendar = calendar
        
        if let yearDate = calendar.date(from: components) {
            return dateFormatter.string(from: yearDate)
        } else {
            return ""
        }
    }
    
    // SIG
    func getSigById(sigId: Int, appStoreData: AppDataStore) -> SIG?{
        return appStoreData.sigs.first(where: {$0.id == sigId})
    }
    
    func getAllSIG(appStoreData: AppDataStore) -> [SIG]{
        return appStoreData.sigs
    }
    
    func getAllSIGByUserId(userId: Int, appStoreData: AppDataStore) -> [SIG] {
        if let user = appStoreData.currentActiveUser {
            return user.joinedSigId.compactMap { sigId in
                getSigById(sigId: sigId, appStoreData: appStoreData)
            }
        }
        return []
    }
    
    func calculateOnGoingSigEvent(sig: SIG) -> Int {
        return sig.listEventId.count
    }
    
    // EVENT
    func checkIfUserBookEvent(event: EventSIG, user: User) -> Bool{
        for registeredMember in event.listRegisteredParticipantId {
            if(registeredMember == user.id){
                return true
            }
        }
        return false
    }
    
    func getAllEventFromListId(eventIdList: [Int], appStoreData: AppDataStore) -> [EventSIG] {
        return eventIdList.compactMap { eventId in
            getEventById(eventId: eventId, appStoreData: appStoreData)
        }
    }
    
    func getEventListFromSIG(sigId: Int, appStoreData: AppDataStore) -> [EventSIG] {
        return appStoreData.events.filter { event in
            event.sigId == sigId
        }
    }
    
    func getEventById(eventId: Int, appStoreData: AppDataStore) -> EventSIG?{
        return appStoreData.events.first(where: { $0.id == eventId })
    }
    
    func getEventListWithoutTheUser(user: User, appStoreData: AppDataStore) -> [EventSIG]{
        return appStoreData.events.filter { event in
            checkIfUserBookEvent(event: event, user: user) == false
        }
    }
    
    func calculateRemainingSlot(event: EventSIG) -> Int{
        let maxSlots = event.maxSlots
        
        return maxSlots - event.listRegisteredParticipantId.count
    }
    
    // NOTIFICATION
    func getNotificationByID(notificationID: Int, appStoreData: AppDataStore) -> SIGNotification? {
        return appStoreData.notifications.first(where: { $0.id == notificationID })
    }
    
    func getNotificationFromListID(notificationIdList: [Int], appStoreData: AppDataStore) -> [SIGNotification] {
        return notificationIdList.compactMap{ notificationID in
            getNotificationByID(notificationID: notificationID, appStoreData: appStoreData)
        }
    }
    
    func deleteNotificationByID(notificationID: Int, userId: Int, appStoreData: AppDataStore) {
        if var user = appStoreData.users.first(where: { $0.id == userId }) {
            user.notificationId.removeAll(where: { $0 == notificationID})
            appStoreData.currentActiveUser = user
        }
    }
}
