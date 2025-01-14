# Đặt namespace
$namespace = "nm-kafka"

# 1. Apply Zookeeper
Write-Host "Applying Zookeeper Deployment..."
kubectl apply -f .\kafka\zookeeper.yaml

Write-Host "Waiting for Zookeeper to be ready..."
kubectl wait --for=condition=ready pod -l app=zookeeper -n $namespace --timeout=300s

# 2. Apply broker
Write-Host "Applying broker Deployment..."
kubectl apply -f .\kafka\broker.yaml

Write-Host "Waiting for broker to be ready..."
kubectl wait --for=condition=ready pod -l app=broker -n $namespace --timeout=300s

# 3. Apply 
Write-Host "Applying connect-debezium Deployment..."
kubectl apply -f .\kafka\connect-debezium.yaml

Write-Host "Waiting for connect-debezium to be ready..."
kubectl wait --for=condition=ready pod -l app=connect-debezium -n $namespace --timeout=300s

# 3. kafka-ui 
Write-Host "Applying kafka-ui Deployment..."
kubectl apply -f .\kafka\kafka-ui.yaml

Write-Host "Waiting for kafka-ui to be ready..."
kubectl wait --for=condition=ready pod -l app=kafka-ui -n $namespace --timeout=300s

Write-Host "Deployment completed successfully!"