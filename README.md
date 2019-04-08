# AWS CLI Dockerfile

# Description

Docker image containing the aws cli inside, based on [Alpine linux](https://hub.docker.com/_/alpine/).


Docker Hub: https://hub.docker.com/r/camilbradea/aws-cli-docker/

GitHub: https://github.com/bradeac/aws-cli-docker

# Motivation

* No official aws-cli docker image
* Available aws-cli docker images expect one AWS CLI command as a parameter. After the command is being executed, the container is stopped. For each AWS CLI command, a new container is created. 
* Using this image, you can pass a script, which enables you to do more complex stuff, without the need to start a container for each AWS CLI command.

# AWS CLI Version
* Latest 1.xx.xx 

# Build

```
docker build -t image-name:version .
```

# Run

```
docker run -it --rm \
	--name container-name \
	# mounting a volume is optional. Might be a good idea if you have some AWS Lambda functions code that you want to deploy
	-v ${PWD}:/mount-location \
	-e AWS_ACCESS_KEY_ID="AWS_ACCESS_KEY_ID_GOES_HERE" \
	-e AWS_DEFAULT_REGION="AWS_DEFAULT_REGION_GOES_HERE" \
	-e AWS_SECRET_ACCESS_KEY="AWS_SECRET_ACCESS_KEY_GOES_HERE" \
	image-name:version \
	ash /path/to/script/to/be/run/on/container/startup.sh 
	# see example of script below
```

# Example of usage in ash script (updating AWS Lambda function code)

```
cd path/to/lambdas
$LAMBDAS=$(ls)

for filename in $LAMBDAS
do
	fileBaseName="$(basename "$filename" .js)"
	functionName="lambda_cognito_"$fileBaseName

	zip $fileBaseName.zip $filename

	aws lambda update-function-configuration --function-name $functionName --handler $fileBaseName".handler"
	aws lambda update-function-code --function-name $functionName --zip-file "fileb://"$zipName

	rm $zipName
done
```

## AWS CLI documentation
* http://docs.aws.amazon.com/cli/latest/index.html