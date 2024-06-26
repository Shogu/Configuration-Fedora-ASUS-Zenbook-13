#!/bin/bash

# Chemin vers l'extension d'origine
original_extension=~/.local/share/gnome-shell/extensions/custom-command-toggle@storageb.github.com

# Répertoire où seront créées les nouvelles extensions
extensions_dir=~/.local/share/gnome-shell/extensions

# Numéro de l'extension à créer
extension_number=5

# Chemin vers la nouvelle extension
new_extension="${extensions_dir}/custom-command-toggle${extension_number}@storageb.github.com"

# Copier l'extension d'origine vers la nouvelle extension
cp -r "$original_extension" "$new_extension"

# Modifier le fichier metadata.json
metadata_file="${new_extension}/metadata.json"
sed -i 's/"settings-schema": ".*"/"settings-schema": "org.gnome.shell.extensions.custom-command-toggle'${extension_number}'"/' "$metadata_file"
sed -i 's/"uuid": ".*"/"uuid": "custom-command-toggle'${extension_number}'@storageb.github.com"/' "$metadata_file"
sed -i 's/"name": ".*"/"name": "Custom Command Toggle '${extension_number}'"/' "$metadata_file"

# Renommer et modifier le fichier gschema.xml
schemas_folder="${new_extension}/schemas"
mv "${schemas_folder}"/*.xml "${schemas_folder}/org.gnome.shell.extensions.custom-command-toggle${extension_number}.gschema.xml"
xml_file="${schemas_folder}/org.gnome.shell.extensions.custom-command-toggle${extension_number}.gschema.xml"
sed -i 's/<schema id=".*" path="\/org\/gnome\/shell\/extensions\/.*\/">/<schema id="org.gnome.shell.extensions.custom-command-toggle'${extension_number}'" path="\/org\/gnome\/shell\/extensions\/custom-command-toggle'${extension_number}'\/">/' "$xml_file"

# Supprimer le fichier gschemas.compiled s'il existe
compiled_file="${schemas_folder}/gschemas.compiled"
if [ -f "$compiled_file" ]; then
  rm "$compiled_file"
fi

# Compiler les schemas gsettings
cd "$new_extension"
glib-compile-schemas schemas

echo "Extension custom-command-toggle${extension_number}@storageb.github.com configurée avec succès."

# Redémarrer la session
echo "Veuillez vous déconnecter et vous reconnecter, ou redémarrer votre système."

exit 0

