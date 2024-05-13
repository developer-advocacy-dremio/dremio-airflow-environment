from datetime import timedelta
from airflow import DAG
from airflow.operators.python import PythonOperator
from airflow.utils.dates import days_ago

# Define the DAG
dag = DAG(
    'hello_world',
    default_args={
        'owner': 'airflow',
        'depends_on_past': False,
        'email_on_failure': False,
        'email_on_retry': False,
        'retries': 1,
        'retry_delay': timedelta(minutes=5),
    },
    description='A simple hello world DAG',
    schedule_interval='*/1 * * * *',
    start_date=days_ago(0),
    catchup=False,
)

# Define tasks
def print_hello(number):
    print(f"{number} hello")

task1 = PythonOperator(
    task_id='print_1st_hello',
    python_callable=print_hello,
    op_kwargs={'number': '1st'},
    dag=dag,
)

task2 = PythonOperator(
    task_id='print_2nd_hello',
    python_callable=print_hello,
    op_kwargs={'number': '2nd'},
    dag=dag,
)

task3 = PythonOperator(
    task_id='print_3rd_hello',
    python_callable=print_hello,
    op_kwargs={'number': '3rd'},
    dag=dag,
)

task4 = PythonOperator(
    task_id='print_4th_hello',
    python_callable=print_hello,
    op_kwargs={'number': '4th'},
    dag=dag,
)

# Set dependencies
task4.set_upstream(task2)
task4.set_upstream(task3)