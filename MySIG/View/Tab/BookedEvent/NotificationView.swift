//
//  NotificationView.swift
//  MySIG
//
//  Created by Hans Arthur Cupiterson on 06/04/24.
//

import SwiftUI

struct NotificationView: View {
    @EnvironmentObject private var appStoreData: AppDataStore
    
    private var notificationList: [SIGNotification]? {
        if let user = appStoreData.currentActiveUser {
            return Utils().getNotificationFromListID(
                notificationIdList: user.notificationId,
                appStoreData: appStoreData)
        }
        return nil
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if let notifications = notificationList {
                    NotificationListView(notifications: notifications)
                        .environmentObject(appStoreData)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Notification")
            
        }
    }
}

#Preview {
    NotificationView()
        .environmentObject(AppDataStore())
}
