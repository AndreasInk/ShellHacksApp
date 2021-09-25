//
//  Extensions.swift
//  ShellHacksApp
//
//  Created by Andreas on 9/24/21.
//

import SwiftUI

extension Color {
    static let Primary = Color("Primary")
    static let Secondary = Color("Secondary")
    static let Dark = Color("Dark")
    static let Light = Color("Light")
}
extension LinearGradient: Equatable {
    public static func == (lhs: LinearGradient, rhs: LinearGradient) -> Bool {
        return false
    }
    
    static let Primary = LinearGradient(colors: [.Secondary, .Primary], startPoint: .topLeading, endPoint: .bottom)
    static let Secondary = LinearGradient(colors: [.Primary, .Secondary], startPoint: .topLeading, endPoint: .bottom)
    static let Light = LinearGradient(colors: [.Light, .Light], startPoint: .topLeading, endPoint: .bottom)
}

extension Array where Element:Equatable {
    func removeDuplicates() -> [Element] {
        var result = [Element]()

        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }

        return result
    }
}
extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }
    
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}
