//
//  Home.swift
//  CustomTabbar
//
//  Created by shashank on 05/03/21.
//

import SwiftUI

struct Home: View {
    @State var selected = "house"
    var body: some View {
        ZStack {
            Color("bg").ignoresSafeArea()
        }
        .overlay(Tabbar(selected: $selected), alignment: .bottom)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
