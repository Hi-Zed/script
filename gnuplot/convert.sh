for f in *.eps; do
  convert -density 300 ./"$f" ./"${f%.eps}.png"
done
