//
//  Zip3.swift
//
//
//  Created by devonly on 2022/12/31.
//

import Foundation

public func zip<A: Sequence, B: Sequence, C: Sequence>(_ a: A, _ b: B, _ c: C) -> Zip3Sequence<A, B, C> {
    Zip3Sequence(a, b, c)
}

public func zip<A: Sequence, B: Sequence, C: Sequence, D: Sequence>(_ a: A, _ b: B, _ c: C, _ d: D) -> Zip4Sequence<A, B, C, D> {
    Zip4Sequence(a, b, c, d)
}

public func zip<A: Sequence, B: Sequence, C: Sequence, D: Sequence, E: Sequence>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E) -> Zip5Sequence<A, B, C, D, E> {
    Zip5Sequence(a, b, c, d, e)
}

public struct Zip3Sequence<A: Sequence, B: Sequence, C: Sequence>: Sequence, IteratorProtocol {
    private var a: A.Iterator
    private var b: B.Iterator
    private var c: C.Iterator

    init (_ sequence1: A, _ sequence2: B, _ sequence3: C) {
        self.a = sequence1.makeIterator()
        self.b = sequence2.makeIterator()
        self.c = sequence3.makeIterator()
    }

    mutating public func next() -> (A.Element, B.Element, C.Element)? {
        guard let a = a.next(), let b = b.next(), let c = c.next() else { return nil }
        return (a, b, c)
    }
}

public struct Zip4Sequence<A: Sequence, B: Sequence, C: Sequence, D: Sequence>: Sequence, IteratorProtocol {
    private var a: A.Iterator
    private var b: B.Iterator
    private var c: C.Iterator
    private var d: D.Iterator

    init (_ sequence1: A, _ sequence2: B, _ sequence3: C, _ sequence4: D) {
        self.a = sequence1.makeIterator()
        self.b = sequence2.makeIterator()
        self.c = sequence3.makeIterator()
        self.d = sequence4.makeIterator()
    }

    mutating public func next() -> (A.Element, B.Element, C.Element, D.Element)? {
        guard let a = a.next(), let b = b.next(), let c = c.next(), let d = d.next() else { return nil }
        return (a, b, c, d)
    }
}

public struct Zip5Sequence<A: Sequence, B: Sequence, C: Sequence, D: Sequence, E: Sequence>: Sequence, IteratorProtocol {
    private var a: A.Iterator
    private var b: B.Iterator
    private var c: C.Iterator
    private var d: D.Iterator
    private var e: E.Iterator

    init (_ sequence1: A, _ sequence2: B, _ sequence3: C, _ sequence4: D, _ sequence5: E) {
        self.a = sequence1.makeIterator()
        self.b = sequence2.makeIterator()
        self.c = sequence3.makeIterator()
        self.d = sequence4.makeIterator()
        self.e = sequence5.makeIterator()
    }

    mutating public func next() -> (A.Element, B.Element, C.Element, D.Element, E.Element)? {
        guard let a = a.next(), let b = b.next(), let c = c.next(), let d = d.next(), let e = e.next() else { return nil }
        return (a, b, c, d, e)
    }
}
