_k8s_cluster() { 
  local - a clsuter
  local kubeconfig_dir=${HOME}/dev/vshn/kubeconfigs

  clusters=(${^kubeconfig_dir}/*.kubeconfig(N:t:r))

  _describe 'clusters' clusters
}
compdef _k8s_cluster k8s_cluster