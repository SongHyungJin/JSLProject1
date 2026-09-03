# JSLProject1
JSL에서 진행하는 1번째 프로젝트
JSP에서 사용 가능한 속성(Attribute) 정리

controller, service, model 코드에서 request.setAttribute(...) / session.setAttribute(...) 로 지정된 속성명을 그대로 추출한 문서입니다. 코드는 수정하지 않았습니다.

1. SignupService (회원가입)
속성명	scope	타입	값 / 조건	JSP 표현식
message	request	String	각 유효성 검사 실패 시 안내 메시지 (이메일 미입력, 이메일 중복, 이메일 미인증, 닉네임 미입력/형식오류/중복, 비밀번호 형식오류/불일치, 가입 실패, 가입 성공 등)	${message}
signupSuccess	request	Boolean	회원가입 성공 시 true	${signupSuccess}

※ 세션의 emailVerified 를 성공 후 removeAttribute 로 제거함 (아래 EmailVerifyService 참고).

2. EmailSendService (이메일 인증번호 발송)
속성명	scope	타입	값 / 조건	JSP 표현식
emailCode	session	String	랜덤 생성된 6자리 인증번호	${sessionScope.emailCode}
3. EmailVerifyService (이메일 인증 확인)
속성명	scope	타입	값 / 조건	JSP 표현식
emailVerified	session	Boolean	인증번호 일치 시 true, 불일치 시 false	${sessionScope.emailVerified}
message	request	String	인증번호 불일치 시 "인증코드가 다릅니다."	${message}

※ 인증 성공 시 session의 emailCode 는 removeAttribute 로 제거됨.

4. LoginService (로그인)
속성명	scope	타입	값 / 조건	JSP 표현식
id	session	int	로그인 성공 시 UsersDTO.getId() 값 저장	${sessionScope.id}
result	request	int	로그인 성공 1, 실패 0	${result}
5. LogoutService (로그아웃)
별도 속성 저장 없음. 세션(session.invalidate()) 삭제 후 main.do 로 리다이렉트.
6. ProfileViewService (회원정보 조회)
속성명	scope	타입	값 / 조건	JSP 표현식
message	request	String	비로그인 상태일 때 "로그인이 필요합니다."	${message}
profile	request	UsersDTO 객체	로그인 상태일 때 조회된 회원 정보	${profile.xxx} (아래 표 참고)
profile 객체(UsersDTO)의 하위 속성 (getter 기준)
JSP 표현식	대응 getter	설명
${profile.id}	getId()	회원 고유 PK
${profile.email}	getEmail()	이메일(아이디)
${profile.password}	getPassword()	비밀번호(해시값, 화면 노출 비권장)
${profile.nickname}	getNickname()	닉네임
${profile.role}	getRole()	권한 (default: user)
${profile.language}	getLanguage()	언어 (default: ko)
${profile.created_at}	getCreated_at()	가입일시
${profile.update_at}	getUpdate_at()	수정일시
7. ProfileUpdateService (닉네임 수정)
속성명	scope	타입	값 / 조건	JSP 표현식
message	request	String	비로그인, 닉네임 미입력, 형식오류, 중복, 수정 실패/성공 등 각 상황별 안내 메시지	${message}
8. PasswordUpdateService (비밀번호 수정)
속성명	scope	타입	값 / 조건	JSP 표현식
message	request	String	비로그인, 현재 비밀번호 불일치, 새 비밀번호 확인 불일치, 형식오류, 변경 실패/성공 등 각 상황별 안내 메시지	${message}
9. UsersController (서블릿 – 위 서비스 결과를 다시 참조하는 부분)
속성명	scope	참조 위치	비고
signupSuccess	request	SignupService 실행 후 (Boolean) request.getAttribute("signupSuccess") 로 다시 꺼내 분기 처리	
result	request	LoginService 실행 후 (int) request.getAttribute("result") 로 다시 꺼내 분기 처리	
세션(session) 전체 속성 요약
속성명	저장 위치	제거 위치
emailCode	EmailSendService	EmailVerifyService (인증 성공 시)
emailVerified	EmailVerifyService	SignupService (가입 성공 시)
id	LoginService	LogoutService (session.invalidate())
request 전체 속성명 요약 (한 줄 정리)
message (여러 서비스 공통, 안내 메시지)
signupSuccess (SignupService)
result (LoginService)
profile (ProfileViewService, UsersDTO 객체)

참고: model 패키지에는 BookmarksDTO/DAO, PlacesDTO/DAO, ReservationsDTO/DAO, ReviewsDTO/DAO, UsersDTO/DAO 가 있지만, 현재 service/controller 코드에서 실제로 request/session에 값을 담아 사용하는 것은 UsersDTO(=profile 속성) 뿐입니다. 나머지 DTO들은 아직 컨트롤러/서비스에서 속성으로 전달되고 있지 않아 이 문서에는 포함하지 않았습니다.
