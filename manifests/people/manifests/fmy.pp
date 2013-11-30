# manifests/people/manifests/fmy.pp
class people::fmy {
  include chrome
  include dropbox
  include iterm2::stable
  include alfred
  include mplayerx
  include osxfuse
  include istatmenus3
  include sublime_text_2
  include keyremap4macbook

  include keyremap4macbook::login_item

  package {
    [
      "tmux",
      "tree",
      "nkf",
      "rbenv",
      "tig"
    ]
  }

  $home     = "/Users/${::boxen_user}"
  $dotfiles = "${home}/.dotfiles"

  file { $home:
      ensure  => directory
    }

    # git clone git@github.com:fmy/dotfiles.git
    repository { $dotfiles:
      source  => 'fmy/dotfiles',
      require => File[$home]
    }

    # git-cloneしたら install.sh を走らせる
    exec { "sh ${dotfiles}/install.sh":
      cwd => $dotfiles,
      creates => "${home}/.zshrc",
      require => Repository[$dotfiles],
    }

}