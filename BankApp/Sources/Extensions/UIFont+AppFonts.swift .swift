//
//  UIFont+AppFonts.swift .swift
//  BankApp
//
//  Created by Abrosimov Ilya on 28.02.2023.
//

import UIKit

extension UIFont {
	static let appBold = UIFont(name: "Menlo-Bold", size: 16)

	static let header1 = scaledFont(for: appBold?.withSize(32), textStyle: .title1)
	static let header2 = scaledFont(for: appBold?.withSize(24), textStyle: .title2)
	static let body = scaledFont(for: appBold?.withSize(16), textStyle: .body)
	static let footnote = scaledFont(for: appBold?.withSize(12), textStyle: .footnote)

	static func scaledFont(for font: UIFont?, textStyle: UIFont.TextStyle) -> UIFont? {
		guard let font = font else { return nil }
		return UIFontMetrics(forTextStyle: textStyle).scaledFont(for: font)
	}
}
