openapply Cookbook
==================

This cookbook manage OpenApply websites related configs.

Recipes
-------

- public - Setup http://openapply.com and maintenance page nginx config.
- blog - Setup http://blog.openapply.com and nginx config.
- rails - OpenApply rails application server environment and configs.
- monit - Use monit monitoring delayed_job and redis. Prevent processes dead.
- production-db-backup - Backup OpenApply production db to AWS S3. Use backup gem.
- ssl-certificate - Generate *.openapply.com wildcard ssl certificate key files on server for nginx 443 https protocol.

Requirements
------------

#### cookbooks
- `projects`
- `nginx`
- `monit`

Attributes
----------

#### openapply::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['openapply']['environment']</tt></td>
    <td>String</td>
    <td>Specify rails environment.</td>
    <td><tt>development</tt></td>
  </tr>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['openapply']['ssl_certificate_path']</tt></td>
    <td>String</td>
    <td>Specify ssl key install path.</td>
    <td><tt>/opt/ssl-certificate/openapply</tt></td>
  </tr>
</table>
