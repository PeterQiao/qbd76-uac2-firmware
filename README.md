# QBD76 UAC2 Firmware Loader

本仓库提供用于在 macOS（Apple Silicon）上加载 QBD76 UAC2 固件的文件：

- `start_qbd76.sh`：校验文件 SHA-256 后启动加载流程的脚本
- `verified_uac2_release_cb3dbc61.bix`：QBD76 UAC2 固件文件
- `ram_loader`：macOS arm64 RAM 加载器

## 使用

先安装 Homebrew 的 libusb：

```sh
brew install libusb
```

将设备连接到 Mac 后，在本目录执行：

```sh
chmod +x start_qbd76.sh
./start_qbd76.sh
```

脚本会在执行加载前校验加载器和固件的 SHA-256；文件被修改或损坏时会拒绝运行。

## 与 Chord 的关系

本项目是独立的社区工具，与 Chord Electronics Ltd.、Chord 及其关联公司不存在隶属、授权、赞助、代言或其他官方关系。

“Chord”“QBD76”及其他相关名称和标识属于其各自权利人。本仓库仅在必要范围内使用这些名称来说明兼容的设备和用途，不代表任何商标授权或官方支持。

## License

本仓库中由本项目作者原创的脚本、README 及其他文档内容采用 [MIT License](LICENSE) 发布。

固件文件 `verified_uac2_release_cb3dbc61.bix` 与二进制文件 `ram_loader` 的版权、专利、商标及其他权利可能属于原始权利人；除非另有明确书面授权，本仓库不对这些文件授予超出法律允许范围的许可。相关文件按“现状”提供，使用者应自行确认其使用权并承担合规责任。

## 版权或侵权联系

如果你认为本仓库中的任何内容侵犯了你的版权、商标权或其他合法权益，请通过本仓库的 GitHub Issues 联系，说明相关文件、权利依据和联系方式。我们会及时核实；经确认后，将删除或按要求处理相关内容。

