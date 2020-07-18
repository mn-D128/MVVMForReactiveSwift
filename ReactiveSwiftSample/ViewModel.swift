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
    private let inputsConnecter = InputsConnecter()
    private let outputsConnecter = OutputsConnecter()
    
    private let model = Model()
    
    init() {
        // inputs
        self.model.increment <~ self.inputsConnecter.tapSignal
        // outputs
        self.model.increment.errors.map { $0.localizedDescription }.observe(self.outputsConnecter.errorMessageObserver)
        self.outputsConnecter.textObserver <~ self.model.count.map { String($0) }
    }
}

extension ViewModel: ViewModelType {
    var inputs: ViewModelInputs { self.inputsConnecter }
    var outputs: ViewModelOutputs { self.outputsConnecter }
}

private extension ViewModel {
    class InputsConnecter {
        let (tapSignal, tap) = Signal<(), Never>.pipe()
    }

    class OutputsConnecter {
        let textObserver = MutableProperty<String>("")
        let text: SignalProducer<String, Never>
        
        let (errorMessage, errorMessageObserver) = Signal<String, Never>.pipe()
        
        init() {
            self.text = self.textObserver.producer
        }
    }
}

extension ViewModel.InputsConnecter: ViewModelInputs {
}

extension ViewModel.OutputsConnecter: ViewModelOutputs {
}
