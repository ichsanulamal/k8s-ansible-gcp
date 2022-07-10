ansible-playbook -i hosts initial.yml
ansible-playbook -i hosts kube-dependencies.yml
ansible-playbook -i hosts control-plane.yml
ansible-playbook -i hosts workers.yml