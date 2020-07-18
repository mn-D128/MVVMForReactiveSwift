//
//  Model.swift
//  ReactiveSwiftSample
//
//  Created by Masanori Nakano on 2020/07/18.
//  Copyright © 2020 D128.work. All rights reserved.
//

import Foundation
import ReactiveSwift

class Model {
    private let _count = MutableProperty<Int>(0)
    var count: SignalProducer<Int, Never> { self._count.producer }
    
    private(set) lazy var increment = Action<Void, Int, Error> { [weak self] in
        SignalProducer<Int, Error> { [weak self] (observer, _) in
            do {
                if let value = try self?.incrementCount() {
                    observer.send(value: value)
                }
                observer.sendCompleted()
            } catch {
                observer.send(error: error)
            }            
        }
    }
    
    private func incrementCount() throws -> Int {
        try self._count.modify {
            if $0 == 10 {
                throw NSError(
                    domain: "",
                    code: 0,
                    userInfo: [NSLocalizedDescriptionKey : "これ以上インクリメントできません"]
                )
            }
                
            $0 += 1
            return $0
        }
    }
}
