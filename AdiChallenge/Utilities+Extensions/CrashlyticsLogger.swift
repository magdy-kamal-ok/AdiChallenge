//
//  File.swift
//  AdiChallenge
//
//  Created by Magdy Kamal on 28/03/2021.
//

import FirebaseCrashlytics

public protocol NonFatalErrorLogger {
    func logNonFatalError(error: Error)
}

class CrashlyticsLogger: NonFatalErrorLogger {
        
    private init() {}
    
    static let shared = CrashlyticsLogger()
    
    func refreshUserData() {
        // here you set related user data if needed like userId
        // Crashlytics.crashlytics().setUserID("\(userId)")
    }
    
    func logNonFatalError(error: Error) {
        // Record non-fatal exceptions and sends them to you the next time the app launches
        if Constants.isCrashlyticsLoggerEnabled {
            Crashlytics.crashlytics().record(error: error)
        }
    }
}


