docker service ls --format='{{ .Name}},{{ .Replicas}}' --filter MODE=replicated > services.txt
##Scale down:
for service in `cut -f 1 -d, services.txt`; do docker service scale $service=0; done
##Scale up:
for line in `cat services.txt`
do
        service=$(echo "$line" | cut -f 1 -d",")
        replicas=$(echo $line | cut -f 2 -d"," | cut -f 2 -d'/')
        echo $service - $replicas
        docker service scale $service=$replicas
done
