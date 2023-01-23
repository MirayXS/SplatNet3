//
//  Array.swift
//  
//
//  Created by devonly on 2022/12/31.
//

import Foundation

extension Array {
    public func chunked(by chunkSize: Int) -> [[Element]] {
        return stride(from: 0, to: self.count, by: chunkSize).map {
            Array(self[$0..<Swift.min($0 + chunkSize, self.count)])
        }
    }

    public func add<T: Numeric>(_ input: Array<T>) -> Array<T> {
        return zip(self as! [T], input).map({ $0.0 + $0.1 })
    }
}

extension Array where Element: Numeric {
    public mutating func add(_ input: Array<Element>) {
        self = Array(zip(self, input).map({ $0.0 + $0.1 }))
    }
}

extension Array where Element == [Int] {
    public func sum() -> [Int] {
        if let first = self.first {
            var sum: [Int] = Element(repeating: 0, count: first.count)
            let _ = self.map({ sum = sum.add($0) })
            return sum
        }
        return []
    }
}
