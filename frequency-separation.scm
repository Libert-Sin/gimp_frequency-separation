(define (script-fu-frequency-separation img drawable)
  (let* (
         (layer1 drawable) ; 레이어 1: 현재 활성화된 레이어
         (layer2 (car (gimp-layer-copy layer1 TRUE))) ; 레이어 1을 복제하여 레이어 2 생성
         (layer3 0) ; 레이어 3 선언
         )

    (gimp-image-add-layer img layer2 -1) ; 레이어 2를 이미지의 최상위에 추가

    (plug-in-gauss RUN-NONINTERACTIVE img layer2 6.18 6.18 0) ; 레이어 2에 가우시안 블러 적용

    (gimp-layer-set-mode layer2 LAYER-MODE-GRAIN-EXTRACT) ; 레이어 모드설정

    (set! layer3 (car (gimp-layer-new-from-visible img img "Visible Layer"))) ; 보이는 화면을 새 레이어 레이어 3 생성

    (gimp-image-add-layer img layer3 -1) ; 레이어 3을 이미지의 최상위에 추가

    (gimp-layer-set-mode layer3 LAYER-MODE-GRAIN-MERGE) ; 레이어 모드 설정

    (gimp-item-set-visible layer1 FALSE) ; 레이어 1을 보이지 않도록 설정

    (gimp-layer-set-mode layer2 LAYER-MODE-NORMAL) ; 레이어 모드설정

    (gimp-displays-flush) ; 이미지 갱신
  )
)

; Script-Fu 등록
(script-fu-register
  "script-fu-frequency-separation" ; script-fu 함수 이름
  "frequency separation" ; 사용자에게 표시될 스크립트 이름
  "Process frequency separation." ; 스크립트 설명
  "Libert Sin" ; 저자
  "Libert Sin" ; 저작권
  "2024.07.15" ; 생성 날짜
  "" ; 적용할 이미지 유형
  SF-IMAGE "Image" 0 ; 이미지 파라미터
  SF-DRAWABLE "Drawable" 0 ; 드로어블 파라미터
)

; 메뉴에 스크립트 등록
(script-fu-menu-register "script-fu-frequency-separation" "<Image>/Filters/Custom") ; 메뉴에 스크립트 추가
