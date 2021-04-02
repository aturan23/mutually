//
//  TextFieldViewFactory.swift
//  mutually
//
//  Created by Turan Assylkhan on 02.04.2021.
//

import UIKit

class TextFieldViewFactory {
    func makeForPhone(title: String) -> TextFieldView {
        let view = TextFieldView(title: title,
                                 prefix: "+7 (",
                                 formatPattern: "###) ### ## ##",
                                 placeholderChar: " ",
                                 editingActions: [.paste])
            .withClearButton()
        view.keyboardType = .phonePad
        return view
    }
}
