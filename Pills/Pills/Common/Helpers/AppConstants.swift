//
//  AppConstant.swift
//  Pills
//
//  Created by GrRoman on 30.07.2021.
//

import Foundation
// TUTORIAL:
//   add a constants.
// USAGE:
// let feedbackEmail: String = AppConstant.Emails.feedback

enum AppConstant {
    
    enum Emails {
        static let feedback = "feedback_pills@g-mail.ru"
    }
    
    enum Urls {
        static let terms = "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/"
        static let policy = "https://docs.google.com/document/d/1hW0XXUKRjhXA91bPNb8jgTxnN-L7h9-XylTeLw_nzbQ"
    }
}
