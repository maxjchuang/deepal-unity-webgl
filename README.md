# Deepal Unity WebGL

基于 Unity 2023.1.17f1 的独立 3D 车库复现项目，包含 23 个车型变体、6 组环境资源、原资源导入器、GPU shader 移植和网页交互。代码保存在 Git 仓库，大型模型、纹理及可运行网页通过 GitHub Release 提供。

该项目独立于 Deepal 官方应用。车控仅操作本地三维模型，不连接真实车辆或用户账号。

## 下载并运行

前往 [v0.1.0 发布页](https://github.com/maxjchuang/deepal-unity-webgl/releases/tag/v0.1.0)，下载 `deepal-unity-web-v0.1.0.zip` 并解压。进入 `deepal_unity_s07_web` 目录后运行：

```sh
python3 -m http.server 8769 --bind 127.0.0.1
```

打开 http://127.0.0.1:8769/ 。需要支持 WebGL 2 和 WebAssembly 的浏览器；不能通过 file 协议直接打开 index.html。首次加载主引擎，切车按需加载对应车型和环境 bundle。

## 功能

- 23 个车型在同一 Unity 实例中异步切换，加载失败保留当前车型。
- 四门、四窗、尾门、常亮车灯、寻车闪灯与实际存在的车型配件。
- 原车漆、内饰和轮毂材质预设，以及充电口与能量场景。
- 五座和六座空调资源、座椅与方向盘加热／通风显示。
- 16 个相机预设、拖动旋转、滚轮或双指缩放、中键或双指平移。默认相机的平移受原生零尺寸边界限制。
- 原 HDR atlas、SH、天空、时段、主题、雨雪粒子与碰撞面。
- Bloom、Uber、Sharpen、Copy、FXAA 与 overlay 后处理。

## 从源码构建

安装 Unity **2023.1.17f1** 与 WebGL Build Support，克隆仓库：

```sh
git clone https://github.com/maxjchuang/deepal-unity-webgl.git
cd deepal-unity-webgl
python3 tools/fetch_resources.py
python3 build_web.py --unity /path/to/Unity
```

macOS Unity 的路径通常形如 `/Applications/Unity/Hub/Editor/2023.1.17f1/Unity.app/Contents/MacOS/Unity`。脚本依次执行原资源导入、29 个 AssetBundle 构建、WebGL 主程序构建，输出到 `Builds/S07DiagnosticWeb`。首次导入需要较长时间。

资源下载脚本固定版本并验证 SHA-256。也可以从 Release 手动下载 `deepal-unity-resources-v0.1.0.zip`，运行 `python3 tools/fetch_resources.py --archive /path/to/archive.zip` 导入。已有完整本地恢复项目时，可用 `python3 tools/prepare_local_resources.py --source /path/to/local/recovery-project` 接入。

## 目录

- `Assets/Editor`：资源导入、车型绑定与构建流程。
- `Assets/*.cs`：车型、灯光、相机、天气及场景运行代码。
- `Assets/Recovered*Shaders`：恢复的 shader 程序。
- `Assets/Plugins/WebGL`：Unity 到网页的状态事件。
- `ShaderReferences` 等目录：GPU 程序参考。
- `WebHost/index.html`：响应式车库操作界面。
- `tools`：资源接入和下载脚本。
- `resources.json`：固定版本资源下载地址、大小和校验值。
- `verification.json`：功能验证范围和已知边界。

## 验证和已知边界

23 个车型加载通过，四门、四窗、尾门共 207 项动作收到实际 Unity 完成回调；代表车型的相机、材质、充电及手机尺寸也完成检查。功能矩阵通过不等于逐像素完全一致：所有车型×视角×天气尚未完成严格逐像素认证；S05 bent 数据的 CPU 映射仍待确认，连续时间与完整 App 生命周期尚未穷尽验证。

S09 与 S09_6s 实际原生标志均为六座。原空调相机 FOV=6.68° 本身只拍到前两排，网页保留同样取景。L06 C2L 的原尾翼变换对象为空，该控件禁用。网页控件采用响应式布局。

## 资源说明

完整资源按项目提供者确认的公开分发授权发布。资源包包含模型、纹理、材质、环境与场景依赖，不包含原 APK、DEX、IL2CPP 库、用户账号数据或会话日志。Unity 引擎、Deepal 品牌和原应用资源的权属分别归其权利人所有；本项目没有将第三方资源重新声明为 MIT 等通用开源授权。

仅用于交流学习用途，请勿商用
