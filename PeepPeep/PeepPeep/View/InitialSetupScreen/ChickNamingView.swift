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
    @FocusState private var focusedField: Field?

    enum Field: Hashable {
        case chickName
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                CustomSpacer(height: 10)
                ProgressBar(currentStep: 1)
                CustomSpacer(height: 80)
                Text("병아리의 이름을 지어주세요")
                    .font(.dosSsaemmul(size: 20))
                CustomSpacer(height: 70)
                ChickNameTextField(name: $name, focusedField: _focusedField)
                // 스크롤을 비활성화한 스크롤 뷰 추가, 키보드 영역으로 인한 UI 요소가 변화하지 않도록 합니다.
                ScrollView {
                    CustomSpacer(height: 10)
                    ChickImageView()
                    CustomSpacer(height: 190)
                    DecisionButton(viewModel: viewModel, name: name)
                    CustomSpacer(height: 30)
                }
            }.scrollDisabled(true)
            .onTapGesture {
                focusedField = nil
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
    @FocusState var focusedField: ChickNamingView.Field?

    var body: some View {
        TextField("병아리", text: $name)
            .textFieldStyle(UnderlinedTextFieldStyle())
            .multilineTextAlignment(.center)
            .font(.dosSsaemmul(size: 20))
            .focused($focusedField, equals: .chickName)
    }
}

// 병아리 이미지 뷰
struct ChickImageView: View {
    @StateObject private var keyboardResponder = KeyboardResponder()

    var body: some View {
        Image("Chick")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 200, height: 200)
            .offset(y: keyboardResponder.isKeyboardVisible ? 0 : 30)
            .animation(.easeInOut(duration: 0.2), value: keyboardResponder.isKeyboardVisible)
    }
}

// 결정 버튼
struct DecisionButton: View {
    let viewModel: ChickNamingViewModel
    let name: String

    var body: some View {
        NavigationLink {
            ScreenTimeRequestView()
        } label: {
            Text("결정")
        }
        .buttonStyle(CommonButtonStyle(paddingSize: 30))
        .simultaneousGesture(TapGesture().onEnded({ _ in
            // 아무것도 입력하지 않고 결정을 누르면 기본값 "병아리"로 이름이 지어짐
            if name == "" {
                viewModel.updateChickName(name: "병아리")
            }
            else {
                viewModel.updateChickName(name: name)
            }
        }))
    }
}

// 스킵 버튼
struct SkipButton: View {
    let viewModel: ChickNamingViewModel
    let name: String

    var body: some View {
        NavigationLink {
            ScreenTimeRequestView()
        } label: {
            Text("Skip")
                .font(.dosSsaemmul(size: 20))
        }
        .simultaneousGesture(TapGesture().onEnded({ _ in
            // 스키밯면 기본값 "병아리"로 이름이 지어짐
            viewModel.updateChickName(name: "병아리")
        }))
    }
}
