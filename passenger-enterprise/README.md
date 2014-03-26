passenger-enterprise Cookbook
=============================

Install passenger-enterprise gem and generate license.

Requirements
------------

#### cookbooks
- `nginx`
- `apache2`

Attributes
----------

#### passenger-enterprise::default
* [Nginx Guide](http://www.modrails.com/documentation/Users%20guide%20Nginx.html)
* [Apache Guide](http://www.modrails.com/documentation/Users%20guide%20Apache.html)

Recipes
-------

- `default` - Install passeng-enterprise gem from cookbook files. And put our purchased license key.
- `nginx` - Compile passenger-enterprise module for nginx.
- `apache` - Compile passenger-enterprise module for ManageBac apache with REE 1.8.7 GC params wrapper.


Usage
-----

#### passenger-enterprise::nginx

Specify use engerprise passenger in nginx attributes. Will include `passenger-enterprise` and `passenger-enterprise::nginx` in nginx cookbook passenger recipe. Otherwise will install open source passenger from rubygems.

```json
:nginx => {
  :passenger => {
    :enterprise => true
  }
}
```

#### passenger-enterprise::apache

Include `passenger-enterprise::apache` in your node's `run_list` and specify version number.

```json
:apache => {
  :passenger => {
    :version => "3.0.19"
  }
}
```
