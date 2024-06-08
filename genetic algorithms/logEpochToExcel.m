function logEpochToExcel(epoch)
    % .mat dosyasını yükle
    matFile = sprintf('resultlog_epoch_%d.mat', epoch);
    if exist(matFile, 'file')
        loadedData = load(matFile);
        data = loadedData.data;
        
        % Makespan değerini çıkar (son satırın son elemanı)
        makespan = data(end, end);
        
        % Excel dosyasını oku
        excelFile = ['I_150_10_S_1-99_9_', '.xlsx'];
        if exist(excelFile, 'file')
            % Excel dosyasını aç ve mevcut verileri oku
            [~, ~, raw] = xlsread(excelFile);
            
            % Excel dosyasındaki mevcut satır sayısını belirle
            nextRow = size(raw, 1) + 1;
            
            % Epoch ve makespan verilerini Excel dosyasına yaz
            xlswrite(excelFile, {epoch, makespan}, 1, sprintf('A%d', nextRow));
            
            fprintf('Veriler başarıyla Excel dosyasına yazıldı.\n');
        else
            % Eğer Excel dosyası yoksa, yeni bir dosya oluştur ve başlıkları yaz
            xlswrite(excelFile, {'epoch', 'makespan'}, 1, 'A1');
            xlswrite(excelFile, {epoch, makespan}, 1, 'A2');
            
            fprintf('Yeni Excel dosyası oluşturuldu ve veriler yazıldı.\n');
        end
    else
        fprintf('MAT dosyası bulunamadı.\n');
    end
end


