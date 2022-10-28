#!/usr/bin/env bash

main () {
  log=/var/log/bootstrap.log

  print_welcome
  check_root_privileges
  check_amazon_linux_extras
  install_nginx
  configure_landing_page
  configure_nginx_service
  test_landing_page

  echo_log "Completed successfully"
  exit 0
}

echo_log() {
    echo "[$(date '+%F %H:%M')] ${1}" |sudo tee -a $log
}

print_welcome() {
  printf '##########################
  Starting bootstrap.sh
##########################
' |sudo tee -a $log 
}


check_root_privileges() {
  if [[ $EUID -ne 0 ]]; then
    echo "The script must be executed with root privileges"
    exit 1
  fi
}


check_amazon_linux_extras() {
  echo_log "Verifying amazon-linux-extras is available"

  if ! command -v amazon-linux-extras &> /dev/null; then
    echo_log "Could not detect amazon-linux-extras command"
    exit 1
  fi
}

install_nginx() {
  echo_log "Installing Nginx"

  nginx_pkg_name="$(amazon-linux-extras list |awk '/nginx/ {print $2}' 2> /dev/null)"
  if [[ -z ${nginx_pkg_name} ]]; then
    echo_log "Could not get nginx package name"
    exit 1
  fi

  amazon-linux-extras install ${nginx_pkg_name} -y |& tee -a $log
  if [[ ${PIPESTATUS[0]} -ne 0 ]] ; then
    echo_log "Failed to install ${nginx_pkg_name}"
    exit 1
  fi
}

configure_landing_page() {
  echo_log "Configuring landing page"

  if ! echo "Hello from bootstrap!" > /usr/share/nginx/html/index.html 2>> ${log}; then
    echo_log "Failed to configure landing page"
    exit 1
  fi
}

configure_nginx_service() {
  echo_log "Configuring Nginx service"

  if ! systemctl start nginx &>> ${log}; then
    echo_log "Failed to start nginx service"
    exit 1
  fi

  if ! systemctl enable nginx &>> ${log}; then
    echo_log "Failed to enable nginx service"
    exit 1
  fi
}

test_landing_page() {
  if ! command -v curl &> /dev/null; then
    echo_log "Skipping landing page test"
    return 0
  fi
  
  echo_log "Testing landing page"
  if ! curl -s localhost |grep -q "Hello from bootstrap"; then
    echo "Landing page test failed"
    exit 1
  fi
}

main