from Bio.Blast import NCBIWWW, NCBIXML
from Bio import Entrez, SeqIO
import os

Entrez.email = "c..."  # Replace with your email

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
output_file = r"C: ...\data_raw\FAP_BLAST.fas"
SeqIO.write(records, output_file, "fasta")
print(f"Saved {len(records)} sequences to {output_file}.")
