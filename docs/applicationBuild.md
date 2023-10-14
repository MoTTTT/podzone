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

- Persistent storage for data: add `/srv/nfs/db` to nfs exports
- Persistend storage for import / export / backup:  add `/srv/nfs/backup` to nfs exports
- Use cluster-internal db GUI tool to avoid requirement to provide ingress
- 
