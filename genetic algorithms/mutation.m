function [new_child_pop] = mutation(child_pop, pmutation, p_size, d, num_machines)
    % pmutation: mutasyon olma olasılığı
    % arapop: doğal seçilimden sonra oluşan popülasyon
    % p_size: popülasyon büyüklüğü
    % d: kromozom boyutu (iş sayısı)
    % num_machines: makine sayısı

    % Mutasyon kararları için rastgele sayılar oluştur
    rs = unifrnd(0, 1, [length(child_pop), d]); % Rastgele sayıların satır sayısı popülasyon büyüklüğü kadar, sütun sayısı kromozom boyutu kadar
    len = length(child_pop);
    
    % Yeni popülasyonun uzunluğunu tutacak bir hücre dizisi oluşturun
    new_child_pop = cell(p_size, 1);
    added_count = 0;

    for i = 1:len
        control = 0;
        child = double(zeros(2, d));
        
        % İlk mutasyon işlemi: makine numaraları
        for j = 1:d
            child(2, j) = child_pop{i}(2, j);
            if (rs(i, j) < pmutation)
                control = 1;
                % Makine numarasını değiştir
                currentMachine = child_pop{i}(2, j); % Mevcut makine numarasını al
                newMachine = currentMachine;
                while newMachine == currentMachine
                    newMachine = randi([1, num_machines]); % Farklı bir makine numarası seç
                end
                child(2, j) = newMachine;
                fprintf('%d. kromozomda %d. indexten itibaren makine numarası %d oldu.\n', i, j, newMachine);
            end
        end

        % İş kimlikleri mutasyonu
        child(1, :) = child_pop{i}(1, :); % Orijinal iş kimliklerini aktar
        if unifrnd(0, 1) < pmutation
            control = 1;
            % Rastgele bir indexten itibaren iş kimliklerini yer değiştir
            swapIndex = randi([1, d-1]); % En az iki eleman olması için 1 ile d-1 arasında bir index seç
            jobIDs = child_pop{i}(1, :);
            child(1, :) = [jobIDs(1:swapIndex-1), fliplr(jobIDs(swapIndex:end))];
            fprintf('%d. kromozomda %d. indexten itibaren işler mutasyona uğradı.\n', i, swapIndex);
        end

        % Eğer mutasyon olduysa yeni kromozomu ekleyin
        if control == 1 && added_count < p_size
            new_child_pop{added_count + 1} = child;
            added_count = added_count + 1;
        elseif control == 0 && added_count < p_size
            new_child_pop{added_count + 1} = child_pop{i};
            added_count = added_count + 1;
        end
    end
    
end
