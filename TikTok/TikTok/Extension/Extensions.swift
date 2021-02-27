//
//  Extensions.swift
//  TikTok
//
//  Created by Jh's Macbook Pro on 2021/02/23.
//

import Foundation
import UIKit

extension UIView {
    var width: CGFloat {
        return frame.size.width
    }
    var height: CGFloat {
        return frame.size.height
    }
    var left: CGFloat {
        return frame.origin.x
    }
    var right: CGFloat {
        return left + width
    }
    var top: CGFloat {
        return frame.origin.y
    }
    var bottom: CGFloat {
        return top + height
    }
}

extension DateFormatter {
    static let defaultDateFormat: DateFormatter = {
       let dateFormmat = DateFormatter()
        dateFormmat.timeZone = .current
        dateFormmat.locale = .current
        dateFormmat.dateStyle = .medium
        dateFormmat.timeStyle = .short
        return dateFormmat
    }()
}

extension String {
    static func date(with date: Date) -> String {
        return DateFormatter.defaultDateFormat.string(from: date)
    }
}
