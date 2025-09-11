{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./latex.nix
    ./options.nix
    ./languages.nix
    ./bufferline.nix
    ./oil.nix
  ];

  programs.nvf = {
    enable = true;

    settings = {
      vim.navigation.harpoon = {
        enable = true;
        mappings = {
          file1 = "<leader>1";
          file2 = "<leader>2";
          file3 = "<leader>3";
          file4 = "<leader>4";
        };
      };

      vim.utility.yanky-nvim.enable = true;
      vim.visuals.highlight-undo.enable = true;
      vim.languages.markdown.extensions.markview-nvim.enable = true;
      vim.utility.yanky-nvim.setupOpts.ring.storage = "memory";
      vim.utility.undotree.enable = true;
      vim.utility.yazi-nvim.enable = true;

      # ---------------- Obsidian.nvim ----------------
      vim.notes.obsidian = {
        enable = true;
        setupOpts = {
          ui = {enable = false;};
          preferred_link_style = "markdown";

          workspaces = [
            {
              name = "personal";
              path = "~/projects/pages";
            }
          ];

          note_id_func.__raw = ''
            function(title)
              local suffix = ""
              if title ~= nil then
                suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
              else
                for _ = 1, 4 do
                  suffix = suffix .. string.char(math.random(65, 90))
                end
              end
              return tostring(os.time()) .. "-" .. suffix
            end
          '';

          follow_url_func.__raw = ''
            function(url)
              vim.fn.jobstart({ "xdg-open", url })
            end
          '';
        };
      };

      # ---------------- Neo-tree ----------------
      vim.filetree.neo-tree = {
        enable = true;
        setupOpts = {
          auto_clean_after_session_restore = true;
          close_if_last_window = true;
          default_source = "git_status";

          sources = ["git_status"];

          source_selector = {
            winbar = true;
            content_layout = "center";
            sources = [
              {
                source = "git_status";
                display_name = " Git";
              }
            ];
          };

          default_component_configs = {
            indent = {
              padding = 0;
              indent_size = 1;
            };
            icon = {
              folder_closed = "";
              folder_open = "";
              folder_empty = "";
              default = "";
            };
            modified = {symbol = "●";};
            git_status = {
              symbols = {
                added = "";
                deleted = "";
                modified = "";
                renamed = "➜";
                untracked = "★";
                ignored = "◌";
                unstaged = "✗";
                staged = "✓";
                conflict = "";
              };
            };
          };

          window = {
            position = "right";
            width = 30;
            mappings = {
              "<space>" = null;
              "[b" = "prev_source";
              "]b" = "next_source";
              "o" = "open";
              "O" = "system_open";
              "h" = "parent_or_close";
              "l" = "child_or_open";
              "Y" = "copy_selector";
            };
          };

          filesystem = {
            follow_current_file = {enabled = true;};
            hijack_netrw_behavior = "open_current";
            use_libuv_file_watcher = true;
          };

          event_handlers = [
            {
              event = "neo_tree_buffer_enter";
              handler = lib.generators.mkLuaInline ''
                function(_)
                  vim.opt_local.signcolumn = "auto"
                end
              '';
            }
          ];
        };
      };

      # ---------------- Telescope + Projects ----------------

      vim.projects.project-nvim = {
        enable = true;
        setupOpts = {
          detection_methods = ["lsp" "pattern"]; # use both LSP root and file patterns
          patterns = [".git" "package.json" "flake.nix" "Makefile"]; # adjust to your stack
        };
      };

      vim.telescope = {
        enable = true;
        mappings.findFiles = "<leader>ff";
        mappings.liveGrep = "<leader>fw";
        mappings.findProjects = "<leader>fp"; # Project picker
      };

      # ---------------- other plugins & visuals ----------------
      vim.utility.motion.leap.mappings.leapForwardTo = "s";
      vim.utility.motion.leap.mappings.leapBackwardTo = "S";
      vim.dashboard.alpha.enable = false;
      vim.dashboard.startify.enable = true;
      vim.dashboard.startify.sessionSort = true;
      vim.dashboard.startify.sessionPersistence = true;
      vim.dashboard.startify.changeToVCRoot = true;
      vim.vimAlias = true;

      vim = {
        assistant = {
          copilot.enable = true;
          copilot.setupOpts.suggestion.auto_trigger = true;
          copilot.mappings = {
            suggestion.accept = "<C-s>";
            suggestion.acceptWord = "<C-d>";
          };
          copilot.setupOpts.suggestion.enabled = true;
        };

        visuals.rainbow-delimiters.enable = true;

        terminal.toggleterm = {
          enable = true;
          lazygit.enable = true;
        };

        utility = {
          smart-splits.enable = true;
          motion.leap.enable = true;
        };

        binds.whichKey.enable = true;

        autopairs.nvim-autopairs.enable = true;

        theme = {
          enable = true;
          name = "catppuccin";
          style = "mocha";
          transparent = true;
        };

        autocomplete.blink-cmp = {
          enable = true;
          friendly-snippets.enable = true;
        };

        # ---------------- Lazy plugins ----------------
        lazy.plugins = {
          telescope = {
            package = "telescope";
            cmd = ["Telescope"];
            keys = [
              {
                mode = "n";
                key = "<leader>ff";
                action = "<cmd>Telescope find_files<cr>";
                desc = "Find files";
              }
              {
                mode = "n";
                key = "<leader>fw";
                action = "<cmd>Telescope live_grep<cr>";
                desc = "Live grep";
              }
              {
                mode = "n";
                key = "<leader>fo";
                action = "<cmd>Telescope oldfiles<cr>";
                desc = "Old files";
              }
              # <leader>fp removed here to avoid conflict
            ];
          };

          nvim-treesitter = {
            package = "nvim-treesitter";
            event = ["BufReadPost" "BufNewFile"];
          };

          gitsigns-nvim = {
            package = "gitsigns-nvim";
            event = ["BufReadPre"];
            setupModule = "gitsigns";
            setupOpts = {
              signs = {
                add = {text = "│";};
                change = {text = "│";};
                delete = {text = "󰍵";};
                topdelete = {text = "‾";};
                changedelete = {text = "󱗜";};
                untracked = {text = "│";};
              };
              signcolumn = true;
              linehl = false;
            };
          };

          toggleterm-nvim = {
            package = "toggleterm-nvim";
            cmd = ["ToggleTerm"];
            keys = [
              {
                mode = "n";
                key = "<leader>tg";
                action = "<cmd>ToggleTerm<cr>";
                desc = "Toggle terminal";
              }
            ];
          };
        };

        # ---------------- Keymaps ----------------
        keymaps = [
          {
            mode = "n";
            key = "<leader>fo";
            action = "<cmd>Telescope oldfiles<cr>";
            desc = "Find old files";
          }

          {
            mode = "n";
            key = "<leader>lf";
            action = ":Yazi<cr>";
            desc = "file explorer (yazi)";
          }
          {
            mode = "n";
            key = "<leader>r";
            action = ":Neotree toggle<CR>";
            desc = "NeoT[r]ee Toggle";
          }
          {
            mode = "n";
            key = "<C-h>";
            action = "<cmd>lua require('smart-splits').move_cursor_left()<cr>";
            desc = "Move to left split";
          }
          {
            mode = "n";
            key = "<leader>u";
            action = ":UndotreeToggle<CR>";
            desc = "Undo Tree";
          }
          {
            mode = "n";
            key = "<C-j>";
            action = "<cmd>lua require('smart-splits').move_cursor_down()<cr>";
            desc = "Move to below split";
          }
          {
            mode = "n";
            key = "<C-k>";
            action = "<cmd>lua require('smart-splits').move_cursor_up()<cr>";
            desc = "Move to above split";
          }
          {
            mode = "n";
            key = "<C-l>";
            action = "<cmd>lua require('smart-splits').move_cursor_right()<cr>";
            desc = "Move to right split";
          }
          {
            mode = "n";
            key = "<C-Up>";
            action = "<cmd>lua require('smart-splits').resize_up()<cr>";
            desc = "Resize split up";
          }
          {
            mode = "n";
            key = "<C-Down>";
            action = "<cmd>lua require('smart-splits').resize_down()<cr>";
            desc = "Resize split down";
          }
          {
            mode = "n";
            key = "<C-Left>";
            action = "<cmd>lua require('smart-splits').resize_left()<cr>";
            desc = "Resize split left";
          }
          {
            mode = "n";
            key = "<C-Right>";
            action = "<cmd>lua require('smart-splits').resize_right()<cr>";
            desc = "Resize split right";
          }
          {
            mode = "n";
            key = "|";
            action = "<cmd>vsplit<cr>";
            desc = "Vertical Split";
          }
          {
            mode = "n";
            key = "\\";
            action = "<cmd>split<cr>";
            desc = "Horizontal Split";
          }
          {
            mode = "n";
            key = "<A-j>";
            action = "<cmd>m .+1<cr>==";
            desc = "Move line down";
          }
          {
            mode = "n";
            key = "<A-k>";
            action = "<cmd>m .-2<cr>==";
            desc = "Move line up";
          }
          {
            mode = "i";
            key = "<A-j>";
            action = "<esc><cmd>m .+1<cr>==gi";
            desc = "Move line down (insert)";
          }
          {
            mode = "i";
            key = "<A-k>";
            action = "<esc><cmd>m .-2<cr>==gi";
            desc = "Move line up (insert)";
          }
          {
            mode = "v";
            key = "<A-j>";
            action = ":m '>+1<cr>gv=gv";
            desc = "Move selection down";
          }
          {
            mode = "v";
            key = "<A-k>";
            action = ":m '<-2<cr>gv=gv";
            desc = "Move selection up";
          }
          {
            mode = "n";
            key = "<leader>q";
            action = "<cmd>update<cr><cmd>q<cr>";
            desc = "Save and Quit";
          }

          # ---- Obsidian leader keymaps ----
          {
            mode = "n";
            key = "<leader>on";
            action = "<cmd>ObsidianNew<cr>";
            desc = "Obsidian: New note";
          }
          {
            mode = "n";
            key = "<leader>oi";
            action = "<cmd>ObsidianIndex<cr>";
            desc = "Obsidian: Index";
          }
          {
            mode = "n";
            key = "<leader>ot";
            action = "<cmd>ObsidianToday<cr>";
            desc = "Obsidian: Today";
          }
          {
            mode = "n";
            key = "<leader>oy";
            action = "<cmd>ObsidianYesterday<cr>";
            desc = "Obsidian: Yesterday";
          }
          {
            mode = "n";
            key = "<leader>od";
            action = "<cmd>ObsidianDailies<cr>";
            desc = "Obsidian: Browse dailies";
          }
          {
            mode = "n";
            key = "<leader>os";
            action = "<cmd>ObsidianSearch<cr>";
            desc = "Obsidian: Search";
          }
          {
            mode = "n";
            key = "<leader>oq";
            action = "<cmd>ObsidianQuickSwitch<cr>";
            desc = "Obsidian: Quick switch";
          }
          {
            mode = "n";
            key = "<leader>ow";
            action = "<cmd>ObsidianWorkspace<cr>";
            desc = "Obsidian: Switch workspace";
          }
          {
            mode = "n";
            key = "<leader>ob";
            action = "<cmd>ObsidianBacklinks<cr>";
            desc = "Obsidian: Backlinks";
          }
          {
            mode = "n";
            key = "<leader>op";
            action = "<cmd>ObsidianPasteImg<cr>";
            desc = "Obsidian: Paste image";
          }
        ];
      };
    };
  };
}
