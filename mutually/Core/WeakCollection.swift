//
//  WeakCollection.swift
//  mutually
//
//  Created by Turan Assylkhan on 02.04.2021.
//

final class Weak {
    private(set) weak var value: AnyObject?
    init(value: AnyObject) {
        self.value = value
    }
}

struct WeakCollection<Element> {
    private var array: [Weak] = []
    var isEmpty: Bool {
        return array.isEmpty
    }
    mutating func append(_ object: Element) {
        array = array.filter { $0.value != nil }
        array.append(Weak(value: object as AnyObject))
    }
    mutating func remove(_ object: Element) {
        guard let objectIndex = array.firstIndex(where: { $0.value === (object as AnyObject) }) else { return }
        array.remove(at: objectIndex)
    }
    func contains(_ object: Element) -> Bool {
        return array.contains(where: { $0.value === (object as AnyObject) })
    }
}

extension WeakCollection: CustomStringConvertible {
    var description: String {
        return array.map { $0.value }.description
    }
}

extension WeakCollection: ExpressibleByArrayLiteral {
    init(arrayLiteral elements: Element...) {
        self.init(elements)
    }
}
extension WeakCollection {
    init<T: Sequence>(_ other: T) where T.Element == Element {
        array = other.map { Weak(value: $0 as AnyObject) }
    }
}

extension WeakCollection: Sequence {
    func makeIterator() -> AnyIterator<Element?> {
        let array = self.array
        var currentIndex = array.startIndex
        return AnyIterator {
            guard currentIndex < array.endIndex else { return nil }
            let currentElem = array[currentIndex]
            currentIndex = array.index(after: currentIndex)
            return currentElem.value as? Element
        }
    }
    static func +(lhs: WeakCollection<Element>,
                  rhs: WeakCollection<Element>) -> WeakCollection<Element> {
        return WeakCollection(array: lhs.array + rhs.array)
    }
    static func +=(lhs: inout WeakCollection<Element>,
                   rhs: WeakCollection<Element>) {
        lhs.array += rhs.array
    }
}
