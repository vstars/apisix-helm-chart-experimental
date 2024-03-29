{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "apisix.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "apisix.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "apisix.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "apisix.labels" -}}
app.kubernetes.io/name: {{ include "apisix.name" . }}
helm.sh/chart: {{ include "apisix.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "apisix.wait-for-etcd" -}}
- name: wait-for-etcd
  image: "{{ .Values.waitImage.repository }}:{{ .Values.waitImage.tag }}"
  imagePullPolicy: {{ .Values.waitImage.pullPolicy }}
  {{- if .Values.etcdoperator.enabled }}
  command: [ "/bin/sh", "-c", "until ETCDCTL_API=2 etcdctl --endpoints http://{{ default "etcd-cluster" .Values.etcdoperator.etcdCluster.name }}-client.{{ .Release.Namespace }}.svc.cluster.local:2379 cluster-health; do echo 'waiting for etcd'; sleep 1; done; echo 'bye'" ]
  {{- else }}
  command: [ "/bin/sh", "-c", "until ETCDCTL_API=2 etcdctl --endpoints {{ default "http://127.0.0.1:2379" .Values.etcd.customHost | quote }} cluster-health; do echo 'waiting for etcd'; sleep 1; done; echo 'bye'" ]
  {{- end }}
{{- end -}}
