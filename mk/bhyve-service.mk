DATA_DIR = ${CBSD_WORKDIR}/jails-data/${SERVICE}-data
BASE_DATA_DIR = ${CBSD_WORKDIR}/jails-data/${IMAGE}-data

up: ${DATA_DIR}
	@sudo cbsd bstart jname=${SERVICE} || true
	@echo "Waiting for VM to boot"
	@sudo reggae ssh-ping ${SERVICE}
.if !exists(.provisioned)
	@${MAKE} ${MAKEFLAGS} provision
.endif

provision: ${DATA_DIR}
	@touch .provisioned

down: ${DATA_DIR}
	@sudo cbsd bstop ${SERVICE} || true

destroy:
	@rm -f .provisioned
	@sudo cbsd bremove ${SERVICE}
.for provisioner in ${PROVISIONERS}
	@${MAKE} ${MAKEFLAGS} clean-${provisioner}
.endfor

${DATA_DIR}: ${BASE_DATA_DIR}
	@sudo cbsd bclone old=${IMAGE} new=${SERVICE}
	@sudo cbsd bset jname=${SERVICE} astart=0
	@sudo cbsd bstart jname=${SERVICE}
	@echo "Waiting for VM to boot"
	@sudo reggae ssh-ping ${SERVICE}
	@sudo reggae ssh provision ${SERVICE} sudo sysrc hostname=${SERVICE}.${DOMAIN}
	@sudo reggae ssh provision ${SERVICE} sudo hostname ${SERVICE}.${DOMAIN}

${BASE_DATA_DIR}:
	@rm -rf /tmp/${IMAGE}.img
	@fetch ${BASE_URL}/${IMAGE}.img -o /tmp/${IMAGE}.img
	@sudo reggae import /tmp/${IMAGE}.img
	@rm -rf /tmp/${IMAGE}.img

login:
	@sudo reggae ssh provision ${SERVICE}

exec:
	@sudo reggae ssh provision ${SERVICE} ${command}

export: down
.if !exists(build)
	@mkdir build
.endif
	@sudo cbsd bexport jname=${SERVICE}
	@echo "Moving ${SERVICE}.img to build dir ..."
	@sudo mv ${CBSD_WORKDIR}/export/${SERVICE}.img build/
	@echo "Chowning ${SERVICE}.img to ${UID}:${GID} ..."
	@sudo chown ${UID}:${GID} build/${SERVICE}.img

devel: up
	@sudo reggae ssh devel ${SERVICE} /usr/src/bin/devel.sh