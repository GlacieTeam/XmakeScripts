rule("python")
on_config(function(target)
    local include_cmd = "python -c \"import sysconfig; print(sysconfig.get_path('include'))\""
    local lib_cmd_unix = "python -c \"import sysconfig; print(sysconfig.get_config_var('LIBDIR'))\""
    local lib_cmd_win32 = "python -c \"import sysconfig; print(sysconfig.get_config_var('installed_base') + '\\libs')\""

    local include = os.iorun(include_cmd):sub(1, -2)
    local lib = os.iorun(lib_cmd_unix):sub(1, -2)
    if is_plat("windows") then
        lib = os.iorun(lib_cmd_win32):sub(1, -2)
    end
    local version = os.iorun("python --version"):sub(1, -2)
    target:add("includedirs", include)
    target:add("linkdirs", lib)
    cprint("${bright green}[Python]:${reset} include: " .. include)
    cprint("${bright green}[Python]:${reset} lib: " .. lib)
    cprint("${bright green}[Python]:${reset} version: " .. version)
end)
rule_end()
