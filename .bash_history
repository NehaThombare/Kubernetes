#!/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status
set -o pipefail
echo "🚀 Starting installation of Docker, Kind, and kubectl..."
# ----------------------------
# 1. Install Docker
# ----------------------------
if ! command -v docker &>/dev/null; then   echo "📦 Installing Docker...";   sudo apt-get update -y;   sudo apt-get install -y docker.io;    echo "👤 Adding current user to docker group...";   sudo usermod -aG docker "$USER";    echo "✅ Docker installed and user added to docker group."; else   echo "✅ Docker is already installed."; fi
# ----------------------------
# 2. Install Kind (based on architecture)
# ----------------------------
if ! command -v kind &>/dev/null; then   echo "📦 Installing Kind...";    ARCH=$(uname -m);   if [ "$ARCH" = "x86_64" ]; then     curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.29.0/kind-linux-amd64;   elif [ "$ARCH" = "aarch64" ]; then     curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.29.0/kind-linux-arm64;   else     echo "❌ Unsupported architecture: $ARCH";     exit 1;   fi;    chmod +x ./kind;   sudo mv ./kind /usr/local/bin/kind;   echo "✅ Kind installed successfully."; else   echo "✅ Kind is already installed."; fi
# ----------------------------
# 3. Install kubectl (based on architecture)
# ----------------------------
if ! command -v kubectl &>/dev/null; then   echo "📦 Installing kubectl (latest stable version)...";    ARCH=$(uname -m);   VERSION=$(curl -Ls https://dl.k8s.io/release/stable.txt);    if [ "$ARCH" = "x86_64" ]; then     curl -Lo ./kubectl "https://dl.k8s.io/release/${VERSION}/bin/linux/amd64/kubectl";   elif [ "$ARCH" = "aarch64" ] || [ "$ARCH" = "arm64" ]; then     curl -Lo ./kubectl "https://dl.k8s.io/release/${VERSION}/bin/linux/arm64/kubectl";   else     echo "❌ Unsupported architecture: $ARCH";     exit 1;   fi;    chmod +x ./kubectl;   sudo mv ./kubectl /usr/local/bin/kubectl;   echo "✅ kubectl installed successfully."; else   echo "✅ kubectl is already installed."; fi
# ----------------------------
# 4. Confirm Versions
# ----------------------------
echo
echo "🔍 Installed Versions:"
docker --version
kind --version
kubectl version --client --output=yaml
echo
echo "🎉 Docker, Kind, and kubectl installation complete!"
docker ps
kubectl version
mkdir kind-cluster
cd kind-cluster/
vi config.yaml
kind create cluster --name neha-cluster --config=config.yaml 
sudo systemctl enable --now docker
cd ..
mkdir minikube
cd minikube/
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
minikube
ls
chmod +x minikube
sudo mv minikube /usr/local/bin/
minikube start --driver=docker --vm=true 
kubectl get nodes --context neha-cluster
kubectl get nodes --context kind-neha-cluster
delete minikube
minikube delete
cd kind-cluster/
kubectl get nodes
kubectl config use-context kind-neha-cluster
kubectl get nodes
cd kind-cluster/
ls
cd ..
mkdir kubernetes-in-one-shot
cd kubernetes-in-one-shot/
kubectl get namespaces 
kubectl get pod
kubectl get pods -n kube-system 
kubectl create ns nginx
kubectl run nginx --image=nginx
kubectl delete nginx
kubectl delete pod nginx
kubectl run nginx --image=nginx -n nginx 
kubectl delete pod nginx -n nginx
kubectl delete -n nginx 
kubectl delete ns nginx 
mkdir nginx
cd nginx/
vi namespace.yaml
kubectl apply -f namespace.yaml 
kubectl get ns
vi pod.yml
kubectl apply -f pod.yml 
kubectl get pods -n nginx
kubectl exec -it nginx-pod -n nginx -- bash
kubectl describe pod/nginx-pod -n nginx
vi deployment.yaml
cd kubernetes-in-one-shot/
ls
cd nginx/
ls
vi deployment.yaml
kubectl get ns
kubectl get pods -n nginx 
kubectl delete -f pod.yml 
kubectl apply -f deployment.yaml 
vi deployment.yaml 
kubectl apply -f deployment.yaml 
vi deployment.yaml 
kubectl apply -f deployment.yaml 
vi deployment.yaml 
kubectl apply -f deployment.yaml 
kubectl get pods -n nginx
kubectl scale deployment/nginx-deployment -n nginx --replicas=5
cd kubernetes-in-one-shot/
cd nginx/
kubectl get pods -n nginx
kubectl scale deployment/nginx-deployment -n nginx --replicas=2
kubectl get pods -n nginx
kubectl scale deployment/nginx-deployment -n nginx --replicas=1
kubectl get pods -n nginx
cd kubernetes-in-one-shot/
cd nginx/
kubectl set image deployment/nginx-deployment -n nginx nginx=nginx:1.27.3
kubectl get pods -n nginx
kubectl scale deployment/nginx-deployment -n nginx --replicas=6
kubectl set image deployment/nginx-deployment -n nginx nginx=nginx:1.27.3
kubectl get pods -n nginx
kubectl set image deployment/nginx-deployment -n nginx nginx=nginx:latest
cd kubernetes-in-one-shot/
cd nginx/
kubectl delete -f deployment.yaml 
cp deployment.yaml replicasets.yml
vi replicasets.yml 
kubectl apply -f replicasets.yml 
kubectl get replicasets -n nginx
kubectl get pods -n nginx -o wide
kubectl delete -f replicasets.yml 
ls
kubectl get pods -n nginx -o wide
vi daemonset.yml
cp replicasets.yml daemonsets.yml
vi daemonsets.yml 
kubectl apply -f daemonsets.yml 
kubectl get pods -n nginx -o wide
kubectl apply -f daemonsets.yml 
kubectl get pods -n nginx
kubectl get nodes
ls
vi namespace.yaml 
cd ..
ls
cd ..
ls
cd kind-cluster/
ls
vi config.yaml 
kubectl create cluster --config config.yaml --name neha-cluster
kubectl create cluster --config=config.yaml --name neha-cluster
kubectl create cluster config=config.yaml --name neha-cluster
kind create cluster config=config.yaml --name neha-cluster
kind create cluster --config=config.yaml --name neha-cluster
kind delete cluster --name neha-cluster 
kind create cluster --config=config.yaml --name neha-cluster
cd ..
cd kubernetes-in-one-shot/
cd nginx/
ls
kubectl get ns
kubectl apply -f namespace.yaml 
kubectl get ns
kubectl apply -f daemonsets.yml 
kubectl get pods -n nginx
kubectl delete -f daemonsets.yml 
cd kubernetes-in-one-shot/
cd nginx/
ls
vi job.yml
kubectl apply -f job.yml 
kubectl get job -n nginx
kubectl get pods -n nginx
kubectl logs pod/demo-job-k6mj2 -n nginx
cd kubernetes-in-one-shot/
cd nginx/
vi cronJob.yml
ls
vi cron-job.yml
cd kubernetes-in-one-shot/
cd nginx/
vi cron-job.yaml
kubectl apply -f cron-job.yaml 
vi cron-job.yaml
kubectl apply -f cron-job.yaml 
vi cron-job.yaml
kubectl apply -f cron-job.yaml 
ls
cd kubernetes-in-one-shot/
ls
cd nginx/
ls
vi cron-job.yaml 
kubectl apply -f cron-job.yaml 
vi cron-job.yaml 
kubectl apply -f cron-job.yaml 
vi cron-job.yaml 
kubectl apply -f cron-job.yaml 
vi cron-job.yaml 
kubectl apply -f cron-job.yaml 
vi cron-job.yaml 
kubectl apply -f cron-job.yaml 
vi cron-job.yaml 
kubectl get cronjob -n nginx
kubectl get pods -n nginx
kubectl logs pod/minute-backup-29691640-tscqh -n nginx
vi cron-job.yaml 
kubectl apply -f cron-job.yaml 
kubectl get cronjob -n nginx
kubectl get pods -n nginx
kubectl logs pod/minute-backup-29691650-sldr9 -n nginx
kubectl get pods -n nginx
kubectl delete pod -l app=minute-backup -n nginx
kubectl get pods -n nginx
kubectl apply -f cron-job.yaml
kubectl get cronjob minute-backup -n nginx -o yaml
kubectl get pods -n nginx
kubectl delete -f cron-job.yaml 
kubectl get pods -n nginx
ls
vi job.yml 
kubectl logs pod/demo-job-k6mj2
kubectl delete -f job.yml 
kubectl get pods -n nginx
cd kubernetes-in-one-shot/
cd nginx/
vi persistenVol.yml
kubectl apply -f persistenVol.yml 
vi persistenVol.yml
kubectl apply -f persistenVol.yml 
vi persistenVol.yml
kubectl apply -f persistenVol.yml 
vi persistenVol.yml
kubectl apply -f persistenVol.yml 
kubectl get pv 
vi persistenVolClaim.yml
kubectl get ns
kubectl apply -f persistenVolClaim.yml 
kubectl get pv
kubectl get pvc
kubectl get deployment -n nginx
vi deployment.yaml 
kubectl apply -f deployment.yaml 
vi deployment.yaml 
kubectl apply -f deployment.yaml 
vi deployment.yaml 
kubectl apply -f deployment.yaml 
kubectl get pods -n nginx
kubectl describe pod/nginx-deployment-7b78997987-gxdlc -n nginx
vi persistenVol.yml 
vi persistenVolClaim.yml 
kubectl get pv
kubectl delete pvc/local-pvc
kubectl delete pvc/local-pv
kubectl get pv
kubectl delete pv/local-pv
kubectl apply -f deployment.yaml 
kubectl apply -f persistenVol.yml 
kubectl apply -f persistenVolClaim.yml 
kubectl get pvc
kubectl get pvc -n nginx
kubectl get pods -n nginx
kubectl get pods -o wide -n nginx
kubectl get nodes -n nginx
kubectl get nodes -o wide -n nginx
docker ps
docker exec -it 5629b2112548 bash
cd kubernetes-in-one-shot/
cd nginx/
vi service.yml
kubectl apply -f service.yml 
vi service.yml
kubectl apply -f service.yml 
kubectl get all -n nginx
kubectl port-forward service/nginx-service -n nginx 80:80-- address=0.0.0.0
kubectl port-forward service/nginx-service -n nginx 80:80 --address=0.0.0.0
sudo -E kubectl port-forward service/nginx-service -n nginx 80:80 --address=0.0.0.0
sudo -E kubectl port-forward service/nginx-service -n nginx 81:80 --address=0.0.0.0
sudo KUBECONFIG=$HOME/.kube/config kubectl port-forward service/nginx-service -n nginx 80:80 --address=0.0.0.0
sudo KUBECONFIG=$HOME/.kube/config kubectl port-forward service/nginx-service -n nginx 81:80 --address=0.0.0.0
cd kubernetes-in-one-shot/
git clone https://github.com/LondheShubham153/django-notes-app.git
cd django-notes-app/
git checkout dev
docker build -t nodes-app-k8s
docker build -t nodes-app-k8s .
docker images
docker login -u nmerhjas
docker image tag nodes-app-k8s:latest nmerhjas/nodes-app-k8s:latest
docker images
docker push nmerhjas/nodes-app-k8s:latest
vi depolyment.yml
vi depolyment.yaml
rm depolyment.yaml 
vi deployment.yaml
rm deployment.yaml 
ls
vim deployment.yaml
vim namespace.yml
cd kubernetes-in-one-shot/
git clone https://github.com/LondheShubham153/django-notes-app
ls
cd django-notes-app/
ls
vi deployment.yaml 
mkdir k8s
cd k8s/
vi deployment.yml
cd ..
vi deployment.yaml 
rm deployment.yaml 
ls
cd k8s/
ls
vi deployment.yaml
kubectl get ns
vi deployment.yaml
vi namespace.yml
ls
cd ..
vi namespace.yml 
rm namespace.yml 
cd k8s/
vi namespace.yml 
vi service.yml
kubectl apply -f namespace.yml 
kubectl apply -f deployment.yaml 
kubectl apply -f service.yml 
vi service.yml 
kubectl apply -f service.yml 
kubectl get pods -n notes-app 
kubectl port-forward service/notes-app-service -n notes-app 8000:8000 --address=0.0.0.0
vi deployment.yaml 
vi service.yml 
kubectl get deployment/notes-app-deployment
kubectl get deployment -n notes-app
kubectl delete deployment/notes-app-deployment
kubectl delete deployment/notes-app-deployment -n notes-app
kubectl get svc -n notes-app
kubectl delete service/notes-app-service -n notes-app
kubectl delete ns notes-app
kubectl apply -f deployment.yaml -f service.yml 
kubectl get pods -n nginx
cd ..
kubectl apply -f https://kind.sigs.k8s.io/examples/ingress/usage.yaml
kubectl get ns 
kubectl apply -f https://kind.sigs.k8s.io/examples/ingress/usage.yaml
kubectl get ns 
kubectl apply -f https://kind.sigs.k8s.io/examples/ingress/deploy-ingress-nginx.yaml
kubectl get ns
kubectl get pods -n ingress-nginx 
kubectl get svc -n ingress-nginx 
cd nginx/
vi ingress.yml
kubectl apply -f ingress.yml 
vi ingress.yml
kubectl apply -f ingress.yml 
cd ..
kubectl get all -n ngix
kubectl get all -n nginx
cd kubernetes-in-one-shot/
ls
kubectl get pods -n gnix
kubectl get pods -n ngnix
cd nginx/
ls
cd ..
cd django-notes-app/
ls
cd k8s/
ls
kubectl get pods -n nginx
kubectl describe pod/notes-app-deployment-776fcc89ff-7j66v -n nginx
cd kubernetes-in-one-shot/
cd django-notes-app/
cd k8s/
kubectl get pods -n nginx
cd ..
kubectl get ns
kubectl get pods -n ingress-nginx 
kubectl get svc -n ingress-nginx 
cd nginx/
vi ingress.yml
cd kubernetes-in-one-shot/
cd nginx/
vi ingress.yml 
kubectl apply -f ingress.yml 
kubectl get ingress -n nginx
kubectl get all
kubectl get all -n nginx
kubectl get svc -n nginx
kubectl get svc -n ingress-nginx 
kubectl port-forward service/ingress-nginx-controller -n ingress-nginx 80:80 --address=0.0.0.0
kubectl port-forward service/ingress-nginx-controller -n ingress-nginx 8080:80 --address=0.0.0.0
vi ingress.yml 
kubectl apply -f ingress.yml 
kubectl port-forward service/ingress-nginx-controller -n ingress-nginx 8080:80 --address=0.0.0.0
vi ingress.yml 
kubectl apply -f ingress.yml 
kubectl port-forward service/ingress-nginx-controller -n ingress-nginx 8080:80 --address=0.0.0.0
vi ingress.yml 
kubectl apply -f ingress.yml 
kubectl port-forward service/ingress-nginx-controller -n ingress-nginx 8080:80 --address=0.0.0.0
vi ingress.yml 
kubectl apply -f ingress.yml 
kubectl port-forward service/ingress-nginx-controller -n ingress-nginx 8080:80 --address=0.0.0.0
vi ingress.yml 
kubectl port-forward service/ingress-nginx-controller -n ingress-nginx 8080:80 --address=0.0.0.0
vi ingress.yml 
kubectl apply -f ingress.yml 
kubectl port-forward service/ingress-nginx-controller -n ingress-nginx 8080:80 --address=0.0.0.0
kubectl delete -f namespace.yaml 
kubectl apply -f namespace.yaml 
kubectl apply -f deployment.yaml -f service.yml 
kubectl get all -n nginx
cd ..
cd django-notes-app/
ls
cd k8s/
ls
vi service.yml 
vi namespace.yml 
vi deployment.yaml 
kubectl apply -f deployment.yaml -f service.yml 
cd ..
kubectl get all -n nginx
cd ..
git clone https://github.com/LondheShubham153/tws-e-commerce-app
ls
cd tws-e-commerce-app/
ls
docker build -t eCommerce .
docker build -t e-commerce .
docker images
docker login -u nmerhjas
docker image tag e-commerce:latest nmerhjas/e-commerce-app:latest
docker images
docker push nmerhjas/e-commerce-app:latest 
mkdir e-com-app
cd e-com-app/
vi deployment.yml
vi service.yml
cd ../..
cd django-notes-app/
cd k8s/
ls
vi deployment.yaml 
vi service.yml 
cd ../..
ls
cd tws-e-commerce-app/
cd e-com-app/
vi deployment.yml 
vi service.yml 
kubectl apply -f deployment.yml -f service.yml 
vi service.yml 
kubectl apply -f deployment.yml -f service.yml 
vi service.yml 
kubectl apply -f deployment.yml -f service.yml 
cd ../..
ls
cd nginx/
ls
vi ingress.yml 
cd ..
cd tws-e-commerce-app/
cd e-com-app/
kubectl get svc -n ngonx
kubectl get svc -n nginx
cd ../..
cd nginx/
vi ingress.yml 
kubectl apply -f ingress.yml 
kubectl get svc -n nginx
kubectl get svc -n ingress-nginx 
kubectl port-forward service/ingress-nginx-controller -n nginx 8080:80 --address=0.0.0.0
cd kubernetes-in-one-shot/
cd nginx/
ls
kubectl port-forward service/ingress-controller -n nginx 8080:80 --address=0.0.0.0
kubectl get ns
kubectl port-forward service/ingress-controller -n ingress-nginx 8080:80 --address=0.0.0.0
kubectl get svc -n nginx
kubectl get svc -n ingress-nginx 
kubectl port-forward service/ingress-nginx-controller -n ingress-nginx 8080:80 --address=0.0.0.0
vi ingress.yml 
kubectl port-forward service/ingress-nginx-controller -n ingress-nginx 8080:80 --address=0.0.0.0
vi ingress.yml 
kubectl get pods -n nginx
vi ingress.yml 
kubectl apply -f ingress.yml 
kubectl port-forward service/ingress-nginx-controller -n ingress-nginx 8080:80 --address=0.0.0.0
vi service.yml 
vi deployment.yaml 
vi service.yml 
cd ..
ls
cd tws-e-commerce-app/
ls
cd e-com-app/
ls
vi service.yml 
vi deployment.yml 
cd ../..
cd nginx/
vi ingress.yml 
cd ..
cd django-notes-app/
cd k8s/
vi deployment.yaml 
cd ../..
cd tws-e-commerce-app/
cd e-com-app/
vi deployment.yml 
vi service.yml 
kubectl apply -f deployment.yml -f service.yml 
vi deployment.yml 
cd ../..
cd nginx/
kubectl delete -f namespace.yaml 
kubectl apply -f namespace.yaml 
kubectl apply -f deployment.yaml -f service.yml 
cd ..
cd tws-e-commerce-app/
cd e-com-app/
kubectl apply -f deployment.yml -f service.yml 
cd ../..
cd django-notes-app/
cd k8s/
kubectl apply -f deployment.yaml -f service.yml 
cd ../..
cd nginx/
vi ingress.yml 
kubectl apply -f ingress.yml 
kubectl get endpoints e-com-app -n nginx
kubectl get svc -n ingress-nginx 
kubectl get ns
kubectl port-forward service/ingress-nginx-controller -n ingress-nginx 8080:80 --address=0.0.0.0
vi ingress.yml 
cd ..
cd tws-e-commerce-app/
cd e-com-app/
vi service.yml 
kubectl apply -f service.yml 
cd ../..
cd nginx/
kubectl port-forward service/ingress-nginx-controller -n ingress-nginx 8080:80 --address=0.0.0.0
kubectl logs -l app=e-com-app -n nginx
cd ..
cd tws-e-commerce-app/
cd e-com-app/
vi dep
vi deployment.yml 
vi service.yml 
kubectl apply -f deployment.yml -f service.yml 
cd ../..
history
kubectl port-forward service/ingress-nginx-controller -n ingress-nginx 8080:80 --address=0.0.0.0
cd nginx/
vi ingress.yml 
kubectl apply -f ingress.yml 
kubectl port-forward service/ingress-nginx-controller -n ingress-nginx 8080:80 --address=0.0.0.0
vi ingress.yml 
kubectl apply -f ingress.yml 
kubectl port-forward service/ingress-nginx-controller -n ingress-nginx 8080:80 --address=0.0.0.0
kubectl delete -f namespace.yaml 
cd ..
mkdir mysql
ls
cd kubernetes-in-one-shot/
cd mysql/
vi statefulset.yml
vi namespace.yml
kubectl apply -f namespace.yml 
vi statefulset.yml
vi service.yml
vi statefulset.yml
kubectl apply -f service.yml 
kubectl apply -f statefulset.yml 
vi statefulset.yml 
kubectl apply -f statefulset.yml 
vi statefulset.yml 
kubectl apply -f statefulset.yml 
vi statefulset.yml 
kubectl apply -f statefulset.yml 
vi statefulset.yml 
kubectl apply -f statefulset.yml 
kubectl get pods -n mysql 
kubectl exec -it mysql-statefulset-0 -n mysql -- bash
cd kubernetes-in-one-shot/
cd mysql/
kubectl get pods -n mysql
kubectl delete pod mysqp-statefulstate-0 -n mysql
kubectl delete pod mysql-statefulstate-0 -n mysql
kubectl delete pod mysql-statefulset-0 -n mysql
kubectl get pods -n mysql
vi configmap.yml
kubectl apply -f configmap.yml 
kubectl get configmap -n mysql
vi statefulset.yml 
kubectl apply -f statefulset.yml 
vi statefulset.yml 
kubectl apply -f statefulset.yml 
kubectl get statefulset -n mysql
kubectl delete statefulset/mysql-statefulset -n mysql
kubectl apply -f statefulset.yml 
sudo apt update && sudo apt install git -y
git config --global user.name "nehathombare"
git config --global user.email "nehacthombare@gmail.com"
ssh-keygen -t ed25519 -C "nehacthombare@gmail.com"
cat ~/.ssh/id_ed25519.pub
cd kubernetes-in-one-shot/
git init
git add .
git commit -m "First commit"
git remote add origin git@github.com:nehathombare/Kubernetes.git
git branch -M main
git push -u origin main
git remote add origin git@github.com:NehaThombare/Kubernetes.git
# Delete the existing origin configuration
git remote remove origin
# Add your new repository URL
git remote add origin git@github.com:NehaThombare/Kubernetes.git
git branch -M main
git push -u origin main
# 1. Pull the remote files and allow unrelated histories
git pull origin main --allow-unrelated-histories
# 2. (Optional) If a text editor pops up asking for a commit message, 
#    just press Ctrl+X (in Nano) or type :wq (in Vim) to save and exit.
# 3. Now push your merged code up to GitHub
git push -u origin main
git push -u origin main --force
cd ..
ls
cd kind-cluster/
ls
git add .
git init
cd ..
ls
cd ~/kubernetes-in-one-shot
rm -rf .git
cd ~
git init
ls
git init
git remote add origin git@github.com:NehaThombare/Kubernetes.git
git add kind-cluster/ kubernetes-in-one-shot/ minikube/
ls
rm -rf ~/kind-cluster/.git
rm -rf ~/minikube/.git
# 1. Clear Git's tracking memory cache
git rm --cached -r kind-cluster/ kubernetes-in-one-shot/ minikube/ 2>/dev/null
# 2. Add all three folders again
git add kind-cluster/ kubernetes-in-one-shot/ minikube/
find ~/kind-cluster ~/kubernetes-in-one-shot ~/minikube -name ".git" -type d -exec rm -rf {} + 2>/dev/null
git rm --cached -r kind-cluster/ kubernetes-in-one-shot/ minikube/ 2>/dev/null
git add kind-cluster/ kubernetes-in-one-shot/ minikube/
git commit -m "Kubernetes all folders"
git push -u origin main --force
git branch -M main
git push -u origin main --force
git rm --cached kubernetes-in-one-shot/django-notes-app
git rm --cached kubernetes-in-one-shot/tws-e-commerce-app
git add kubernetes-in-one-shot/django-notes-app/
git add kubernetes-in-one-shot/tws-e-commerce-app/
git commit -m "Include application code files for django and e-commerce apps"
git push origin main
ls
cd minikube/
ls
cd ..
cd kubernetes-in-one-shot/
ls
cd mysql/
vi configmap.yml 
kubectl apply -f configmap.yml 
kubectl apply -f statefulset.yml 
kubectl get pods -n mysql
vi secret.yml
echo "root" | base64
vi secret.yml 
vi statefulset.yml 
kubectl apply -f secret.yml 
kubectl apply -f statefulset.yml 
cd kubernetes-in-one-shot/
cd mysql/
vi secret.yml 
git init
git add .
git commit -m "Secret added" 
git push origin main
git reset --soft HEAD~1
git reset
ls
cd minikube/
ls
cd ..
rm minikube/
minikube delete --all --purge
ls
rm -rf ~/.minikube
ls
cd minikube/
ls
cd ..
ls
rm -rf minikube/
ls
git add .
git status
git commit -m "Changes related to secrets.yml" 
git push origin main
git reset --soft HEAD~1
git reset
git rm -r --cached .ssh/ 2>/dev/null || true
echo ".ssh/" >> .gitignore
git add .gitignore
ls
git add kubernetes-in-one-shot/
git status
git commit -m "Secret file changes and modified stateful file"
git push origin main 
cd kubernetes-in-one-shot/
cd mysql/
kubectl delete -f namespace.yml 
cd ..
cd nginx/
vi deployment.yaml 
kubectl apply -f namespace.yaml 
vi persistenVol.yml 
vi persistenVolClaim.yml 
vi deployment.yaml 
kubectl apply -f persistenVol.yml 
kubectl apply -f persistenVolClaim.yml 
kubectl apply -f deployment.yaml 
kubectl get pv -n nginx
kubectl delete pv local-pv -n ngonx
kubectl delete pv local-pv -n nginx
kubectl apply -f persistenVol.yml 
kubectl apply -f persistenVolClaim.yml 
vi deployment.yaml 
kubectl apply -f deployment.yaml 
kubectl get pods -n nginx
kubectl describe pod nginx-deployment-69b6f578c9-n8dsp -n nginx
cd ..
cd django-notes-app/
cd k8s/
vi deployment.yaml 
kubectl apply -f service.yml 
kubectl apply -f deployment.yaml 
kubectl get pods -n nginx
kubectl describe pod notes-app-deployment-65fdfb7d97-pcskl -n nginx
vi deployment.yaml 
cd ..
cd nginx/
cd kubernetes-in-one-shot/
cd nginx/
ls
vi pod.yml 
kubectl delete ns nginx 
kubectl get nodes
kubectl taint node neha-cluster-worker prod=true:NoSchedule
ntcluster-worker2 prrod=true:NoSchedule
kubectl taint node neha-cluster-worker3 prod=true:NoSchedule
kubectl apply -f namespace.yaml 
kubectl apply -f pod.yml 
kubectl get pods -n nginx
kubectl taint node neha-cluster-worker2 prod=true:NoSchedule-
[200~kubectl describe node tws-cluster-worker2 | grep -i taints
kubectl describe node neha-cluster-worker2 | grep -i taints
kubectl taint node neha-cluster-worker2 prrod=true:NoSchedule-
kubectl get pods -n nginx
cd kubernetes-in-one-shot/
cd nginx/
kubectl taint node neha-cluster-worker2 prod=true:NoSchedule
vi pod.yml 
cd kubernetes-in-one-shot/
cd nginx/
vi pod.yml 
kubectl apply -f pod.yml 
vi pod.yml 
kubectl apply -f pod.yml 
kubectl get pods -n nginx
kubectl delete pod/nginx-pod -n nginx
kubectl get pods -n nginx
kubectl apply -f pod.yml 
kubectl get pods -n nginx
cd ..
git add .
git status
git add kubernetes-in-one-shot/
git status
git commit -m "Resource-limits, Probes, Taint & Tolerance"
git push origin main 
cd kubernetes-in-one-shot/
cd nginx/
kubectl get nodes
kubectl top node
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/download/v0.6.1/components.yaml
kubectl -n kube-system edit deployment metrics-server
kubectl -n kube-system rollout restart deployment metrics-server
kubectl get pods -n kube-system 
kubectl taint node neha-cluster-worker2 prod=true:NoSchedule-
kubectl taint node neha-cluster-worker3 prod=true:NoSchedule-
kubectl taint node neha-cluster-worker prod=true:NoSchedule-
kubectl get pods -n kube-system 
kubectl top node
kubectl delete -f pod.yml 
kubectl top pod
kubectl get pods -n nginx
kubectl get pods
kubectl delete pod/bar-app
kubectl delete pod/foo-app
cd ..
mkdir apache
ls
cd apache/
vi namespace.yml
kubectl apply -f namespace.yml 
vi deployment.yml
kubectl apply -f deployment.yml 
vi deployment.yml
kubectl apply -f deployment.yml 
vi deployment.yml 
kubectl apply -f deployment.yml 
vi de
vi deployment.yml 
kubectl apply -f deployment.yml 
vi deployment.yml 
kubectl apply -f deployment.yml 
vi deployment.yml 
kubectl apply -f deployment.yml 
kubectl get pods -n apache 
vi service.yml
kubectl apply -f service.yml 
vi service.yml 
kubectl apply -f service.yml 
kubectl get all
kubectl get all -n apache
cd kubernetes-in-one-shot/
cd apache/
ls
kubectl port-forward service/apache-service -n apache 82:80 --address=0.0.0.0
sudo -E kubectl port-forward service/apache-service -n apache 82:80 --address=0.0.0.0
kubectl port-forward service/apache-service -n apache 8082:80 --address=0.0.0.0
clear
vi hpa.yml
kubectl get pods -n apache 
ls
cd kubernetes-in-one-shot/
ls
cd apache/
ls
kubectl port-forward service/apache-service -n apache 82:80 --address=0.0.0.0  
sudo kubectl port-forward service/apache-service -n apache 82:80 --address=0.0.0.0 --kubeconfig=$HOME/.kube/config
kubectl apply -f hpa.yml 
kubectl get hpa -n apache
kubectl run -it load-generator --image=busybox -n apache -- bash
kubectl run -it load-generator --image=busybox -n apache -- /bin/sh
kubectl delete pod load-generator -n apache
kubectl run -it load-generator --image=busybox -n apache 
kubectl get pods -n apache
kubectl run -it load-generator --image=busybox -n apache 
kubectl delete pod load-generator -n apache
kubectl run -it load-generator --image=busybox -n apache /bin/sh
xit
cd kubernetes-in-one-shot/
cd apache/
kubectl run -it load-generator --image=busybox -n apache /bin/sh
kubectl delete pod load-generator -n apache
kubectl run -it load-generator --image=busybox -n apache /bin/sh
kubectl get pods -n apache
kubectl run -it load-generator --image=busybox -n apache /bin/sh
cd kubernetes-in-one-shot/
cd apache/
kubectl delete pod load-generator -n apache
kubectl run -it load-generator --image=busybox -n apache /bin/sh
cd kubernetes-in-one-shot/
cd apache/
kubectl get pods -n apache
kubectl get hpa -n apache
kubectl scale deployment apache-deployment --replicas=1 -n apache
watch kubectl get pods -n apache
kubectl delete -f deployment.yml 
kubectl apply -f deployment.yml 
watch kubectl get pods -n apache
kubectl get pods -n apache
kubectl apply -f hpa.yml 
kubectl get pods -n apache
ls
cd ..
cd django-notes-app/
cd k8s/
vi deployment.yaml 
vi hpa.yml
kubectl apply -f namespace.yml 
kubectl apply -f deployment.yaml 
kubectl apply -f service.yml 
kubectl apply -f hpa.yml 
kubectl get hpa -n nginx
kubectl get pods -n nginx
cd kubernetes-in-one-shot/
cd django-notes-app/
cd k8s/
kubectl get hpa -n nginx
kubectl get pods -n ngix
kubectl get pods -n nginx
kubectl delete namespaces nginx 
cd ..
cd apache/
git clone https://github.com/kubernetes/autoscaler.git
ls
cd autoscaler/
ls
cd vertical-pod-autoscaler/
ls
./hack/vpa-up.sh 
cd ..
vi vpa.yml
kubectl get pods -n apache
kubectl delete -f hpa.yml
kubectl get hpa -n apache
ls
vi vpa.yml 
mv vpa.yml apache
cd ..
ls
cd autoscaler/
ls
cd apa
vi apache 
mv apache ~/kubernetes-in-one-shot/apache/
cd ..
ls
vi apache 
mv apache vpa.yml
ls
kubectl delete -f hpa.yml 
kubectl apply -f vpa.yml 
kubectl get vpa -n apache
kubectl run -i --tty load-generator --image=busybox -n apache /bin/sh
