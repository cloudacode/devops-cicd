# DevOps - CICD Pipeline 실습

__개발 빌드/배포 환경 자동화 실습__

CI/CD Pipeline 도구를 통해 소스 관리, 도커 빌드 자동화, 서비스 배포 까지 자동화

## 사전 준비 사항
[CI Integration](../github-aws-codebuild-dockerhub/README.md)

## 구성 하기
![Architecture](./images/system_architecutre.png)

### Setup ElasticBeanstalk

...

### Setup codepipeline

https://ap-northeast-2.console.aws.amazon.com/codesuite/codepipeline/pipelines

#### Step 1: Pipeline settings
1. Pipeline Name
2. Service Role: New Service Role
3. Role Name: `AWSCodePipelineServiceRole-ap-northeast-2-[Pipeline Name]`
   - AWS CodePipeline이 이 새 파이프라인에 사용할 서비스 역할을 생성하도록 허용 활성화
  
#### Step 2: Source Stage
1. 소스: Github(Version 1), 내 GitHub 계정의 리포지토리
   - Github v2가 권고 사항이나 실습은 v1로 진행: [v2 변경시 참고](https://docs.aws.amazon.com/ko_kr/codepipeline/latest/userguide/update-github-action-connections.html)
2. Repository, Branch: 본인의 Repo, main
3. Detection option: GitHub Webhook(recommended)

#### Step 3: Build Stage
1. Provider: AWS Codebuild
2. Project Name: 1주차 실습에서 생성한 Build 프로젝트 선택
3. 환경 변수: 기존 Build 프로젝트에 이미 설정되어 있으므로 추가 없음
4. 빌드 유형: 단일 빌드

#### Step 4: Deploy Stage
1. Provider: AWS Codebuild

__작성중__


### Pull Request/Merge 테스트

별도의 Branch를 만들어 app.py의 Hello World 리턴값 변경 후 main으로 PR 수행 후 이상 없으면 Main에 Merge.

https://ap-northeast-2.console.aws.amazon.com/codesuite/codepipeline/pipelines

Pipeline 도구가 변경 사항을 인지하여 자동으로 빌드/배포가 수행 되는지 확인


## 참고 자료

- 
