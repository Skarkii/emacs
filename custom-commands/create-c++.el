(defun init-c++-project ()
  "Initialize a new C++ project."
  (interactive)
  (let ((project-name (read-string "Enter the project name: ")))

     (with-temp-file "CMakeLists.txt"
     (insert (format "cmake_minimum_required(VERSION 3.22)\nproject(%s)\n\nset(SOURCES\n" project-name))

(let ((base-directory "."))
  (dolist (file (directory-files-recursively base-directory "\\.cpp$"))
    (let ((relative-path (file-relative-name file base-directory)))
      ;; Skip files in the "./build/" directory and its subdirectories
      (unless (string-prefix-p "build/" relative-path)
        (insert (format "\t%s\n" relative-path))))))

     (insert ")\n\nset(HEADERS")

(let ((base-directory "."))
  (dolist (file (directory-files-recursively base-directory "\\.h$"))
    (let ((relative-path (file-relative-name file base-directory)))
      ;; Skip files in the "./build/" directory and its subdirectories
      (unless (string-prefix-p "build/" relative-path)
        (insert (format "\t%s\n" relative-path))))))

     (insert ")\n\n")

     (insert "add_executable(${PROJECT_NAME} ${SOURCES} ${HEADERS})\n\n")

     (insert "target_include_directories(${PROJECT_NAME} PRIVATE src include)\n\n")

     (insert "if (CMAKE_CXX_COPMPILER_ID MATCHES \"GNU|Clang\")\n\ttarget_compile_options(${PROJECT_NAME} PRIVATE -Wall -Wextra)\nendif()\n\n")

     (insert "set(CMAKE_EXPORT_COMPILE_COMMANDS ON)\n")
     
     )
     )

  (let ((base-directory "."))
      (unless (file-exists-p "build")
        (make-directory "build")))


  ;;(async-shell-command "cmake -Bbuild -S. -DCMAKE_EXPORT_COMPILE_COMMANDS=ON")

  (let ((base-directory "."))
      (unless (file-exists-p ".clang-format")
        (let ((format-command "clang-format -style=llvm -dump-config > .clang-format"))
  (shell-command format-command (generate-new-buffer "*Clang-Format Output*")))))

	
  (let ((compile-command "cmake -Bbuild -S. -DCMAKE_EXPORT_COMPILE_COMMANDS=ON"))
  (shell-command compile-command (generate-new-buffer "*CMake Output*")))
  
(lsp-workspace-folders-add ".")

(with-temp-file "./makefile"
  (insert "MAKEFLAGS += --no-print-directory\n\ndef:\n\tcmake --build build\n"))

  (let ((compile-command "make -k"))
  (shell-command compile-command (generate-new-buffer "*Make Output*")))
  

     )
    
