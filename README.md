
# Terraform 기반 Cloud Infrastructure 구성 (dev/shared)

## 구성 개요

Terraform을 활용하여 다음과 같은 VPC 기반 클라우드 인프라를 구성합니다:

| 구성 요소       | 설명 |
|----------------|------|
| dev VPC        | 백엔드 서비스 및 DB(RDS/EC2)용 VPC |
| shared VPC     | Jenkins, OpenVPN 등 퍼블릭 접근용 인스턴스 배치 VPC |
| NAT Gateway    | dev VPC 내 퍼블릭 서브넷에 설치되어 프라이빗 서브넷 외부 통신 지원 |
| Subnet 분리    | 퍼블릭/프라이빗 서브넷을 서비스 목적에 따라 분리 |
| SG 모듈        | 재사용 가능한 Security Group 구성 지원 |
| 모듈 구조      | vpc, shared_vpc, nat, security_group 등 기능별 모듈화 |

---

## 📁 디렉터리 구조

```bash
terraform_dev/             # 메인 환경 구성 디렉토리
│
├── main.tf                # 모듈 호출 및 리소스 연결
├── variables.tf           # 환경 변수 정의
├── terraform.tfvars       # 실제 변수 값 정의
├── provider.tf            # AWS Provider 설정
├── outputs.tf             # 출력값 정의
│
modules/                   # 모듈 디렉터리
├── vpc/                   # dev VPC (public/private subnet 포함)
├── shared_vpc/            # shared VPC (public subnet만)
├── nat/                   # NAT Gateway + Route Table 구성
└── security_group/        # 재사용 가능한 SG 모듈
```

---

## 주요 구성 리소스

### dev VPC

- CIDR: `172.16.0.0/16`
- Subnet 구성:
  - Public: `172.16.1.0/24` (NAT 용도)
  - Private Backend: `172.16.10.0/24`
  - Private MySQL: `172.16.20.0/24`

### shared VPC

- CIDR: `172.17.0.0/16`
- Public Subnet: `172.17.1.0/24` (Jenkins, OpenVPN 배치 대상)

---

## ⚙️ 사용 방법

```bash
# 초기화
terraform init

# 실행 계획 확인
terraform plan

# 인프라 생성
terraform apply
```

---

## 자격 증명 (로컬 환경)

```bash
export AWS_ACCESS_KEY_ID="AKIAxxxxxxxx"
export AWS_SECRET_ACCESS_KEY="xxxxxxxxxxx"
```

또는 `~/.aws/credentials` 사용

---

## 향후 확장 예정

- Jenkins EC2 + user_data 설치 스크립트 연동
- RDS(MySQL) 구성 모듈 추가
- GitHub Actions 기반 CI/CD 자동화 구성
