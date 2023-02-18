until (curl -sfL https://get.k3s.io | sh -); do
  echo 'Waiting for k3s installation'
  sleep 3
done

until kubectl get pods -A | grep 'Running';
do
  echo 'Waiting for k3s to initialize'
  sleep 5
done
