//
//  Binder.swift
//  AdiChallenge
//
//  Created by Magdy Kamal on 25/03/2021.
//

import Foundation

class Binder<Input, Output> {
    init() {}

    private var block: ((Input) -> Output?)?
    func bind<T: AnyObject>(on target: T, block: ((T, Input) -> Output)?) {
        self.block = { [weak target] input in
            guard let target = target else { return nil }
            return block?(target, input)
        }
    }

    func call(_ input: Input) -> Output? {
        return block?(input)
    }

    func callAsFunction(_ input: Input) -> Output? {
        return call(input)
    }
}
