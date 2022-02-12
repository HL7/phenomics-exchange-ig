
The IG for master and PR branches is built and listed as published [here](https://github.com/phenopackets/core-ig/tree/gh-pages) if the Travis build was successful.

## Setup

First install the latest version of sushi
```
 npm install -g fsh-sushi
 ```

 We are currently using version 2.2.0
 ```
$ sushi -v
SUSHI v2.2.0 (implements FHIR Shorthand specification v1.2.0)
 ```

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

Once JSON schema support is enabled in an IDE, the first "discriminator" field that needs to be added to a JSON object that stands for a FHIR resource type to get the schema support for that object type is the "resourceType" field, along with a FHIR Resource type as the value. Auto complete should work if schema support is configured correctly.