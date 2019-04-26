resource "helm_release" "rabbitmq" {
    name      = "rabbitmq"
    chart     = "stable/rabbitmq"

    values = [<<EOF
image:
  registry: docker.io
  repository: bitnami/rabbitmq
  tag: 3.7.14
  debug: false
  pullPolicy: IfNotPresent

rbacEnabled: false

rabbitmq:
  username: ${var.rabbitmq_username}
  password: ${var.rabbitmq_password}

  erlangCookie: ${var.erlang_cookie}

  logs: '-'

  ulimitNofiles: '65536'

  clustering:
    address_type: hostname
    k8s_domain: cluster.local

  loadDefinition:
    enabled: false
    secretName: load-definition

  configuration: |-
    ## Clustering
    cluster_formation.peer_discovery_backend  = rabbit_peer_discovery_k8s
    cluster_formation.k8s.host = ${var.k8s_master_host}
    cluster_formation.node_cleanup.interval = 10
    cluster_formation.node_cleanup.only_log_warning = true
    cluster_partition_handling = autoheal
    queue_master_locator=min-masters
    loopback_users.guest = false

  extraConfiguration: |-
    #disk_free_limit.absolute = 50MB
    #management.load_definitions = /app/load_definition.json

## Kubernetes service type
service:
  type: ClusterIP
  ## Node port
  ## ref: https://github.com/bitnami/bitnami-docker-rabbitmq#environment-variables
  ##
  nodePort: 30672

  ## Amqp port
  ## ref: https://github.com/bitnami/bitnami-docker-rabbitmq#environment-variables
  ##
  port: 5672

  ## Dist port
  ## ref: https://github.com/bitnami/bitnami-docker-rabbitmq#environment-variables
  ##
  distPort: 25672

  ## RabbitMQ Manager port
  ## ref: https://github.com/bitnami/bitnami-docker-rabbitmq#environment-variables
  ##
  managerPort: 15672

podLabels: {}

securityContext:
  enabled: true
  fsGroup: 1001
  runAsUser: 1001

persistence:
  enabled: true
  storageClass: "fast"
  accessMode: ReadWriteOnce

  # If you change this value, you might have to adjust `rabbitmq.diskFreeLimit` as well.
  size: ${var.rabbitmq_disk_size}

  path: /opt/bitnami/rabbitmq/var/lib/rabbitmq

resources:
  requests:
    memory: 256Mi
    cpu: 50m
  limit:
    memory: 3072Mi
    cpu: 100m

replicas: ${var.replicas_count}

updateStrategy:
  type: RollingUpdate

nodeSelector: {}
tolerations: []
affinity: {}
podAnnotations: {}

## Configure the ingress resource that allows you to access the
## Wordpress installation. Set up the URL
## ref: http://kubernetes.io/docs/user-guide/ingress/
##
ingress:
  ## Set to true to enable ingress record generation
  enabled: false

  ## The list of hostnames to be covered with this ingress record.
  ## Most likely this will be just one host, but in the event more hosts are needed, this is an array
  ## hostName: foo.bar.com
  path: /

  ## Set this to true in order to enable TLS on the ingress record
  ## A side effect of this will be that the backend wordpress service will be connected at port 443
  tls: true

  ## If TLS is set to true, you must declare what secret will store the key/certificate for TLS
  tlsSecret: myTlsSecret

  ## Ingress annotations done as key:value pairs
  ## If you're using kube-lego, you will want to add:
  ## kubernetes.io/tls-acme: true
  ##
  ## For a full list of possible ingress annotations, please see
  ## ref: https://github.com/kubernetes/ingress-nginx/blob/master/docs/annotations.md
  ##
  ## If tls is set to true, annotation ingress.kubernetes.io/secure-backends: "true" will automatically be set
  annotations:
  #  kubernetes.io/ingress.class: nginx
  #  kubernetes.io/tls-acme: true

## The following settings are to configure the frequency of the lifeness and readiness probes
livenessProbe:
  enabled: true
  initialDelaySeconds: 120
  timeoutSeconds: 20
  periodSeconds: 30
  failureThreshold: 6
  successThreshold: 1

readinessProbe:
  enabled: true
  initialDelaySeconds: 10
  timeoutSeconds: 20
  periodSeconds: 30
  failureThreshold: 3
  successThreshold: 1
    EOF
    ]

}
