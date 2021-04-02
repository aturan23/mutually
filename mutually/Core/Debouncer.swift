//
//  Debouncer.swift
//  mutually
//
//  Created by Turan Assylkhan on 02.04.2021.
//

import Foundation

final class Debouncer {
    private let callback: (() -> ())
    private let delay: Double
    private weak var timer: Timer?
    
    init(delay: Double, callback: @escaping (() -> ())) {
        self.delay = delay
        self.callback = callback
    }
    
    func call() {
        timer?.invalidate()
        let nextTimer = Timer.scheduledTimer(timeInterval: delay,
                                             target: self,
                                             selector: #selector(fire),
                                             userInfo: nil,
                                             repeats: false)
        timer = nextTimer
    }
    
    @objc func fire() {
        callback()
    }
}
