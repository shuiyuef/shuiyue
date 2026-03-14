import os

# 需要排除的文件夹（避免把依赖包也打进去，那会撑爆 AI 的内存）
EXCLUDE_DIRS = {'.git', 'node_modules', 'target', '.idea', '.vscode', '__pycache__', 'dist', 'build'}
# 允许读取的文件后缀
ALLOWED_EXTENSIONS = {'.java', '.py', '.js', '.vue', '.html', '.css', '.sql', '.xml', '.yml', '.yaml', '.properties'}

def pack_project(root_dir, output_file):
    with open(output_file, 'w', encoding='utf-8') as f:
        for root, dirs, files in os.walk(root_dir):
            # 排除不需要的目录
            dirs[:] = [d for d in dirs if d not in EXCLUDE_DIRS]
            
            for file in files:
                if any(file.endswith(ext) for ext in ALLOWED_EXTENSIONS):
                    full_path = os.path.join(root, file)
                    rel_path = os.path.relpath(full_path, root_dir)
                    
                    f.write(f"\n\n--- FILE: {rel_path} ---\n")
                    try:
                        with open(full_path, 'r', encoding='utf-8') as code_f:
                            f.write(code_f.read())
                    except Exception as e:
                        f.write(f"Error reading file: {e}")

if __name__ == "__main__":
    print("🚀 正在打包代码，请稍候...")
    pack_project('.', 'project_all_code.txt')
    print("✅ 打包完成！请查看目录下的 project_all_code.txt")