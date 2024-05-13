echo "the scheduler will wait"

# wait for database to initialize
sleep 120

echo "starting the scheduler"

# start scheduler
airflow scheduler