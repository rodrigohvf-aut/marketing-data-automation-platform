# Integration boundaries

The original project connected analytics, advertising, social, CRM, database, AI, object-storage, workflow, and version-control services.

For a safe public portfolio, this repository documents categories and data-flow responsibilities only. A private adaptation should define for each integration:

- purpose and owner;
- least-privilege authentication method;
- workflow and retry policy;
- destination tables or API contract;
- pagination and rate-limit behavior;
- error handling and observability;
- credential rotation procedure.

Never put account IDs, webhook URLs, access tokens, user exports, or real campaign data in Git.
