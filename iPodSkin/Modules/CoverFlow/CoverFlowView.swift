//
//  CoverFlowView.swift
//  iPodSkin
//
//  Created by Максим Алексеев  on 22.01.2024.
//

import SwiftUI

struct CoverFlowItem {
    var flipped: Bool = false
    var data: Album
}

struct CoverFlowView<Content: View>: View {
    // Customizable properties
    @State var itemWidth: CGFloat
    var spacing: CGFloat = 10
    var rotation: Double
    
    @State var coverItems: [CoverFlowItem]
    var content: (CoverFlowItem) -> Content
    var body: some View {
        GeometryReader { geo in
            let size = geo.size
            
            ScrollView(.horizontal) {
                LazyHStack(spacing: 0, content: {
                    ForEach(coverItems, id: \.data.id) { coverItem in
                        VStack {
                            content(coverItem)
                                .frame(width: itemWidth, height: itemWidth)
                                .reflection(disabled: coverItem.flipped)
                                .visualEffect { content, geometryProxy in
                                    content
                                        .rotation3DEffect(coverItem.flipped ? .zero : .init(degrees: rotation(proxy: geometryProxy)), axis: (x: 0, y: 1, z: 0), anchor: .center)
                                }
                                .padding(.trailing, coverItem.data.id == coverItems.last?.data.id ? 0 : spacing)
                                .onTapGesture {
                                    if let index = coverItems.firstIndex(where:  { $0.data.id == coverItem.data.id }) {
                                        withAnimation {
                                            coverItems[index].flipped.toggle()
//                                            coverItem.flipped ? self.itemWidth += 70 : self.itemWidth += 70
//                                            itemWidth += coverItem.flipped ? -70 : +70
                                        }
                                    }
                                }
                            
                            VStack(spacing: 0) {
                                Text(coverItem.data.name)
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundStyle(.black)
                                    .multilineTextAlignment(.center)
                                    .lineLimit(1)
                                Text(coverItem.data.artists[0].name)
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundStyle(.black)
                            }
                            .frame(width: itemWidth - 20)
                            .padding(.top, 20)
                        }
                        
                    }
                })
                .padding(.horizontal, (size.width - itemWidth) / 2)
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
            .scrollIndicators(.hidden)
            .scrollClipDisabled()
        }
    }
    
    func rotation(proxy: GeometryProxy) -> Double {
        let scrollViewWidth = proxy.bounds(of: .scrollView(axis: .horizontal))?.width ?? 0
        let midX = proxy.frame(in: .scrollView(axis: .horizontal)).midX
        
        let progress = midX / scrollViewWidth
        let cappedProgress = max(min(progress,1), 0)
        
        let cappedRotation = max(min(rotation, 90), 0)
        let degree = cappedProgress * (cappedRotation * 2)
        
        return cappedRotation - degree
    }
    
}

private extension View {
    @ViewBuilder func reflection(disabled: Bool) -> some View {
        self
            .overlay {
                GeometryReader {
                    let size = $0.size
                    
                    self
                        .scaleEffect(y: -1) // flipping cover upside down
                        .mask {
                            Rectangle()
                                .fill(
                                    .linearGradient(colors: [
                                        .white,
                                        .white.opacity(0.7),
                                        .white.opacity(0.5),
                                        .white.opacity(0.3),
                                        .white.opacity(0.1),
                                    ] + Array(repeating: Color.clear, count: 3), startPoint: .top, endPoint: .bottom)
                                )
                        }
                        .offset(y: size.height + 5)
                        .opacity(disabled ? 0.0 : 0.5)
                }
            }
    }
}

//struct CoverFlowItem: Identifiable {
//    let id: UUID = UUID()
//    var color: Color
//    var name: String
//}

//#Preview {
//    CoverFlowView()
//}
