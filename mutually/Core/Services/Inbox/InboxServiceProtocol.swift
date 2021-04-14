//
//  InboxServiceProtocol.swift
//  mutually
//
//  Created by Turan Assylkhan on 14.04.2021.
//

protocol InboxServiceProtocol {
    func newInbox(summ: Double, term: Int, completion: @escaping ResponseCompletion<Void>)
}
