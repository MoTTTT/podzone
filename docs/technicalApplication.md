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

### Zope

- Initial install of Plone, provides Zope 4, which is not backward compatable with the Zope 2 applications, so use a legacy zope image.
- Legacy Zope image selected: `robcast/legacy-zope:2.13`

- Zope volume mounts: ./var/filestorage; ./var/blobstorage; ./products

### Postgres

- nfs not working for postgres volume, issues with chmod (as with OpenSearch)
- Use cluster-internal db GUI tool to avoid requirement to provide ingress for a database port.
