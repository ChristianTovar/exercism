#include "rna_transcription.h"

namespace rna_transcription
{
    char to_rna(char nucleotide)
    {
        if (nucleotide == 'C')
            return 'G';
        if (nucleotide == 'G')
            return 'C';
        if (nucleotide == 'A')
            return 'U';
        if (nucleotide == 'T')
            return 'A';

        return 0;
    }

    std::string to_rna(std::string nucleotides)
    {
        std::string complement = "";

        for (char n : nucleotides)
        {
            complement += to_rna(n);
        }

        return complement;
    }
} // namespace rna_transcription
