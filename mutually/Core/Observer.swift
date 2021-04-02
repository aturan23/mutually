//
//  Observer.swift
//  mutually
//
//  Created by Turan Assylkhan on 02.04.2021.
//

class Observer<T> {
    let onValueChanged: (T) -> Void
    
    init(onValueChanged: @escaping (T) -> Void) {
        self.onValueChanged = onValueChanged
    }
}
