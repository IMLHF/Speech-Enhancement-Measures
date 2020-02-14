% get CSIG, CBAK, CVOL, PESQ, SegSNR from two dir list

function [Csig, Cbak, Cvol, pesq, SNR, SegSNR] = evaluate_all(ref_dir, deg_dir)
    ref_folder = dir(fullfile(ref_dir,'*.wav'));
    deg_folder = dir(fullfile(deg_dir,'*.wav'));
    ref_names = [ref_folder.name];
    deg_names = [deg_folder.name];
    ref_names = sort(ref_names)
    deg_names = sort(deg_names)
    disp(ref_names(1:5))
    disp(deg_names(1:5))
    n_refs = length(ref_names)
    n_degs = length(deg_names)
    assert(n_refs == n_degs, 'n_refs != n_degs')
    csigs = zeros(n_refs)
    cbaks = zeros(n_refs)
    cvols = zeros(n_refs)
    pesqs = zeros(n_refs)
    snrs = zeros(n_refs)
    segsnrs = zeros(n_refs)
    for idx = 1:n_refs
        ref_names(idx) = strcat(ref_dir, '/', ref_names(idx))
        deg_names(idx) = strcat(deg_dir, '/', deg_names(idx))
        [csig, cbak, cvol] = composite(ref_names(idx), deg_names(idx))
        [pesq, pesq_2] = pesq(ref_names(idx), deg_names(idx))
        [snr, segsnr] = comp_snr(ref_names(idx), deg_names(idx))
        csigs(idx) = csig
        cbaks(idx) = cbak
        cvols(idx) = cvol
        pesqs(idx) = pesq
        snrs(idx) = snr
        segsnrs(idx) = segsnr
        disp(idx)
    end
    disp(ref_names(1))
    disp(deg_names(1))

    Csig = mean(csigs)
    Cbak = mean(cbaks)
    Cvol = mean(cvols)
    pesq = mean(pesqs)
    SNR = mean(snrs)
    SegSNR = mean(segsnrs) 
end
