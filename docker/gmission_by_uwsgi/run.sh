#!/bin/sh

cp /usr/share/zoneinfo/Asia/Hong_Kong /etc/localtime

cd /GMission-Server/services

export C_FORCE_ROOT="true"
celery -A push_msg.task worker >>../logs/celery.log 2>&1 &


cd /GMission-Server/services/cron_jobs
python task.py &


cd /GMission-Server/hkust-gmission
python db_util.py  &&  uwsgi --ini ../docker/gmission_by_uwsgi/uwsgi.ini
