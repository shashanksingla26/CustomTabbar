//
//  Tabbar.swift
//  CustomTabbar
//
//  Created by shashank on 05/03/21.
//

import SwiftUI

struct Tabbar: View {
    @Binding var selected :String
    @State var mid: CGFloat = 0
    var body: some View {
        ZStack {
            HStack(spacing: 0) {
                TabbarButton(image: "house", selected: $selected, mid: $mid)
                TabbarButton(image: "bookmark", selected: $selected, mid: $mid)
                TabbarButton(image: "message", selected: $selected, mid: $mid)
                TabbarButton(image: "person", selected: $selected, mid: $mid)
               
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color.white
                    .clipShape(Tabcureve(mid: mid - 15))
                    
            )
            .overlay(
                Circle()
                    .fill(Color.white)
                    .frame(width: 6, height: 6)
                    .offset(x: mid - 18, y: -5)
                , alignment: .bottomLeading
            )
            .cornerRadius(20)
        }
        .frame(height: 70)
        .padding()
        
    }
}

struct Tabbar_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}


struct Tabcureve: Shape {
    var mid: CGFloat
    var animatableData: CGFloat {
        get {
            return mid
        }
        set {
            self.mid = newValue
        }
    }
    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.move(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            
            //let mid = rect.width / 2
            path.move(to: CGPoint(x: mid - 40, y: rect.height))
            
            
            let to = CGPoint(x: mid, y: rect.height - 20)
            let control1 = CGPoint(x: mid - 15, y: rect.height)
            let control2 = CGPoint(x: mid - 15, y: rect.height - 20)
            
            let to1 = CGPoint(x: mid + 40, y: rect.height)
            let control3 = CGPoint(x: mid + 15, y: rect.height - 20)
            let control4 = CGPoint(x: mid + 15, y: rect.height)
            
            path.addCurve(to: to, control1: control1, control2: control2)
            path.addCurve(to: to1, control1: control3, control2: control4)
        }
    }
}



struct TabbarButton: View {
    var image: String
    @Binding var selected :String
    @Binding var mid: CGFloat
    var body: some View {
        GeometryReader { proxy -> AnyView in
            let mid = proxy.frame(in: .global).midX
            if selected == image, self.mid != mid {
                DispatchQueue.main.async {
                    withAnimation {
                        self.mid = mid
                    }
                }
            }
            return AnyView(
                ZStack {
                    Button(action: {
                        withAnimation {
                            self.selected = image
                        }
                    }, label: {
                        Image(systemName: image + "\(selected == image ? ".fill": "")")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(Color("forgroundColor"))
                            .frame(width: 25, height: 25)
                            .offset(y: selected == image ? -10: 0)
                    })
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            )
        }
    }
}

