//
//  Event.swift
//  Pills
//
//  Created by NIKOLAI BORISOV on 18.09.2021.
//

import UIKit

final class Event {
    let time: Date
    let pill: RealmMedKitEntry
    
    init(time: Date, pill: RealmMedKitEntry) {
        self.time = time
        self.pill = pill
    }
}
