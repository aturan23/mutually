//
//  FullRequestViewAdapter.swift
//  mutually
//
//  Created by Turan Assylkhan on 08/04/2021.
//  Copyright © 2021 mutually. All rights reserved.
//

import UIKit

/// Default ViewModel passed to View layer for displaying
struct FullRequestViewAdapter {
    let sections: [FullRequestCollectionAdapter]
}

struct FullRequestCollectionAdapter {
    let title: String
    let items: [Photo]
    let onSelection: ((IndexPath) -> Void)?
}
