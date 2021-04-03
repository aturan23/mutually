//
//  AuthorizationServiceProtocol.swift
//  mutually
//
//  Created by Turan Assylkhan on 02.04.2021.
//

protocol AuthorizationServiceProtocol: SmsServiceProtocol {
    var sessionTracker: SessionTrackerProtocol? { get set }
}
