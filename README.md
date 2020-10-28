
The IG for master and PR branches is built and listed as published [here](https://github.com/phenopackets/core-ig/tree/gh-pages) if the Travis build was successful.

To get JSON schema support in VS Code, add something like the following to your settings. Look for the "JSON: Schemas" setting and edit the "settings.json" file.

```
"settings": {
    "json.schemas": [
        {
            "fileMatch": [
                "/*/*.json"
            ],
            "url": "http://www.hl7.org/fhir/R4/fhir.schema.json"
        }
    ]
}
```