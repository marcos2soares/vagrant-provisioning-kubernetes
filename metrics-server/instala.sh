

wget -O metric.yaml https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
# add parameter --kubelet-insecure-tls
sed -i "/metric-resolution/a\
\        - --kubelet-insecure-tls"  metric.yaml
kubectl apply -f ./metric.yaml
