# Redmine Legal Notes

> Provide legal notes about your Redmine service

Redmine Legal Notes is a plugin for Redmine users legally bounded to display
a legal notice or data privacy policy.

## Getting Started

This quick introduction shows you the most convenient way for trying out the
plugin with your Redmine instance.

### Downloading the plugin directory from GitHub

```bash
cd (REDMINE_ROOT_DIR)/plugins
git clone https://github.com/xmera-circle/redmine_legal_notes.git
```

Navigate into the plugins directory.

Download the latest development state as _redmine_legal_notes_ folder
into your plugin directory.

### Restart Redmine

```bash
cd (REDMINE_ROOT_DIR)/tmp
touch restart.txt

```

Navigate into the tmp directoy.

Touch restart.txt in order to force Redmine's web server to restart and loading
everything from scratch in order to register the new plugin.

## Initial Configuration

You should now be able to see the plugin list in Administration -> Plugins
and configure the newly installed plugin.

For doing so, click on configure right beside the plugin version number.
