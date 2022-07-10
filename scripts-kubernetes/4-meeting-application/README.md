https://github.com/EmaLinuxawy/jitsi-kubernetes.git

# Jitsi in Kubernetes

This Guide for set-up Jetsi components on Kubernetes cluster

## Creating Namespace

```bash
kubectl create namespace jitsi
```

### Create Secrets , You should replace `passw0rd` with secret passphare

```bash
kubectl create secret generic jitsi-config -n jitsi --from-literal=JICOFO_COMPONENT_SECRET=passw0rd --from-literal=JICOFO_AUTH_PASSWORD=passw0rd --from-literal=JVB_AUTH_PASSWORD=passw0rd --from-literal=JIGASI_XMPP_PASSWORD=passw0rd --from-literal=JIBRI_RECORDER_PASSWORD=passw0rd --from-literal=JIBRI_XMPP_PASSWORD=passw0rd
```

#### Create ssl certificate using Lets Encrypt 
```bash
# Using openssl self signed certificate
openssl genrsa 2048 > privkey.pem

openssl req -new -x509 -nodes -days 365000 \
   -key privkey.pem \
   -out cert.pem

# Using certbot
certbot -d linuxawy.co --manual --preferred-challenges dns certonly
```
#### Adding certificate to k8s secrets 
```bash
kubectl create secret tls tls-secret --key privkey.pem --cert cert.pem -n jitsi
```

#### Deploy all services 

```bash
kubectl create -f jvb-service.yaml
kubectl create -f deployment.yaml
kubectl create -f web-service.yaml
```


Congratulations you finished setup all Jitsi Services/Deployments on your cluster now you should visit your domain after point the DNS record to your ingress ip.
