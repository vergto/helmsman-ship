admin admin

��������� Helm
����������� PVC � ������� 777 �� ����� 

����� ���������� Nexus � ��� �������� Service ���� NodePort ����������


helm install nexus sonatype/nexus-repository-manager \
  --namespace nexus-registry \
  --set persistence.existingClaim=nexus-pvc \
  --set nexus.service.type=NodePort \
  --set nexus.service.nodePort=31000 \
  --set nexus.nexusPassword=admin123 \
  --set nexus.resources.requests.memory=256Mi \
  --set nexus.resources.requests.cpu=100m
  
  helm upgrade nexus sonatype/nexus-repository-manager \
  --namespace nexus-registry \
  --set persistence.enabled=true \
  --set persistence.existingClaim=nexus-pvc \
  --set nexus.nexusDataPath=/nexus-data \
  --set nexus.service.type=NodePort \
  --set nexus.service.nodePort=31000 \
  --set nexus.resources.requests.memory=256Mi \
  --set nexus.resources.requests.cpu=100m