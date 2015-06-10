# Build byte code.
python setup.py install -O1 --root=$RPM_BUILD_ROOT --record=INSTALLED_FILES

#######################################################################
# Remove all .py files
######################################################################

# Delete source code (.py files) except those in the include_py_files
find $RPM_BUILD_ROOT -name '*.py' -print0 | grep -zvFf setup/include_py_files | xargs -0 rm

# Remove all lines ending in .py from the file INSTALLED_FILES
sed -i '/\.py$/d' INSTALLED_FILES
cat setup/include_py_files >> INSTALLED_FILES

#######################################################################
# Create symlink to django/contrib/admin, etc.
######################################################################

PREFIX=`python -c 'import ConfigParser;p = ConfigParser.ConfigParser();p.read("setup.cfg");print p.get("install", "prefix")'`
BUILD_PREFIX=$RPM_BUILD_ROOT$PREFIX

# create link to Django admin static data (css, etc.)
mkdir -p $BUILD_PREFIX/static
ln -s %{python_sitelib}/django/contrib/admin/static/admin $BUILD_PREFIX/static
echo $PREFIX/static >> INSTALLED_FILES

ln -s $PREFIX/polls/static/polls $BUILD_PREFIX/static
echo $PREFIX/static/polls >> INSTALLED_FILES

#######################################################################
# Add macro's to %files section of rpm .spec file.
######################################################################

# Add directories so they will be managed by rpm. If not added empty
# directories are left after performing rpm --uninstall
find $BUILD_PREFIX -mindepth 1 -type d | sed "s:$RPM_BUILD_ROOT:%dir :" >> INSTALLED_FILES

# This file contains additional macros that should be added to the %files
# section of an RPM spec file.
FILES_CONFIG="setup/files_config"

if [ -e $FILES_CONFIG ]
then
    cat $FILES_CONFIG >> INSTALLED_FILES
fi
