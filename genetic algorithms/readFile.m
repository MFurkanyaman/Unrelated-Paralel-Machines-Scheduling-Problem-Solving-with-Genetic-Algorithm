%{
 Makinelerin işleri yapma süreleri
p = [
    1 87 28 32 38 9;
    4 21 68 17 43 48
];

 Makinelerin setup süreleri
s = {
    [0 1 8 1 3 9; 4 0 7 3 7 8; 7 3 0 2 3 5; 3 8 3 0 5 2; 8 3 7 9 0 5; 8 8 1 2 2 0]
    [0 5 1 6 1 7; 6 0 7 7 6 2; 7 6 0 9 6 9; 3 7 3 0 1 7; 5 8 5 6 0 9; 7 4 1 7 9 0]
};    
%}

function [p, s, is_sayisi, makine_sayisi] = readFile(dosya_yolu)
    % Dosyayı aç
    dosya = fopen(dosya_yolu, 'r');
    
    if dosya == -1
        error('Dosya açılamadı: %s', dosya_yolu);
    end
    
    % Dosya içeriğini hücre dizisine oku
    % "Delimiter" satır satır okur.
    dosya_icerik = textscan(dosya, '%s', 'Delimiter', '\n');
    dosya_icerik = dosya_icerik{1};
    % Matrislerin başlangıç satırını belirle
    [is_sayisi, makine_sayisi, ~] = strread(dosya_icerik{1}, '%d %d %d');
     % Calisma sureleri matrisini al
    p = zeros(makine_sayisi, is_sayisi); % Satır sayısı: makine sayısı, Sütun sayısı: iş sayısı
   for i = 1:is_sayisi
    sayac = 1;
    satir_verisi = strsplit(dosya_icerik{i+2}, ' '); % Satırı boşluğa göre ayır
    satir_verisi = cellfun(@str2double, satir_verisi); % String değerleri double'a çevir
    satir_no = 1;
    for j = 1:makine_sayisi*2
       
        if mod(sayac, 2) == 0
            p(satir_no, i) = satir_verisi(sayac);
            satir_no = satir_no + 1; 
        end
        sayac = sayac + 1;
    end
end

    matris_baslangic_satiri = find(strcmp(dosya_icerik, 'SSD'));
    
    a = 0;
     % 2x1 hücre dizisi oluşturma
    s = cell(makine_sayisi, 1);

    for i = 1:makine_sayisi
     matris_verisi = zeros(is_sayisi, is_sayisi); 
        for j = 1:is_sayisi + 1
            try
             satir_verisi = dosya_icerik{matris_baslangic_satiri+j + 1};  
              satir_verisi = strsplit(satir_verisi, ' ');
              satir_verisi = cellfun(@str2double, satir_verisi);
               if any(isnan(satir_verisi))
               continue;
               end
               
             % Satır verisini matrisin ilgili satırına ekle
               matris_verisi(j, :) = satir_verisi(1:is_sayisi);
               
                    
              
                % matris_baslangic_satiri = matris_baslangic_satiri + 1;
            catch
            continue
            end
            
        end
        s{i}= matris_verisi;
        matris_adi = ['M' num2str(i-1)];
        eval(['ana_struct.' matris_adi ' = matris_verisi;']);
        %makine_is_setup_struct.(['M' num2str(a)]) = matris_verisi;
        matris_baslangic_satiri =  matris_baslangic_satiri + is_sayisi +1;
        a = a + 1;
        disp("---------------------------");
    end
    % Dosyayı kapat
    fclose(dosya);

end
