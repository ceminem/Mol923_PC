from Bio.Blast import NCBIWWW, NCBIXML
from Bio import Entrez, SeqIO
import os

import sys
from modulefinder import ModuleFinder
import pkg_resources

# Find imports in your script
finder = ModuleFinder()
finder.run_script('"C:\Users\cemin\Documents\Molbio\Master\bioinformatics\Mol923\mol923\python\Python script using Biopython.py"')  # Replace with your file

used_packages = set()
for name, mod in finder.modules.items():
    if mod and mod.__file__ and 'site-packages' in mod.__file__:
        used_packages.add(name.split('.')[0])

# Print only used packages with versions
for pkg_name in sorted(used_packages):
    try:
        version = pkg_resources.get_distribution(pkg_name).version
        print(f"{pkg_name}=={version}")
    except pkg_resources.DistributionNotFound:
        print(f"{pkg_name}  # not installed")


Entrez.email = "mobofo3315@feralrex.com"  #  A tempt mail was used. Works as well. 

# Create output directory if needed
os.makedirs("data_raw", exist_ok=True)

# 1. Run BLASTp for XP_001703004
result_handle = NCBIWWW.qblast("blastp", "nr", "XP_001703004", hitlist_size=25)
blast_records = NCBIXML.read(result_handle)

# 2. Collect accession IDs from hits
accessions = []
for alignment in blast_records.alignments:
    # Extract accession (remove version)
    acc = alignment.accession.split('.')[0]
    if acc not in accessions:
        accessions.append(acc)
    if len(accessions) >= 25:
        break

print(f"Found {len(accessions)} accessions.")

# 3. Fetch sequences in FASTA format
handle = Entrez.efetch(db="protein", id=",".join(accessions), rettype="fasta", retmode="text")
records = list(SeqIO.parse(handle, "fasta"))

# 4. Save to file
output_file = r"C:\Users\cemin\Documents\Molbio\Master\bioinformatics\Mol923\mol923\data_raw\FAP_BLAST.fas"
SeqIO.write(records, output_file, "fasta")
print(f"Saved {len(records)} sequences to {output_file}.")

