# Define: apache::dotconf
#
# General Apache define to be used to create generic custom .conf files 
# Very simple wrapper to a normal file type
# Use source or template to define the source
#
# Usage:
# apache::dotconf { "sarg": source => 'puppet://$servername/sarg/sarg.conf' }
# or
# apache::dotconf { "trac": content => 'template("trac/apache.conf.erb")' }
#
define apache::dotconf ( $source='' , $content='' ) {

    include apache
# Silly if statement to manage source|content 
# TODO To be optimized

if $source  { 

    file { "Apache_$name.conf":
        mode    => "${apache::params::configfile_mode}",
        owner   => "${apache::params::configfile_owner}",
        group   => "${apache::params::configfile_group}",
        require => Package["apache"],
        ensure  => present,
        path    => "${apache::params::dotconfdir}/$name.conf",
        notify  => Service["apache"],
        source  => $source,
    }

} # End if source 


if $content  { 

    file { "Apache_$name.conf":
        mode    => "${apache::params::configfile_mode}",
        owner   => "${apache::params::configfile_owner}",
        group   => "${apache::params::configfile_group}",
        require => Package["apache"],
        ensure  => present,
        path    => "${apache::params::dotconfdir}/$name.conf",
        notify  => Service["apache"],
        content => $content,
    }

} # End if content

}
