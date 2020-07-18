//
//  ViewController.swift
//  ReactiveSwiftSample
//
//  Created by Masanori Nakano on 2020/07/18.
//  Copyright © 2020 D128.work. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa
import Toast_Swift

class ViewController: UIViewController {
    
    @IBOutlet private weak var button: UIButton! {
        didSet {
            self.button.reactive.controlEvents(.touchUpInside)
                .map { _ in () }
                .observe(self.viewModel.inputs.tap)
        }
    }

    @IBOutlet private weak var label: UILabel! {
        didSet {
            self.label.reactive.text <~ self.viewModel.outputs.text
        }
    }
    
    private let viewModel: ViewModelType = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reactive.showError <~ self.viewModel.outputs.errorMessage
    }
    
}

private extension Reactive where Base: ViewController {
    var showError: BindingTarget<String> {
        makeBindingTarget { $0.view.makeToast($1) }
    }
}
