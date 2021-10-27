#!/bin/bash

echo $'\nCreating project ' $1 $'\n'

if ! command -v mockgen &> /dev/null
then
    echo 'Tool mockgen could not be found - installing.'
    go install github.com/golang/mock/mockgen@v1.6.0
fi

echo 'Found mockgen in PATH.'
echo $'To create mocks for domain and ports just useg "go generate ./..." in root of the project\n'

mkdir -p $1/cmd/httpsrv \
    $1/internal/core/domain \
    $1/internal/core/ports \
    $1/internal/core/services/exservice \
    $1/internal/handlers/exhandler \
    $1/internal/stores/exstore \
    $1/mocks \
    $1/pkg

touch $1/internal/core/domain/domain.go
echo '// Package domain implements structs modelling the domain entities and value objects.' >> $1/internal/core/domain/domain.go
echo $'package domain\n' >> $1/internal/core/domain/domain.go
echo '//go:generate mockgen -source=./domain.go -package=mocks -destination=../../../mocks/mock_domain.go' >> $1/internal/core/domain/domain.go
touch $1/internal/core/domain/domain_test.go

touch $1/internal/core/ports/ports.go
echo '// Package ports implements interfaces modelling the core ports.' >> $1/internal/core/ports/ports.go
echo $'package ports\n' >> $1/internal/core/ports/ports.go
echo '//go:generate mockgen -source=./ports.go -package=mocks -destination=../../../mocks/mock_ports.go' >> $1/internal/core/ports/ports.go
touch $1/internal/core/ports/ports_test.go

touch $1/internal/core/services/exservice/exservice.go
echo '// a place for service implementing the corresponding port' >> $1/internal/services/exservice/exservice.go
echo '// eg. external api service, domain entity service' >> $1/internal/services/exservice/exservice.go
touch $1/internal/core/services/exservice/exservice_test.go

touch $1/internal/handlers/exhandler/exhandler.go
echo '// a place for driver adapter' >> $1/internal/handlers/exhandler/exhandler.go
echo '// eg. cli interface or http interface' >> $1/internal/handlers/exhandler/exhandler.go
touch $1/internal/handlers/exhandler/exhandler_test.go

touch $1/internal/stores/exstore/exstore.go
echo '// a place for driven adapter' >> $1/internal/stores/exstore/exstore.go
echo '// eg. postgresql database' >> $1/internal/stores/exstore/exstore.go
touch $1/internal/stores/exstore/exstore_test.go

cd $1
go mod init $1

git init
touch .gitignore

cp $HOME/Scripts/gofiles/.vimspector.json .
cp $HOME/Scripts/gofiles/Dockerfile .
cp $HOME/Scripts/gofiles/docker-compose.yml .

echo $'\nPlease have a look at the example Dockerfile and docker-compose.yml.'
echo $'Please also change the path-to-entrypoint in .vimspector.json\n'

read -p 'Is the project for private use? (y/n) ' private

if [ $private == 'y' ]
then
    echo 'Enjoy your new project ;)'
    exit 0
fi

if ! command -v aws-pipelines &> /dev/null
then
    echo 'Tool aws-pipelines could not be found - installing.'
    npm i -g @aurajs/npm-aws-pipelines
fi

aws-pipelines

echo $'\nRemember to check the generated aws files - pay particular attention to app entrypoint.'
