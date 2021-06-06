//
//  DateFormat.swift
//  DInDinnTest
//
//  Created by Teerapat on 6/5/21.
//

import Foundation

extension Date {
    func toString(format: String = "dd-MM-yyyy hh:mm") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

extension String {
    func toDate(format: String = "dd-MM-yyyy hh:mm") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self) ?? Date()
    }
}
