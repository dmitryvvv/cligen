#!/usr/bin/env bash
# CLI rest 

# Magic line must be first in script (see README.md)
s="$_" ; . ./lib.sh || if [ "$s" = $0 ]; then exit 0; else return 0; fi

fspec=$dir/spec.cli

cat > $fspec <<EOF
  prompt="cli> ";              # Assignment of prompt
  comment="#";                 # Same comment as in syntax
  treename="tutorial";         # Name of syntax (used when referencing)

  # Expand example
  values {
    <x:rest>,callback(); 
    aa,callback(); 
  }

EOF

new "$cligen_file -f $fspec"

new "cligen values aa command"
expectpart "$(echo "values aa" | $cligen_file -f $fspec 2>&1)" 0 "1 name:values type:string value:values" "2 name:aa type:string value:aa"

# DOESNT WORK - DIDNT WORK in 4.4 either phew
#new "cligen values aa bb rest"
#expectpart "$(echo "values aa bb" | $cligen_file -f $fspec 2>&1)" 0 "1 name:values type:string value:values" "2 name:x type:rest value:aa bb"

new "cligen values aab rest"
expectpart "$(echo "values aab" | $cligen_file -f $fspec 2>&1)" 0 "1 name:values type:string value:values" "2 name:x type:rest value:aab"

new "cligen values aab foo rest"
expectpart "$(echo "values aab cde" | $cligen_file -f $fspec 2>&1)" 0 "1 name:values type:string value:values" "2 name:x type:rest value:aab cde"

rm -rf $dir
