(let [hibiscus-path (.. (vim.fn.stdpath :data) :/site/pack/packer/start/hibiscus.nvim)
      tangerine-path (.. (vim.fn.stdpath :data) :/site/pack/packer/start/tangerine.nvim)]
  (lambda bootstrap [url path]
    (when (not (vim.loop.fs_stat path))
      (vim.fn.system [:git
                      :clone
                      url
                      path]))
    (vim.opt.rtp:prepend path))

  (bootstrap "https://github.com/udayvir-singh/tangerine.nvim.git" tangerine-path)
  (bootstrap "https://github.com/udayvir-singh/hibiscus.nvim.git" hibiscus-path)

  (let [tangerine (require :tangerine)
        setup tangerine.setup]
    (setup {:target (.. (vim.fn.stdpath :data) :/tangerine)
            :compiler {:verbose false
            :hooks [:onsave
                    :oninit]}
            :custom [[(.. (vim.fn.stdpath :config) :/ftplugin)
                      (.. (vim.fn.stdpath :data) :/site/ftplugin)]]})))
