    if [ -x /usr/libexec/sdgtools/sdg_report_pre ]; then
        /usr/libexec/sdgtools/sdg_report_pre \
            --name %{name} --version %{version} --release %{release} $*;
    fi;
