until (curl -sfL https://get.k3s.io | K3S_URL=https://myserver:6443 K3S_TOKEN=mynodetoken sh -); do
  echo 'Waiting for k3s installation'
  sleep 3
done
