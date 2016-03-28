# == Class: cygwin_git_encrypt
#
# Puppet module to setup shadowhand/git-encrypt in CygWin environment
#
# === Parameters
#
# === Variables
#
# === Examples
#
#  class { 'cygwin_git_encrypt': }
#
# === Authors
#
# st01tkh <st01tkh@gmail.com>
#
# === Copyright
#
# Copyright 2016 st01tkh
#
class cygwin_git_encrypt {
  if ($operatingsystem == 'windows') {
      $cygwinroot = get_cygwin_root()
      if ($cygwinroot) {
          $sysroot = env("SYSTEMROOT")
          $sys32 = file_join_win(["${sysroot}", "System32"])
	  $sysdrive = env("SYSTEMDRIVE")
          $pfiles_dir = file_join_win(["${sysdrive}", "Program Files", ])
          $pfiles_x86_dir = file_join_win(["${sysdrive}", "Program Files (x86)", ])
          $gitroot = file_join_win(["${pfiles_dir}", "Git"])
          $gitroot_x86 = file_join_win(["${pfiles_x86_dir}", "Git"])
	  if exists($gitroot) {
	  } elsif exists($gitroot_x86) {
            $gitroot = $gitroot_x86
          } else {
            fail {"Git is not installed": }
          }
          $git_bin_dir = file_join_win(["${gitroot}", "bin"])
          notify {"git bin dir: ${git_bin_dir}": }
          $git_bash = file_join_win(["${git_bin_dir}", "bash.exe"])
          notify {"git bash: ${git_bash}": }
          $cygwin_vendor = file_join_win(["${cygwinroot}", "vendor"])
          $cygwin_gitcrypt = file_join_win(["${cygwin_vendor}", "git-encrypt"])
          $cygwin_bin = file_join_win(["${cygwinroot}", "bin"])
          $cygwin_bash = file_join_win(["${cygwin_bin}", "bash.exe"])
          file {"${cygwin_vendor}": ensure => 'directory' } ->
          file {"${cygwin_gitcrypt}": ensure => 'directory' } ->
          vcsrepo { "${cygwin_gitcrypt}":
            ensure   => present,
            provider => git,
            source   => 'https://github.com/shadowhand/git-encrypt',
            revision => 'legacy',
          } ->
          #exec {'cygwin_git_clone_or_pull-git-encrypt':
          #  path => ["$sysroot", "$sys32", "${cygwin_bin}", ],
          #  cwd => "${cygwin_vendor}",
          #  command => "${cygwin_bash} -c \"[ -e git-encrypt/.git/config ] && cd git-encrypt && /usr/bin/git pull && cd .. || /usr/bin/git clone -c core.eol=lf -b legacy https://github.com/shadowhand/git-encrypt.git; exit 0\"",
          #} ->
          exec {'cygwin_dos2unix_eol':
            path => ["$sysroot", "$sys32", "${cygwin_bin}", ],
            cwd => "${cygwin_vendor}",
            command => "${cygwin_bash} -c \"cd git-encrypt && sed -i 's/^M$//' *\"",
          } ->
          exec {'create_git-encrypt_main_symlink':
            path => ["$sysroot", "$sys32", "${cygwin_bin}", ],
            cwd => "${cygwin_vendor}",
            command => 'bash.exe -c "[ -L /usr/local/bin/gitcrypt ] && ln -sf /usr/local/bin/gitcrypt && rm /usr/local/bin/gitcrypt; ln -s /vendor/git-encrypt/gitcrypt /usr/local/bin/gitcrypt; exit 0"',
          }
      } else {
          notify {"cygwin root does not exist": }
      }
  } else {
      notify {"$operatingsystem is not supported": }
  }
}
