//
//  json_templates.swift
//  du-rush-app
//
//  Created by Dane Koval on 1/9/22.
//

import Foundation

struct APITest: Codable {
    let message: String
}

struct UserCreds: Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let username: String
    let passwordHash: String
}

struct BrotherInfo: Codable {
    let brotherId: Int
    let firstName: String
    let lastName: String
    let location: String
}

struct RusheeInfo: Codable {
    let rusheeId: Int
    let firstName: String
    let lastName: String
    let gtid: String
    let location: String
}

struct CycleInfo: Codable {
    let cycleId: Int
    let brotherId: Int
    let rusheeId: Int
    let brotherName: String
    let location: String
    let startTime: Date
}
