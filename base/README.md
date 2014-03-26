base Cookbook
=============

Install system common and required packages. Manage server installed rubies and rubygems.

Attributes
----------

#### base::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['rbenv']['install_prefix']</tt></td>
    <td>String</td>
    <td>Rbenv install path.</td>
    <td><tt>/usr/local</tt></td>
  </tr>
  <tr>
    <td><tt>['rbenv']['install_ruby']</tt></td>
    <td>Array</td>
    <td>Install one or multiple version rubies if not exist.</td>
    <td><tt>1.9.3-p448</tt></td>
  </tr>
  <tr>
    <td><tt>['rbenv']['global_ruby']</tt></td>
    <td>String</td>
    <td>Sets the global version of Ruby to be used in all shells.</td>
    <td><tt>1.9.3-p448</tt></td>
  </tr>
  <tr>
    <td><tt>['rbenv']['extra_gems']</tt></td>
    <td>Hash</td>
    <td>Install gems if specify on node attributes.</td>
    <td><tt></tt></td>
  </tr>
</table>
