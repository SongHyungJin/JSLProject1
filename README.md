# JSLProject1
JSL에서 진행하는 1번째 프로젝트
## JSP에서 사용 가능한 Attribute 정리

각 `Service` 및 `Controller`에서 `request.setAttribute()` / `session.setAttribute()`로 전달하는 속성을 정리했습니다.

### 1. 회원가입 — `SignupService`

| Scope   | 속성명             | 타입        | 설명                   | JSP 표현식            |
| ------- | --------------- | --------- | -------------------- | ------------------ |
| Request | `message`       | `String`  | 입력값 검증 및 회원가입 결과 메시지 | `${message}`       |
| Request | `signupSuccess` | `Boolean` | 회원가입 성공 여부           | `${signupSuccess}` |

> 회원가입 성공 시 세션의 `emailVerified` 속성을 제거합니다.

---

### 2. 이메일 인증 — `EmailSendService`

| Scope   | 속성명         | 타입       | 설명              | JSP 표현식                     |
| ------- | ----------- | -------- | --------------- | --------------------------- |
| Session | `emailCode` | `String` | 랜덤 생성된 6자리 인증번호 | `${sessionScope.emailCode}` |

---

### 3. 이메일 인증 확인 — `EmailVerifyService`

| Scope   | 속성명             | 타입        | 설명             | JSP 표현식                         |
| ------- | --------------- | --------- | -------------- | ------------------------------- |
| Session | `emailVerified` | `Boolean` | 이메일 인증 성공 여부   | `${sessionScope.emailVerified}` |
| Request | `message`       | `String`  | 인증 실패 시 안내 메시지 | `${message}`                    |

> 인증 성공 시 세션의 `emailCode`를 제거합니다.

---

### 4. 로그인 — `LoginService`

| Scope   | 속성명      | 타입    | 설명                           | JSP 표현식              |
| ------- | -------- | ----- | ---------------------------- | -------------------- |
| Session | `id`     | `int` | 로그인한 회원의 PK                  | `${sessionScope.id}` |
| Request | `result` | `int` | 로그인 성공 여부 (`1`: 성공, `0`: 실패) | `${result}`          |

---

### 5. 로그아웃 — `LogoutService`

별도의 Attribute를 저장하지 않습니다.

로그아웃 시:

```java
session.invalidate();
```

세션을 전체 삭제한 후 `main.do`로 리다이렉트합니다.

---

### 6. 회원정보 조회 — `ProfileViewService`

| Scope   | 속성명       | 타입         | 설명             | JSP 표현식          |
| ------- | --------- | ---------- | -------------- | ---------------- |
| Request | `message` | `String`   | 비로그인 상태 안내 메시지 | `${message}`     |
| Request | `profile` | `UsersDTO` | 로그인한 회원의 정보    | `${profile.xxx}` |

#### `profile` 객체의 주요 속성

| JSP 표현식                 | Getter            | 설명       |
| ----------------------- | ----------------- | -------- |
| `${profile.id}`         | `getId()`         | 회원 고유 PK |
| `${profile.email}`      | `getEmail()`      | 이메일      |
| `${profile.nickname}`   | `getNickname()`   | 닉네임      |
| `${profile.role}`       | `getRole()`       | 회원 권한    |
| `${profile.language}`   | `getLanguage()`   | 사용 언어    |
| `${profile.created_at}` | `getCreated_at()` | 가입일시     |
| `${profile.update_at}`  | `getUpdate_at()`  | 수정일시     |

> `password`는 비밀번호 해시값이므로 화면에 노출하지 않습니다.

---

### 7. 닉네임 수정 — `ProfileUpdateService`

| Scope   | 속성명       | 타입       | 설명                     | JSP 표현식      |
| ------- | --------- | -------- | ---------------------- | ------------ |
| Request | `message` | `String` | 닉네임 수정 결과 및 유효성 검사 메시지 | `${message}` |

---

### 8. 비밀번호 수정 — `PasswordUpdateService`

| Scope   | 속성명       | 타입       | 설명                      | JSP 표현식      |
| ------- | --------- | -------- | ----------------------- | ------------ |
| Request | `message` | `String` | 비밀번호 수정 결과 및 유효성 검사 메시지 | `${message}` |

---

## Session Attribute

현재 프로젝트에서 사용하는 세션 속성은 다음과 같습니다.

| 속성명             | 저장 위치                | 제거 위치                | 용도           |
| --------------- | -------------------- | -------------------- | ------------ |
| `emailCode`     | `EmailSendService`   | `EmailVerifyService` | 이메일 인증번호     |
| `emailVerified` | `EmailVerifyService` | `SignupService`      | 이메일 인증 완료 여부 |
| `id`            | `LoginService`       | `LogoutService`      | 로그인 회원의 PK   |

---

## Request Attribute

| 속성명             | 사용 Service           | 타입         | 용도         |
| --------------- | -------------------- | ---------- | ---------- |
| `message`       | 여러 Service           | `String`   | 사용자 안내 메시지 |
| `signupSuccess` | `SignupService`      | `Boolean`  | 회원가입 성공 여부 |
| `result`        | `LoginService`       | `int`      | 로그인 성공 여부  |
| `profile`       | `ProfileViewService` | `UsersDTO` | 회원정보 전달    |

---

## Controller에서 사용하는 Attribute

`UsersController`에서는 Service 실행 후 Request Attribute를 다시 꺼내 페이지 이동 여부를 판단합니다.

### 회원가입

```java
Boolean signupSuccess =
    (Boolean) request.getAttribute("signupSuccess");
```

### 로그인

```java
int result =
    (int) request.getAttribute("result");
```

이를 통해 Service의 처리 결과에 따라 JSP 페이지를 분기합니다.
