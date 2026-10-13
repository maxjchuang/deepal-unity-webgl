# Deepal Unity WebGL

基于 Unity 2023.1.17f1 的独立 3D 车库复现项目，包含 23 个车型变体、6 组环境资源、原资源导入器、GPU shader 移植和网页交互。代码及可运行网页保存在 Git 仓库，完整 Unity 重建资源由接入脚本自动获取。

该项目独立于 Deepal 官方应用。车控仅操作本地三维模型，不连接真实车辆或用户账号。

## 在线体验

打开 [GitHub Pages 车库](https://maxjchuang.github.io/deepal-unity-webgl/) 即可直接操作车模。全部渲染和交互在浏览器中执行，车型资源按需从同一静态站点加载，不需要后端 API。

## 界面预览

以下截图来自在线车库的实际运行画面，示例车型为 S07。

### 车身控制

操作四门、车窗、尾门和灯光，实时查看动作效果。

![S07 车身控制与左前门开启效果](media/screenshots/body-controls.jpg?v=28780d059a)

### 外观与场景

切换车漆、内饰、轮毂、天气和时段；图中展示星辰蓝车漆与傍晚场景。

![S07 星辰蓝车漆与傍晚场景设置](media/screenshots/appearance-scene.jpg?v=3764c880cf)

### 空调座舱

进入座舱视角，控制冷暖风和座椅加热、通风；图中左前座椅为加热 3 档。

![空调座舱与左前座椅加热显示](media/screenshots/air-conditioning.jpg?v=e431ce1172)

### 充电场景

选择左右充电接口及连接状态，查看充电口、线缆和充电场景效果。

![S07 左侧充电口与充电中场景](media/screenshots/charging-scene.jpg?v=9e705ad0a2)

## Clone 后本地运行

仓库 `docs/` 已包含可运行的 Unity WebGL 网页、23 个车型和 6 组环境，不需要安装 Unity 或另行下载资源。

```sh
git clone --depth 1 https://github.com/maxjchuang/deepal-unity-webgl.git
cd deepal-unity-webgl
python3 -m http.server 8769 --bind 127.0.0.1 --directory docs
```

打开 http://127.0.0.1:8769/ 。Python 只提供静态文件服务；场景逻辑在浏览器中运行。需要支持 WebGL 2 和 WebAssembly 的浏览器，不能通过 file 协议直接打开 index.html。首次加载主引擎，切车按需加载对应车型与环境。仓库包含约 540 MB 的已构建网页资源，首次 clone 和加载需要一定时间。

## 加载性能

首次进入 S07 需要约 71 MB 的引擎、车型和环境资源。页面在启动 Unity 时并行预取当前车型及环境，减少引擎启动后继续串行下载的等待；其他车型仍按需加载。

支持 Service Worker 的浏览器会按资源内容哈希缓存引擎和已访问车型，重复进入时直接复用；缓存上限约 160 MiB，优先保留引擎资源。大资源支持分段请求、重试和 SHA-256 校验。浏览器限制存储或不支持缓存时，仍可直接加载静态文件。

这些优化不会降低模型或纹理质量，也不引入后端 API。首次下载总量仍较大，实际耗时取决于访问 GitHub Pages 的网络速度；浏览器清理缓存后需要重新下载。

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

资源下载脚本固定版本并验证 SHA-256。本地已有资源包时，也可运行 `python3 tools/fetch_resources.py --archive /path/to/archive.zip` 导入。已有完整本地恢复项目时，可用 `python3 tools/prepare_local_resources.py --source /path/to/local/recovery-project` 接入。

## 目录

- `Assets/Editor`：资源导入、车型绑定与构建流程。
- `Assets/*.cs`：车型、灯光、相机、天气及场景运行代码。
- `Assets/Recovered*Shaders`：恢复的 shader 程序。
- `Assets/Plugins/WebGL`：Unity 到网页的状态事件。
- `ShaderReferences` 等目录：GPU 程序参考。
- `WebHost/index.html`：响应式车库操作界面源码。
- `docs/`：可直接运行的静态 Unity WebGL 网页及模型 bundle，同时作为 GitHub Pages 发布目录。
- `tools`：资源接入和下载脚本。
- `resources.json`：固定版本资源下载地址、大小和校验值。
- `verification.json`：功能验证范围和已知边界。

## 验证和已知边界

23 个车型加载通过，四门、四窗、尾门共 207 项动作收到实际 Unity 完成回调；代表车型的相机、材质、充电及手机尺寸也完成检查。功能矩阵通过不等于逐像素完全一致：所有车型×视角×天气尚未完成严格逐像素认证；S05 bent 数据的 CPU 映射仍待确认，连续时间与完整 App 生命周期尚未穷尽验证。

S09 与 S09_6s 实际原生标志均为六座。原空调相机 FOV=6.68° 本身只拍到前两排，网页保留同样取景。L06 C2L 的原尾翼变换对象为空，该控件禁用。网页控件采用响应式布局。

## 资源说明

完整资源按项目提供者确认的公开分发授权发布。资源包包含模型、纹理、材质、环境与场景依赖，不包含原 APK、DEX、IL2CPP 库、用户账号数据或会话日志。Unity 引擎、Deepal 品牌和原应用资源的权属分别归其权利人所有；本项目没有将第三方资源重新声明为 MIT 等通用开源授权。

仅用于交流学习用途，请勿商用
