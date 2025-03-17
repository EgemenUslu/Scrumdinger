//
//  ThemeCellView.swift
//  Scrumdinger
//
//  Created by egemen uslu on 3/9/25.
//

import SwiftUI

struct ThemeCellView: View {
    let theme: Theme
    
    var body: some View {
        Text(theme.name)
            .padding(4)
            .frame(maxWidth: .infinity)
            .background(theme.mainColor)
            .foregroundColor(theme.accentColor)
            .clipShape(RoundedRectangle(cornerRadius: 4))
    }
}

struct ThemeCellView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeCellView(theme: .buttercup)
    }
}
