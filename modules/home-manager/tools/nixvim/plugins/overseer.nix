{ ... }:
{
  programs.nixvim = {
    plugins.overseer.enable = true;

    keymaps = [
      { mode = "n"; key = "<Leader>ot"; action = "<cmd>OverseerToggle<CR>"; options.desc = "Toggle task list"; }
      { mode = "n"; key = "<Leader>or"; action = "<cmd>OverseerRun<CR>"; options.desc = "Run task"; }
      { mode = "n"; key = "<Leader>oc"; action = "<cmd>OverseerRunCmd<CR>"; options.desc = "Run shell command"; }
      { mode = "n"; key = "<Leader>ob"; action = "<cmd>OverseerBuild<CR>"; options.desc = "Build task"; }
      { mode = "n"; key = "<Leader>oq"; action = "<cmd>OverseerQuickAction<CR>"; options.desc = "Quick action (recent task)"; }
      { mode = "n"; key = "<Leader>oa"; action = "<cmd>OverseerTaskAction<CR>"; options.desc = "Task action"; }
    ];
  };
}
