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
    
    func getUserFromSIG(sigId: Int, appStoreData: AppDataStore) -> User? {
        if let sig = getSigById(sigId: sigId, appStoreData: appStoreData) {
            return appStoreData.users.first(where: { $0.id == sig.picId })
        }
        return nil
    }
    
    func getUsersRegisteredForEvent(eventId: Int, appStoreData: AppDataStore) -> [User] {
        if let event = getEventById(eventId: eventId, appStoreData: appStoreData){
            return event.listRegisteredParticipantId.compactMap{ userId in
                getUserFromId(id: userId, appStoreData: appStoreData)
            }
        }
        return []
    }
    
    func validateIfUserIsSIGPIC(userId: Int, sigId: Int, appStoreData: AppDataStore) -> Bool {
        let sig = getSigById(sigId: sigId, appStoreData: appStoreData)
        if(sig?.picId == userId){
            return true
        }
        return false
    }
    
    func getSubscribedUserId(sigId: Int, appStoreData: AppDataStore) -> [Int] {
        if let sig = getSigById(sigId: sigId, appStoreData: appStoreData){
            return sig.subscribedUserId
        }
        return []
    }
        
    
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
    
    func getHourAndMinutes(from time: Date) -> String {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: time)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        dateFormatter.calendar = calendar

        if let hourAndMinutes = calendar.date(from: components) {
            return dateFormatter.string(from: hourAndMinutes)
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
    
    func calculateOnGoingSigEvent(sigId: Int, appStoreData: AppDataStore) -> Int {
        if let sig = getSigById(sigId: sigId, appStoreData: appStoreData) {
            return sig.listEventId.count
        }
        return -1
    }
    
    func addParticipantToSIG(userId: Int, sigId: Int, appStoreData: AppDataStore) -> Bool{
        if let userIndex = appStoreData.users.firstIndex(where: { $0.id == userId }) {
            if let sigIndex = appStoreData.sigs.firstIndex(where: { $0.id == sigId }){
                appStoreData.sigs[sigIndex].subscribedUserId.append(userId)
                appStoreData.users[userIndex].joinedSigId.append(sigId)
                appStoreData.currentActiveUser = appStoreData.users[userIndex]
                
                return true
            }
        }
        return false
    }
    
    func removeParticipantFromSIG(userId: Int, sigId: Int, appStoreData: AppDataStore) -> Bool{
        if let userIndex = appStoreData.users.firstIndex(where: { $0.id == userId }) {
            if let eventIndex = appStoreData.sigs.firstIndex(where: { $0.id == sigId }){
                appStoreData.sigs[eventIndex].subscribedUserId.removeAll(where: {$0 == userId})
                appStoreData.users[userIndex].joinedSigId.removeAll(where: {$0 == sigId})
                appStoreData.currentActiveUser = appStoreData.users[userIndex]
                
                return true
            }
        }
        return false
    }
    
    func checkIfUserSubscribedToSIG(sigId: Int, userId: Int, appStoreData: AppDataStore) -> Bool{
        if let user = appStoreData.users.first(where: { $0.id == userId }){
            
            if user.joinedSigId.contains(where: { $0 == sigId} ){
                return true
            }
//            for everySIG in user.joinedSigId {
//                if everySIG == sigId {
//                    return true
//                }
//            }
        }
        return false
    }
    
    // EVENT
    func checkIfUserBookEvent(eventId: Int, userId: Int, appStoreData: AppDataStore) -> Bool{
        if let user = appStoreData.users.first(where: { $0.id == userId }){
            for everyEvent in user.bookedEventId {
                if everyEvent == eventId {
                    return true
                }
            }
        }
        return false
    }
    
    func getUserEventListFromSIG(userId: Int, appStoreData: AppDataStore) -> [EventSIG] {
        if let user = appStoreData.users.first(where: { $0.id == userId }){
            return user.bookedEventId.compactMap{ eventId in
                getEventById(eventId: eventId, appStoreData: appStoreData)
            }
        }
        return []
    }
    
    func getEventListFromSIG(sigId: Int, appStoreData: AppDataStore) -> [EventSIG] {
        return appStoreData.events.filter { event in
            event.sigId == sigId
        }
    }
    
    func getEventById(eventId: Int, appStoreData: AppDataStore) -> EventSIG?{
        return appStoreData.events.first(where: { $0.id == eventId })
    }
    
    func getEventListWithoutTheUser(userId: Int, appStoreData: AppDataStore) -> [EventSIG]{
        return appStoreData.events.filter { event in
            checkIfUserBookEvent(eventId: event.id, userId: userId, appStoreData: appStoreData) == false
        }
    }
    
    func calculateRemainingSlot(eventId: Int, appStoreData: AppDataStore) -> Int{
        if let event = getEventById(eventId: eventId, appStoreData: appStoreData){
            let maxSlots = event.maxSlots
            
            return maxSlots - event.listRegisteredParticipantId.count
        }
        return -1
    }
    
    func getLastInsertedEventId(appStoreData: AppDataStore) -> Int {
        return appStoreData.events.count
    }
    
    func addParticipantToEvent(userId: Int, eventId: Int, appStoreData: AppDataStore) -> Bool{
        if let userIndex = appStoreData.users.firstIndex(where: { $0.id == userId }) {
            if let eventIndex = appStoreData.events.firstIndex(where: { $0.id == eventId }){
                appStoreData.events[eventIndex].listRegisteredParticipantId.append(userId)
                appStoreData.users[userIndex].bookedEventId.append(eventId)
                appStoreData.currentActiveUser = appStoreData.users[userIndex]
                
                return true
            }
        }
        return false
    }
    
    func removeParticipantFromEvent(userId: Int, eventId: Int, appStoreData: AppDataStore) -> Bool{
        if let userIndex = appStoreData.users.firstIndex(where: { $0.id == userId }) {
            if let eventIndex = appStoreData.events.firstIndex(where: { $0.id == eventId }){
                appStoreData.events[eventIndex].listRegisteredParticipantId.removeAll(where: {$0 == userId})
                appStoreData.users[userIndex].bookedEventId.removeAll(where: {$0 == eventId})
                appStoreData.currentActiveUser = appStoreData.users[userIndex]
                
                return true
            }
        }
        return false
    }
    
    func createNewEvent(eventName: String, eventDesc: String, eventLocation: String, eventDate: Date,
                        eventStartingTime: Date, eventEndingTime: Date, maxSlot: Int, sigId: Int, listRemindedUser: [Int], appStoreData: AppDataStore) -> Bool{
        var eventId = getLastInsertedEventId(appStoreData: appStoreData) + 1
                
        let time = getHourAndMinutes(from: eventStartingTime) + "-" + getHourAndMinutes(from: eventEndingTime)
        
        let event = EventSIG(
            id: eventId,
            name: eventName,
            desc: eventDesc,
            eventStatus: "Ongoing",
            listRemindedUser: listRemindedUser,
            location: eventLocation,
            date: eventDate,
            time: time,
            maxSlots: maxSlot,
            sigId: sigId,
            listRegisteredParticipantId: []
        )
                
        appStoreData.events.append(event)
        return true
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
        if let userIndex = appStoreData.users.firstIndex(where: { $0.id == userId }){
            appStoreData.users[userIndex].notificationId.removeAll(where: { $0 == notificationID})
            appStoreData.currentActiveUser = appStoreData.users[userIndex]
        }
    }
    

}
