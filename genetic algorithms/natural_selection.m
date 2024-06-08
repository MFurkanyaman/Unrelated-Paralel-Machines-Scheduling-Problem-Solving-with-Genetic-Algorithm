function [ns_pop] = natural_selection(population, obj, p_size)
    obj = 1 ./ obj; % Amaç fonksiyonu değerini tersine çevir.
    sumobj = sum(obj); % Amaç fonksiyonlarının toplam değerini bul.

    probs = obj / sumobj; % Olasılıkları hesapla.

    % Birikimli kümülatif olasılık değerlerini bul.
    cprobs = probs;

    % Kümülatif hesaplama
    for i = 2:p_size
        cprobs(i) = cprobs(i-1) + probs(i);
    end
    ns_pop = cell(p_size, 1)
    % Hayatta kalanı seç.
    rs = unifrnd(0, 1, [p_size, 1]); % Rastgele bir sayı oluştur.
    % arapop = population; % Yeni popülasyon için hücre dizisi.

    for i = 1:p_size
        idx = find(rs(i) < cprobs, 1); % rs cprobs'tan küçük olduğu ilk indeksi bul.
        % arapop{i+p_size} = population{idx}; % Yeni popülasyona bireyi ekle.
        ns_pop{i} = population{idx}




    end
end
