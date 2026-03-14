import os

# 要忽略的文件夹（不遍历它们）
IGNORE_DIRS = {'node_modules', '.git', 'target', '.idea', 'dist', '__pycache__', 'shuiyue.git', 'shuiyue'}

# 要忽略的文件后缀（二进制、图片、压缩包等）
IGNORE_EXTS = {
    '.jpg', '.jpeg', '.png', '.gif', '.ico', '.svg', '.webp',
    '.jar', '.class', '.exe', '.dll', '.so',
    '.zip', '.tar', '.gz', '.rar',
    '.pdf', '.doc', '.docx', '.xls', '.xlsx',
    '.idx', '.pack', '.rev', '.sample', '.iml'
}

OUTPUT_FILE = 'project_all_code.txt'

def is_valid_file(filename):
    ext = os.path.splitext(filename)[1].lower()
    return ext not in IGNORE_EXTS

def pack_project():
    with open(OUTPUT_FILE, 'w', encoding='utf-8') as outfile:
        for root, dirs, files in os.walk('.'):
            # 过滤不需要的目录
            dirs[:] = [d for d in dirs if d not in IGNORE_DIRS]

            for file in files:
                # 过滤掉不需要的文件和输出文件本身、脚本本身
                if not is_valid_file(file) or file in [OUTPUT_FILE, 'pack_code.py']:
                    continue
                
                file_path = os.path.join(root, file)
                
                try:
                    with open(file_path, 'r', encoding='utf-8') as infile:
                        content = infile.read()
                        
                    outfile.write(f"\n\n{'='*20} {file_path} {'='*20}\n\n")
                    outfile.write(content)
                except Exception as e:
                    # 如果遇到无法用 utf-8 读取的特殊文件，直接跳过
                    print(f"Skipping file {file_path} due to read error: {e}")

    print(f"✅ 打包成功！全部代码已保存到 {OUTPUT_FILE}")

if __name__ == '__main__':
    pack_project()