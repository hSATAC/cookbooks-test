include_recipe "percona"
include_recipe "percona::server"

package "zabbix-server-mysql"
package "zabbix-frontend-php"