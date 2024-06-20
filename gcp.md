```bash
# Solves the issue no access to staging bucket
gcloud projects add-iam-policy-binding PROJECT_NAME --member="serviceAccount:PROJECT_NUMBER.iam.gserviceaccount.com" --role="roles/cloudbuild.builds.builder"

gcloud projects get-iam-policy PROJECT_NAME
gsutil iam get gs://<bucket>

gcloud app deploy
gcloud app deploy --service-account=<service_account>
gcloud app logs tail -s default
```

## Setting up cors for cloud storage

https://cloud.google.com/storage/docs/cors-configurations

```bash
gcloud storage buckets update gs://<bucket> --cors-file=example_cors_file.json
```

JSON:
```json
[
    {
      "origin": [
        "http://localhost:8080",
        "http://localhost"
      ],
      "method": ["GET", "PUT", "POST", "HEAD"],
      "responseHeader": ["Content-Type"],
      "maxAgeSeconds": 3600
    }
]
```
