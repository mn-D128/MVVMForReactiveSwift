//
//  ViewModelType.swift
//  ReactiveSwiftSample
//
//  Created by Masanori Nakano on 2020/07/18.
//  Copyright © 2020 D128.work. All rights reserved.
//

import Foundation
import ReactiveSwift

protocol ViewModelInputs {
    var tap: Signal<(), Never>.Observer { get }
}

protocol ViewModelOutputs {
    var text: SignalProducer<String, Never> { get }
    var errorMessage: Signal<String, Never> { get }
}

protocol ViewModelType {
    var inputs: ViewModelInputs { get }
    var outputs: ViewModelOutputs { get }
}
