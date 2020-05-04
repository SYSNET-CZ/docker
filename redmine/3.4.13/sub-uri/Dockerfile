FROM sysnetcz/redmine:3.4.13-passenger
COPY passenger-nginx-config-template.erb /passenger-nginx-config-template.erb
CMD ["passenger", "start", "--nginx-config-template", "/passenger-nginx-config-template.erb"]
