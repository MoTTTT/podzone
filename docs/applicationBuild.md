# Application Build

## Requirement

### Platform requirement

- Zope Python based Application server
- Python Postgress driver
- Zope Postgres driver wrapper
- Postgress Database
- Database GUI

### Data take-on

- Postgress export from legacy implementation
- Import into new Postgress instance

## Implementation

### Postgres

- nfs not working for postgres volume, issues with chmod (as with OpenSearch)
- Use cluster-internal db GUI tool to avoid requirement to provide ingress for a database port.
