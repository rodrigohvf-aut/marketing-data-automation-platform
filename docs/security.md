# Security boundaries

- Keep `.env`, password files, sync configuration, private keys, certificates, dumps, logs, and runtime dashboard configuration outside Git.
- Use separate credentials for dashboard authentication, workflow execution, databases, and external providers.
- Apply least privilege and review row-level or schema-level policies before exposing tenant-scoped data.
- Store only synthetic data in local examples.
- Rotate secrets after exposure or ownership changes.
- Validate Compose configuration and workflow changes before deployment.
- Avoid broad cleanup commands until Docker resources and backup targets are inventoried.
