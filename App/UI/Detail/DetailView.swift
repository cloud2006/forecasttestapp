//
//  DetailView.swift
//  App
//
//

import SwiftUI
import GlobalUI

struct DetailView: View {

    let viewModel: DetailViewModel

    private var rainText: String {
        let percent = Int((viewModel.item.chanceRain * 100).rounded())
        return "\(percent)%"
    }

    var body: some View {
        ZStack {
            Color(GlobalColor.backgroundColor ?? .clear)
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 16) {

                VStack(alignment: .leading, spacing: 4) {
                    Text(viewModel.item.day)
                        .font(.system(size: 36, weight: .bold))
                        .foregroundStyle(.white)
                    Text(viewModel.item.description)
                        .font(.title3.weight(.medium))
                        .foregroundStyle(.white.opacity(0.9))
                }

                HStack(alignment: .firstTextBaseline, spacing: 12) {
                    Text("High")
                        .font(.caption2.weight(.bold))
                        .foregroundStyle(.white.opacity(0.8))

                    Text("\(viewModel.item.high)°")
                        .font(.system(size: 72, weight: .semibold, design: .rounded))
                        .foregroundStyle(.white)

                    Text("\(viewModel.item.low)°")
                        .font(.system(size: 34, weight: .medium, design: .rounded))
                        .foregroundStyle(.white.opacity(0.9))

                    Text("Low")
                        .font(.caption2.weight(.bold))
                        .foregroundStyle(.white.opacity(0.8))
                }

                HStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Rain")
                            .font(.caption)
                            .foregroundStyle(.white.opacity(0.7))
                        Text(rainText)
                            .font(.body.weight(.semibold))
                            .foregroundStyle(.white)
                    }

                    VStack(alignment: .leading, spacing: 2) {
                        Text("Sunrise")
                            .font(.caption)
                            .foregroundStyle(.white.opacity(0.7))
                        Text(String(viewModel.item.sunrise))
                            .font(.body.weight(.semibold))
                            .foregroundStyle(.white)
                    }

                    VStack(alignment: .leading, spacing: 2) {
                        Text("Sunset")
                            .font(.caption)
                            .foregroundStyle(.white.opacity(0.7))
                        Text(String(viewModel.item.sunset))
                            .font(.body.weight(.semibold))
                            .foregroundStyle(.white)
                    }
                }
                .padding(.top, 4)

                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 24)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(viewModel: DetailViewModel(item: ForecastItem(day: "1", description: "description", sunrise: 1, sunset: 2, chanceRain: 0.2, high: 2, low: 1, type: "preview")))
    }
}
