    if [ -x /usr/libexec/sdgtools/sdg_report_preun ]; then
        /usr/libexec/sdgtools/sdg_report_preun \
            --name %{name} --version %{version} --release %{release} $*;
    fi;
