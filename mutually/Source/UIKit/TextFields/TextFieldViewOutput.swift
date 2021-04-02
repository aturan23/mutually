//
//  TextFieldViewOutput.swift
//  mutually
//
//  Created by Turan Assylkhan on 02.04.2021.
//

protocol TextFieldViewOutput: class {
    func didChange(text: String)
    func didCompleteMask(with value: String)
}
