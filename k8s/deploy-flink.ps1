# Đặt namespace
$namespace = "nm-kafka"

# 1. Apply ConfigMap
Write-Host "Applying ConfigMap..."
kubectl apply -f .\flink\flink-config.yaml

# 2. Apply JobManager
Write-Host "Applying JobManager Deployment..."
kubectl apply -f .\flink\flink-jobmanager.yaml

Write-Host "Waiting for JobManager to be ready..."
kubectl wait --for=condition=ready pod -l app=flink,component=jobmanager -n $namespace --timeout=300s

# 3. Apply TaskManager
Write-Host "Applying TaskManager Deployment..."
kubectl apply -f .\flink\flink-taskmanager.yaml

Write-Host "Waiting for TaskManager to be ready..."
kubectl wait --for=condition=ready pod -l app=flink,component=taskmanager -n $namespace --timeout=300s

Write-Host "Deployment completed successfully!"
