//
//  ViewModel.swift
//  ReactiveSwiftSample
//
//  Created by Masanori Nakano on 2020/07/18.
//  Copyright © 2020 D128.work. All rights reserved.
//

import Foundation
import ReactiveSwift
import ReactiveCocoa

class ViewModel {
    private let inputsConnector = InputsConnector()
    private let outputsConnector = OutputsConnector()
    
    private let model = Model()
    
    init() {
        // inputs
        self.model.increment <~ self.inputsConnector.tapSignal
        // outputs
        self.model.increment.errors.map { $0.localizedDescription }.observe(self.outputsConnector.errorMessageObserver)
        self.outputsConnector.textObserver <~ self.model.count.map { String($0) }
    }
}

extension ViewModel: ViewModelType {
    var inputs: ViewModelInputs { self.inputsConnector }
    var outputs: ViewModelOutputs { self.outputsConnector }
}

private extension ViewModel {
    class InputsConnector {
        let (tapSignal, tap) = Signal<(), Never>.pipe()
    }

    class OutputsConnector {
        let textObserver = MutableProperty<String>("")
        let text: SignalProducer<String, Never>
        
        let (errorMessage, errorMessageObserver) = Signal<String, Never>.pipe()
        
        init() {
            self.text = self.textObserver.producer
        }
    }
}

extension ViewModel.InputsConnector: ViewModelInputs {
}

extension ViewModel.OutputsConnector: ViewModelOutputs {
}
