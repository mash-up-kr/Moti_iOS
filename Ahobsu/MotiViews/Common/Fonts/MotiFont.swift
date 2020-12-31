//
//  Fonts.swift
//  Ahobsu
//
//  Created by 김선재 on 2020/12/30.
//  Copyright © 2020 ahobsu. All rights reserved.
//

import Foundation
import SwiftUI

public enum MotiFont: String {
    case IropkeBatangOTFM
    case Baskerville
    case AppleSDGothicNeoBold = "AppleSDGothicNeo-Bold"
    case AppleSDGothicNeoRegular = "AppleSDGothicNeo-Regular"
    case AppleSDGothicNeoMedium = "AppleSDGothicNeo-Medium"
    case SFProDisplayMedium = "SFProDisplay-Medium"
    case TTNormsRegular = "TTNorms-Regular"
}

public enum MotiFontAlias {
    case systemKor
    case systemEng
    case uiKorBold
    case uiKorRegular
    case uiKorDisable
    case nicknamePlaceholder
    case nicknameText
    case answerTextPlaceholder
    case answerText
    case navTitleEng
    case navTitleKor
    case uiEng
    case splashEng
    
    func of(size: CGFloat) -> Font {
        switch (self) {
        case .systemKor,
             .answerText,
             .answerTextPlaceholder,
             .navTitleEng:
            return .motiFont(.IropkeBatangOTFM, size: size)
        case .systemEng:
            return .motiFont(.Baskerville, size: size)
        case .uiKorBold:
            return .motiFont(.AppleSDGothicNeoBold, size: size)
        case .uiKorRegular,
             .uiKorDisable,
             .nicknamePlaceholder,
             .navTitleKor:
            return .motiFont(.AppleSDGothicNeoRegular, size: size)
        case .nicknameText:
            return .motiFont(.AppleSDGothicNeoMedium, size: size)
        case .uiEng:
            return .motiFont(.SFProDisplayMedium, size: size)
        case .splashEng:
            return .motiFont(.TTNormsRegular, size: size)
        }
    }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Font {
    public static func motiFont(_ motiFontAlias: MotiFontAlias, size: CGFloat) -> Font {
        return motiFontAlias.of(size: size)
    }
    
    public static func motiFont(_ motiFont: MotiFont, size: CGFloat) -> Font {
        return .custom(motiFont.rawValue, size: size)
    }
}
