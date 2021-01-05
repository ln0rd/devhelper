import os
import logging
import pymysql
import boto3
from datetime import datetime, timedelta

host  = os.getenv('DB_HOST')
db_port = int(os.getenv('DB_PORT'))
user = os.getenv('DB_USER')
password = os.getenv('DB_PASS')
db_name = os.getenv('DB_NAME')

logger = logging.getLogger()
logger.setLevel(logging.INFO)

def lambda_handler(event, context):
    client = boto3.client('batch')

    jobDefName = os.getenv('JOB_DEF_NAME')

    jobsList = client.describe_job_definitions(
        jobDefinitionName=jobDefName,
        status='ACTIVE'
    )

    actualRevision = jobsList['jobDefinitions'][0]['revision']

    logger.info('Executing ' + jobDefName + ' last revision: ' + str(actualRevision))

    date = datetime.strftime(datetime.now() - timedelta(1), '%Y-%m-%d')
    query = "select external_id from preprocessed_accounts"

    event_account_example = event.get('account_example')
    if event_account_example:
        query = query + " where example_id = '"+event_account_example+"'"

    event_date = event.get('date')
    if event_date:
        date = event_date

    try:
        conn = pymysql.connect(host, port=db_port, user=user, passwd=password, db=db_name, connect_timeout=15)

        with conn.cursor() as cur:
            cur.execute(query)
            cur.close()
            for row in cur:
                account_example = row[0]
                
                response = client.submit_job(
                    jobName=jobDefName,
                    jobQueue=os.getenv('JOB_QUEUE'),
                    jobDefinition=jobDefName + ':' + str(actualRevision),
                    parameters={
                        'account': '{0}'.format(account_example),
                        'eventsDate': date
                    }
                )
                logger.info(response)

        conn.close()
    except Exception as err:
        logger.error('Error processing reconciliation: {0}'.format(err))

    return "Done"
