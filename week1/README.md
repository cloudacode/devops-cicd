# DevOps - Week1 실습 

__개발 빌드 환경 구성 및 Docker 빌드 자동화 실습__

CI 도구를 통해 소스 관리 하고 master로 Pull Request가 되면 어플리케이션을 도커로 빌드 자동화, 레지스트리에 등록

## 사전 준비 사항

## 구성 하기

### Upload source code to github repo

```bash
├── Dockerfile
├── app.py
├── buildspec.yml
└── requirements.txt
```

### Setup the codebuild

https://ap-northeast-2.console.aws.amazon.com/codesuite/codebuild/projects

1. 소스: Github, 내 GitHub 계정의 리포지토리
   - GitHub Personal access token 생성 필요: [참고](https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/creating-a-personal-access-token)
   - 권한은 repo, admin:repo_hook [참고](https://docs.aws.amazon.com/codebuild/latest/userguide/access-tokens.html#access-tokens-github)
2. Webhook: 코드 변경이 이 리포지토리에 푸시될 때마다 다시 빌드 선택
3. 이벤트 유형: PULL_REQUEST_*
4. 환경: 관리형 이미지, Ubuntu, Standard, aws/codebuild/standard:4.0, 권한 승격 활성화
5. 서비스 역할: 새 서비스 역할 (프로젝트 생성 후 IAM에서 추후 업데이트)
6. 환경 변수:
   ```
   IMAGE_TAG: latest
   IMAGE_REPO_NAME: [Docker Repo Name]
   DOCKERHUB_USER: dockerhub:username
   DOCKERHUB_PW: dockerhub:password
   ```
   - username, password 보안을 위해 Secret Manager를 활용하여 암호 저장 및 관리. [참고](https://aws.amazon.com/premiumsupport/knowledge-center/codebuild-docker-pull-image-error/?nc1=h_ls#Store_your_DockerHub_credentials_with_AWS_Secrets_Manager) 

### Add permission in IAM role

SecretManager에서 정의한 dockerhub secret도 읽는 권한을 부여 하기 위해 
__CodeBuildSecretsManagerPolicy-[codebuild project name]-ap-northeast-2__
의 Resource에 secretsmanager:GetSecretValue 항목에 [Secertmanager dockerhub](https://ap-northeast-2.console.aws.amazon.com/secretsmanager/home?region=ap-northeast-2#/secret?name=dockerhub) ARN 추가

### Verify Codebuild Job manually

수동으로 수행 및 콘솔에서 확인

### DockerHub image 

이미지가 정상적으로 업로드 되었는지 확인 

https://hub.docker.com

### Pull Request 테스트

별도의 Branch를 만들어 app.py의 Hello World 리턴값 변경 후 main으로 PR 수행
![PR](build_process_by_github_webhook.png)
CI 도구가 변경 사항을 인지하여 자동으로 수행 되는지 확인

### (옵션) Docker image 로컬 테스트

Docker run
```
docker run -p 8000:8000 --name devops -d [DockerHub Repo]:latest
```

http://localhost:8000 를 통해 웹 페이지 값을 확인

## 참고 자료

- https://docs.aws.amazon.com/ko_kr/codebuild/latest/userguide/sample-docker.html
- https://docs.aws.amazon.com/ko_kr/codebuild/latest/userguide/github-webhook.html
