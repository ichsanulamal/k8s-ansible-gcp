while IFS=, read -r name ip; 
do     
    echo "$name ansible_host=$ip";     
    find hosts -type f -exec sed -i "s/$name ansible_host= ansible_user=amal/$name ansible_host=$ip ansible_user=amal/g" {} \;
done < ip.csv

# apply
kubectl apply -f 1-web-profile-deployment/petclinic/
kubectl apply -f 1-web-profile-deployment/wordpress/
kubectl delete -f 1-web-profile-deployment/wordpress/

kubectl apply -f 3-file-sharing/ -R
kubectl apply -f 4-meeting-application/
kubectl apply -f 2-monitoring/


docker run --name some-drupal -p 8080:80 -d drupal:8.3.7-apache
docker run -d --name some-postgres \
	-e POSTGRES_DB=drupal \
	-e POSTGRES_USER=user \
	-e POSTGRES_PASSWORD=pass \
    -p 5432:5432 \
postgres:10.1