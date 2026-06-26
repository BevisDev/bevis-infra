{{/*
Namespace to use for dbt pods.
*/}}
{{- define "dbt.namespace" -}}
{{- .Values.namespace | default .Release.Namespace }}
{{- end }}

{{/*
Expand the name of the chart.
*/}}
{{- define "dbt.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "dbt.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Common labels.
*/}}
{{- define "dbt.labels" -}}
helm.sh/chart: {{ printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
app.kubernetes.io/name: {{ include "dbt.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
ServiceAccount name to use for dbt pods.
*/}}
{{- define "dbt.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "dbt.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Name of the profiles ConfigMap for a dbt project.
Usage: include "dbt.projectProfilesConfigMap" (dict "root" $ "project" $project)
*/}}
{{- define "dbt.projectProfilesConfigMap" -}}
{{- $root := .root -}}
{{- $project := .project -}}
{{- printf "%s-%s-profiles" (include "dbt.fullname" $root) $project -}}
{{- end }}

{{/*
Name of the credentials Secret for a dbt project.
Usage: include "dbt.projectCredentialsSecret" (dict "root" $ "project" $project)
*/}}
{{- define "dbt.projectCredentialsSecret" -}}
{{- $root := .root -}}
{{- $project := .project -}}
{{- printf "%s-%s-credentials" (include "dbt.fullname" $root) $project -}}
{{- end }}

{{/*
dbt --select flag value for the Job template.
Empty string means run all tests.
*/}}
{{- define "dbt.jobSelect" -}}
{{- if .Values.job.select -}}
{{- .Values.job.select -}}
{{- end -}}
{{- end }}

{{/*
RBAC names for Airflow pod launcher in the dbt namespace.
*/}}
{{- define "dbt.podLauncherRoleName" -}}
{{- .Values.rbac.podLauncher.roleName | default (printf "%s-pod-launcher" (include "dbt.fullname" .)) }}
{{- end }}

{{- define "dbt.podLauncherRoleBindingName" -}}
{{- .Values.rbac.podLauncher.roleBindingName | default (printf "%s-pod-launcher" (include "dbt.fullname" .)) }}
{{- end }}
