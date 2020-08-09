from typing import Dict, Any
import boto3
import os


def handler(event: Dict[str, Any], context: Any) -> None:
    """
    This handler operates two AWS Batch jobs sequentially. 
    Dependency is JobA <- jobB 
    """
    client = boto3.client("batch")

    job_a = client.submit_job(
        jobName="submit_job_a",
        jobQueue=os.getenv("BATCH_JOB_QUEUE"),
        jobDefinition=os.getenv("BATCH_JOB_A_DEFINITION"))
    print("JobA Submitted: ", job_a)

    job_b = client.submit_job(
        jobName="submit_job_b",
        jobQueue=os.getenv("BATCH_JOB_QUEUE"),
        jobDefinition=os.getenv("BATCH_JOB_B_DEFINITION"),
        dependsOn=[{
            "jobId": job_a["jobId"]
        }])
    print("JobB Sumitted: ", job_b)
