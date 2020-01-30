//
//  MailCompose.swift
//  Ahobsu
//
//  Created by JU HO YOON on 2020/01/30.
//  Copyright © 2020 ahobsu. All rights reserved.
//

import UIKit

struct MailCompose {

    private var toEmail: String {
        return "heesoo0203@gmail.com"
    }
    private var subject: String {
        return "MOTI 문의하기"
    }
    private var body: String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "unknown"
        return "version: \(version)"
    }
    private var query: String {
        return "subject=\(subject)&body=\(body)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    }

    func open() {
        let url = URL(string: "mailto:\(toEmail)?\(query)")!
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
