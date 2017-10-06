# alpine-ssh-tunnel
Easy to use SSH Tunnel based in the Alpine Linux docker image

Based on https://github.com/iadknet/docker-ssh-client-light with some tweaks/customizations.

## Build
```
docker build --no-cache -t [image-name]:latest .
```

## Usage
```
docker run -d -p [LocalPort]:[LocalPort] -e "LOCAL_PORT=[LocalPort]" -e "REMOTE_HOST=[RemoteHost]" -e "REMOTE_PORT=[RemotePort]" -e "SSH_USER=[SshUser]" -e "SSH_HOST=[SshHost]" -e "ID_FILE=/app/conn.pem" -v [IdFile]:/app/conn.pem:ro --name=tunnel [image-name]
```

In Kubernetes:

```yaml
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: ssh
  labels:
    app: ssh
spec:
  replicas: 1
  template:
    metadata:
      labels:
        app: ssh
    spec:
      containers:
      - image: my-app
        name: app
      - image: elblivion/alpine-ssh
        name: sshtunnel
        env:
          - name: SSH_KEY
            valueFrom:
              secretKeyRef:
                name: ssh-key-secret
                key: id_rsa
          - name: DEBUG
            value: "true"
          - name: SSH_HOST
            value: "my.host.com"
          - name: LOCAL_PORT
            value: "8000"
          - name: REMOTE_HOST
            value: "my-cool-internal.service"
          - name: REMOTE_PORT
            value: "80"
          - name: SSH_USER
            value: "johndoe"
```
