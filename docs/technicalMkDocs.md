# mkdocs

## Generating Swagger UI

- Install plugin: `pip3 install mkdocs-swagger-ui-tag`
- Declare Plugin in `mkdocs.yml`:

```yaml
- plugins:
   - swagger-ui-tag
```

- Invoke this in an .md markdown document using the form: `<swagger-ui src="SWAGGER_URI"/>`

For example: `<swagger-ui src="https://petstore.swagger.io/v2/swagger.json"/>`

## Example implementation:

- URL: `https://gateway.telkom.co.za/cons-po/swagger_docs/apiSpecification.json`
- Embedded resource invocation: `<swagger-ui src="swagger.json"/>
`

### Embedded resource result

<swagger-ui src="swagger.json"/>

## References

- <https://github.com/blueswen/mkdocs-swagger-ui-tag>
