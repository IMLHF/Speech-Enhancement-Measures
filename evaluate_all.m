% get CSIG, CBAK, CVOL, PESQ, SegSNR from two dir list
% [CSIG, CBAK, CVOL, PESQ, SegSNR] = evaluate_all(ref_dir, deg_dir)

function [Csig, Cbak, Cvol, pesq, SNR, SegSNR] = evaluate_all(ref_dir, deg_dir)
    ref_folder = dir(fullfile(ref_dir,'*.wav'));
    deg_folder = dir(fullfile(deg_dir,'*.wav'));
    ref_names = {ref_folder.name};
    deg_names = {deg_folder.name};
    ref_names = sort(ref_names);
    deg_names = sort(deg_names);
    disp(ref_names(1:5));
    disp(deg_names(1:5));
    n_refs = length(ref_names);
    n_degs = length(deg_names);
    assert(n_refs == n_degs, 'n_refs != n_degs');
    csigs = zeros(1, n_refs);
    cbaks = zeros(1, n_refs);
    cvols = zeros(1, n_refs);
    pesqs = zeros(1, n_refs);
    snrs = zeros(1, n_refs);
    segsnrs = zeros(1,n_refs);
    for idx = 1:n_refs
        ref_names(idx) = strcat(ref_dir, '/', ref_names(idx));
        deg_names(idx) = strcat(deg_dir, '/', deg_names(idx));
        % disp(ref_names(idx));
        % disp(deg_names(idx));
        ref_file = char(ref_names(idx));
        deg_file = char(deg_names(idx));
        [csig, cbak, cvol] = composite(ref_file, deg_file);
        pesq_ = comp_pesq(ref_file, deg_file);
        [snr, segsnr] = comp_snr(ref_file, deg_file);
        csigs(idx) = csig;
        cbaks(idx) = cbak;
        cvols(idx) = cvol;
        pesqs(idx) = pesq_(1);
        snrs(idx) = snr;
        segsnrs(idx) = segsnr;
        % disp(strcat(ref_names(idx),'\n'))
        fprintf('\n idx=%d  csig=%f  cbak=%f  cvol=%f  pesq=%f   snr=%f   ssnr=%f\n',idx,csig,cbak,cvol,pesq_(1),snr,segsnr);
    end;

    Csig = mean(csigs);
    Cbak = mean(cbaks);
    Cvol = mean(cvols);
    pesq = mean(pesqs);
    SNR = mean(snrs);
    SegSNR = mean(segsnrs); 
end
