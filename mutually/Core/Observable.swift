//
//  Observable.swift
//  mutually
//
//  Created by Turan Assylkhan on 02.04.2021.
//

public class Observable<T> {
    private var observers = WeakCollection<Observer<T>>()
    
    public var value: T {
        didSet {
            for observer in observers {
                observer?.onValueChanged(value)
            }
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func addObserver(_ observer: Observer<T>) {
        observers.append(observer)
    }
    
    func addAndFireObserver(_ observer: Observer<T>) {
        observers.append(observer)
        observer.onValueChanged(value)
    }
    
    func removeObserver(_ observer: Observer<T>) {
        observers.remove(observer)
    }
}
