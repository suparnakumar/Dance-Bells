//
//  AnalogClock.swift
//  myDanceJourney
//
//  Created by Akanksha Kumar on 8/2/23.
//

//import SwiftUI
//
//struct AnalogClock: View {
//    @State private var hourAngle: Double = 0
//    @State private var minuteAngle: Double = 0
//
//    var body: some View {
//        GeometryReader { geometry in
//            ZStack {
//                Circle()
//                    .foregroundColor(.white)
//                    .frame(width: geometry.size.width, height: geometry.size.width)
//
//                Rectangle()
//                    .foregroundColor(.black)
//                    .frame(width: 5, height: geometry.size.width * 0.4)
//                    .rotationEffect(Angle(degrees: hourAngle), anchor: .bottom)
//                    .offset(y: -geometry.size.width * 0.1)
//                    .gesture(DragGesture(minimumDistance: 0)
//                                .onChanged { value in
//                                    let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
//                                    let vector = CGVector(dx: value.location.x - center.x, dy: value.location.y - center.y)
//                                    let angle = atan2(vector.dy, vector.dx) * 180 / .pi
//                                    hourAngle = angle < 0 ? 360 + angle : angle
//                                }
//                    )
//
//                Rectangle()
//                    .foregroundColor(.black)
//                    .frame(width: 3, height: geometry.size.width * 0.45)
//                    .rotationEffect(Angle(degrees: minuteAngle), anchor: .bottom)
//                    .offset(y: -geometry.size.width * 0.15)
//                    .gesture(DragGesture(minimumDistance: 0)
//                                .onChanged { value in
//                                    let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
//                                    let vector = CGVector(dx: value.location.x - center.x, dy: value.location.y - center.y)
//                                    let angle = atan2(vector.dy, vector.dx) * 180 / .pi
//                                    minuteAngle = angle < 0 ? 360 + angle : angle
//                                }
//                    )
//            }
//        }
//        .onAppear {
//            hourAngle = 0
//            minuteAngle = 0
//        }
//    }
//}
//
//struct AnalogClock_Previews: PreviewProvider {
//    static var previews: some View {
//        AnalogClock()
//    }
//}
