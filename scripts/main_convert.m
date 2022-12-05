clear;
clc;



% rg_info
rg_info_new = struct('assembly','GRCh38.primary_assembly','source','GENCODE',...
                     'path','NA',...
                     'url','https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_42/GRCh38.primary_assembly.genome.fa.gz',...
                     'script','NA','make_version','NA',...
                     'maker','YD','date','11-08-2022');
                 
% cyto

pathin = 'cyto.txt';
fidin = fopen(pathin);

bufnum = 2000;
cyto_new(bufnum) = struct('chr','','chrn',0,'name','','start',0,...
                        'end',0,'stain','');

fgetl(fidin);
numrlt = 0;
ct_prt = 0;
while ~feof(fidin)
    s = fgetl(fidin);
    S = regexp(s,'\t','split');
    
    chr = char(S(1));
    chrn = str2double(char(S(2)));
    name = char(S(3));
    start = str2double(char(S(4)));
    end2 = str2double(char(S(5)));
    stain = char(S(6));
    
    numrlt = numrlt+1;
    
    if numrlt>bufnum
        bufnum = bufnum+2000;
        cyto_new(bufnum) = struct('chr','','chrn',0,'name','','start',0,...
                                'end',0,'stain','');
    end
    
    cyto_new(numrlt).chr = chr;
    cyto_new(numrlt).chrn = chrn;
    cyto_new(numrlt).name = name;
    cyto_new(numrlt).start = start;
    cyto_new(numrlt).end = end2;
    cyto_new(numrlt).stain = stain;
    
    if rem(numrlt,200)==0
        for j=1:ct_prt
            fprintf('\b');
        end
        ct_prt = fprintf('%i..',numrlt);
    end
    
end

cyto_new(numrlt+1:end)=[];

fclose('all');



% rg

pathin = 'rg.txt';
fidin = fopen(pathin);

bufnum = 2000;
rg_new(bufnum) = struct('refseq','','gene','','symb','','locus_id',0,...
                        'chr','','strand',0,'start',0,'end',0,...
                        'cds_start',0,'cds_end',0,'status','','chrn',0);

fgetl(fidin);
numrlt = 0;
ct_prt = 0;
while ~feof(fidin)
    s = fgetl(fidin);
    S = regexp(s,'\t','split');
    
    refseq = char(S(1));
    gene = char(S(2));
    symb = char(S(3));
    locus_id = int32(str2double(char(S(4))));
    chr = char(S(5));
    strand = str2double(char(S(6)));
    start = int32(str2double(char(S(7))));
    end2 = int32(str2double(char(S(8))));
    cds_start = int32(str2double(char(S(9))));
    cds_end = int32(str2double(char(S(10))));
    status = char(S(11));
    chrn = str2double(char(S(12)));
    
    numrlt = numrlt+1;
    
    if numrlt>bufnum
        bufnum = bufnum+2000;
        rg_new(bufnum) = struct('refseq','','gene','','symb','','locus_id',0,...
                                'chr','','strand',0,'start',0,'end',0,...
                                'cds_start',0,'cds_end',0,'status','','chrn',0);
    end
    
    rg_new(numrlt).refseq = refseq;
    rg_new(numrlt).gene = gene;
    rg_new(numrlt).symb = symb;
    rg_new(numrlt).locus_id = locus_id;
    rg_new(numrlt).chr = chr;
    rg_new(numrlt).strand = strand;
    rg_new(numrlt).start = start;
    rg_new(numrlt).end = end2;
    rg_new(numrlt).cds_start = cds_start;
    rg_new(numrlt).cds_end = cds_end;
    rg_new(numrlt).status = status;
    rg_new(numrlt).chrn = chrn;
    
    if rem(numrlt,200)==0
        for j=1:ct_prt
            fprintf('\b');
        end
        ct_prt = fprintf('%i..',numrlt);
    end
    
end

rg_new(numrlt+1:end)=[];

fclose('all');


rg_info = rg_info_new;
rg = rg_new;
cyto = cyto_new;

save 'GENCODE.V42.basic.CHR.no.chrM.mat' rg_info
save 'GENCODE.V42.basic.CHR.no.chrM.mat' rg -append
save 'GENCODE.V42.basic.CHR.no.chrM.mat' cyto -append
test = load('GENCODE.V42.basic.CHR.no.chrM.mat');



