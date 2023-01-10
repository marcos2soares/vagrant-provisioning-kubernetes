
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.13.7/config/manifests/metallb-native.yaml


cat <<EOF | kubectl apply -f -
apiVersion: metallb.io/v1beta1
kind: IPAddressPool
metadata:
  name: ipsmetallb
  namespace: metallb-system
spec:
  addresses:
  - 172.16.16.240-172.16.16.250
EOF

