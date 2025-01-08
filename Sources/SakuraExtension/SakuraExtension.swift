// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI
import UIKit

public struct ImagePicker: View {
    var isLightColor: Bool = false
    @Binding var selectedColor: Color
    @State var location: CGSize = .zero
    @State var offset: CGSize = .zero
    var body: some View {
        GeometryReader { proxy in
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(hue: 1.0, saturation: 1, brightness: 1),
                    Color(hue: 0.9, saturation: 1, brightness: 1),
                    Color(hue: 0.8, saturation: 1, brightness: 1),
                    Color(hue: 0.7, saturation: 1, brightness: 1),
                    Color(hue: 0.6, saturation: 1, brightness: 1),
                    Color(hue: 0.5, saturation: 1, brightness: 1),
                    Color(hue: 0.4, saturation: 1, brightness: 1),
                    Color(hue: 0.3, saturation: 1, brightness: 1),
                    Color(hue: 0.2, saturation: 1, brightness: 1),
                    Color(hue: 0.1, saturation: 1, brightness: 1),
                    Color(hue: 0.0, saturation: 1, brightness: 1)
                ]),
                startPoint: .trailing,  // Màu sắc thay đổi từ trái
                endPoint: .leading    // Màu sắc thay đổi đến phải
            )
            .mask(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.black,
                        Color.clear
                    ]),
                    startPoint: .top,  // Màu sắc thay đổi từ trái
                    endPoint: .bottom    // Màu sắc thay đổi đến phải
                )
            )
            .background(isLightColor ? .white : Color.black)
            .onClickGesture(perform: { location in
                let viewWidth = proxy.size.width
                let viewHeight = proxy.size.height
                
                offset = .init(width: location.x - viewWidth / 2, height: location.y - viewHeight / 2)
                self.location = offset
                self.getSelectedColor(proxy: proxy)
                
                print(location)
            })
            .overlay(
                Circle()
                    .fill(selectedColor)
                    .overlay(Circle().stroke(isLightColor ? .black : .white, lineWidth: 2))
                    .frame(width: 20)
                    .offset(offset)
                    .gesture(
                        DragGesture()
                            .onChanged({ value in
                                if offset == .zero {
                                    location = offset
                                }
                                
                                let newOffset: CGSize = .init(width: value.translation.width + location.width, height: value.translation.height + location.height)
                                
                                if abs(newOffset.width) <= proxy.size.width / 2 && abs(newOffset.height) <= proxy.size.height / 2 {
                                    offset = newOffset
                                }
                                
                                self.getSelectedColor(proxy: proxy)
                            })
                            .onEnded({ value in
                                let newOffset: CGSize = .init(width: value.translation.width + location.width, height: value.translation.height + location.height)
                                
                                if abs(newOffset.width) <= proxy.size.width / 2 && abs(newOffset.height) <= proxy.size.height / 2 {
                                    offset = newOffset
                                }
                                
                                location = offset
                                self.getSelectedColor(proxy: proxy)
                            })
                    )
                    .onAppear(perform: {
                        self.getSelectedColor(proxy: proxy)
                    })
            ).cornerRadius(20, corners: .allCorners)
        }
    }
    
    private func getSelectedColor(proxy: GeometryProxy) {
        let viewWidth = proxy.size.width
        let viewHeight = proxy.size.height
        let hue = (offset.width + viewWidth / 2) / viewWidth
        let value = 1 - (offset.height + viewHeight / 2) / viewHeight
        self.selectedColor = Color(hue: hue,
                                   saturation: isLightColor ? value : 1,
                                   brightness: isLightColor ? 1 : value)
    }
}
