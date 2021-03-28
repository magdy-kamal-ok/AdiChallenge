//
//  MockedNonFatalErrorLogger.swift
//  AdiChallengeTests
//
//  Created by Magdy Kamal on 28/03/2021.
//

import Foundation

@testable import AdiChallenge

class MockedNonFatalErrorLogger: NonFatalErrorLogger {
    
    func logNonFatalError(error: Error) {
        print(error.localizedDescription)
    }
}
