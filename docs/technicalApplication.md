# Implementation Notes

## Zope

- Initial install of Plone, provides Zope 4, which is not backward compatable with the Zope 2 applications, so use a legacy zope image.
- Legacy Zope image selected: `robcast/legacy-zope:2.13`

- Zope volume mounts: ./var/filestorage; ./var/blobstorage; ./products

