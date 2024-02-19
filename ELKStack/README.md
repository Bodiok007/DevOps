# ELK Stack

## Structure

1. [Infrustructure](Infrustructure) - contains terraform files to create AWS resources and inventory for Ansible.
2. [Ansible](Ansible) - installs ELK Stack on web server and web client.

## Workflow

1. Apply [Infrustructure](Infrustructure) as described [here](../TerraformIntro/ReadmeTerraformIntro.md).

This will create `inventory` file with two sections and related host configurations:
- `[monitoring]` - centralized server for monitoring
- `[app]` - app (client) server which will send metrics to `[monitoring]` server

2. Run [elk-monitoring-playbook](Ansible/elk-monitoring-playbook.yml).
```
ansible-playbook elk-monitoring-playbook.yml \
    -i inventory \
    --diff
```

It setups centrilized server with:
- `ElasticSearch` - to store and search data
- `Logstash` - to collect data and send it to `ElasticSearch`
- `Kibana` - to visualize data

3. Run [elk-client-playbook](Ansible/elk-client-playbook.yml)
```
ansible-playbook elk-client-playbook.yml \
    -i inventory \
    --diff
```
This will define variable `monitoring_group_hosts` whick is used in templates for `filebeat` and `metricbeat` configurations:
- [filebeat](Ansible/roles/elk-client/templates/etc/filebeat/filebeat.yml.j2) - is used for log data shipping
- [metricbeat](Ansible/roles/elk-client/templates/etc/metricbeat/metricbeat.yml.j2) - is used for shipping system and application metrics

## Results
Kibana with logs should be available on <ip>:5601 where you can configure dashboard.
![Kibana](Screenshots/Dashboard)

## Notes

1. To check ansible without real applying needs to add parameter:
```
--check
```
2. To display more verbose output needs to add parameter:
```
--vvv
```
