# OpenAI

This repository is to create a docker image that contains 
useful scripts to connect OpenAI. 

## Usage

docker run -it --rm -e OPENAI_API_KEY=<Yourkey> kartaltabak/openai <command>

where command is one of the below:

```
create-image.sh <filename.png> "TEXT"
```

Example: 
```
create-image.sh image.png "A cute baby sea otter"
```
