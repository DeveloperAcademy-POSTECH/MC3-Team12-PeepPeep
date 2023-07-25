//
//  ChickNamingView.swift
//  PeepPeep
//
//  Created by Ha Jong Myeong on 2023/07/24.
//

import SwiftUI
import PeepPeepCommons

struct ChickNamingView: View {
    @ObservedObject var viewModel = ChickNamingViewModel()
    @State private var name = ""

    var body: some View {
        NavigationView {
            VStack {
                ProgressBar(currentStep: 1)
                CustomSpacer(height: 80)
                Text("병아리의 이름을 지어주세요")
                    .font(.dosSsaemmul(size: 20))
                CustomSpacer(height: 70)
                ChickNameTextField(name: $name)
                // 스크롤을 비활성화한 스크롤 뷰 추가, 키보드 영역으로 인한 UI 요소가 변화하지 않도록 합니다.
                ScrollView {
                    CustomSpacer(height: 20)
                    ChickImageView()
                    CustomSpacer(height: 150)
                    DecisionButton(viewModel: viewModel, name: name)
                    CustomSpacer(height: 30)
                }.scrollDisabled(true)
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(trailing: SkipButton(viewModel: viewModel, name: name))
            .font(.dosSsaemmul(size: 20))
            .foregroundColor(Color.black)
        }
    }
}

// 병아리 이름 입력 텍스트 필드
struct ChickNameTextField: View {
    @Binding var name: String

    var body: some View {
        TextField("병아리", text: $name)
            .textFieldStyle(UnderlinedTextFieldStyle())
            .multilineTextAlignment(.center)
            .font(.dosSsaemmul(size: 20))
    }
}

// 병아리 이미지 뷰
struct ChickImageView: View {
    var body: some View {
        Image("chick")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 200, height: 200)
    }
}

// 결정 버튼
struct DecisionButton: View {
    let viewModel: ChickNamingViewModel
    let name: String

    var body: some View {
        Button(action: {
            viewModel.updateChickName(name: name)
        }) {
            NavigationLink(destination: ScreenTimeRequestView()) {
                Text("결정")
            }
        }
        .buttonStyle(CommonButtonStyle(paddingSize: 30))
    }
}

// 스킵 버튼
struct SkipButton: View {
    let viewModel: ChickNamingViewModel
    let name: String

    var body: some View {
        Button(action: {
            viewModel.updateChickName(name: name)
        }) {
            NavigationLink(destination: ScreenTimeRequestView()) {
                Text("Skip")
            }
        }
    }
}
