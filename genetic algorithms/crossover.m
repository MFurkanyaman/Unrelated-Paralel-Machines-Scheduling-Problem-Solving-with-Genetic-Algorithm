function [child_pop, crossoverInfo] = crossover(ns_pop, p_size, pcross, d)
    % pcross = çaprazlama olasılığı
    pairs = randperm(p_size); % Popülasyon sayısı kadar rastgele çift ata
    % Mesela çıktı 2 4 3 1 olsun bu şu demek 2 ile 4 bir çift, 3 ile 1 ayrı çift demek.
    
    % Çaprazlama bilgilerini saklamak için hücre dizisi
    crossoverInfo = cell(p_size, 3);

    for i = 1:p_size
        crossoverInfo{i, 1} = i;
        crossoverInfo{i, 2} = i; % Başlangıçta her kromozom kendisi ile eşlenir
        crossoverInfo{i, 3} = NaN; % Başlangıçta çaprazlama noktası yok
    end
    
    % Her çift için rassal sayı ata çaprazlama olasılığı yani
    % Çaprazlama olmayacaksa ebeveynler olduğu gibi kalıp mutasyona sokuluyor.
    % Tek noktalı çaprazlama ve OX çaprazlama
      
    child_pop = cell(p_size, 1);
    sayac = 1;
    for i = 1:p_size/2 % Her çift için
        
        % 1. ebeveyni bul 2. ebeveyni bul
        parent1idx = pairs(2*i-1);
        parent2idx = pairs(2*i);
        parent1 = ns_pop{parent1idx};
        parent2 = ns_pop{parent2idx};
        rs = unifrnd(0, 1); % pcross %95 olsun eğer rs bu değerden küçüksek çaprazlama yapabilirsin.
       
        if(rs < pcross)

            % OX çaprazlama (iş id için)
            [child1_job, cp1, cp2] = OX_crossover(parent1(1, :), parent2(1, :));
            [child2_job, ~, ~] = OX_crossover(parent2(1, :), parent1(1, :));

            % Tek noktalı çaprazlama (makine id için)
            cpoint = unidrnd(d-1); % Çaprazlama noktası seç
            temp_machine1 = parent1(2, :);
            temp_machine2 = parent2(2, :);
            temp_machine1(cpoint+1:end) = parent2(2, cpoint+1:end);
            temp_machine2(cpoint+1:end) = parent1(2, cpoint+1:end);
            
            % Yeni çocuk kromozomlarını oluştur
            child1 = [child1_job; temp_machine1];
            child2 = [child2_job; temp_machine2];
            
            % Yeni çocuk kromozomlarını popülasyona ekle
            child_pop{sayac} = child1;
            child_pop{sayac+1} = child2;
            sayac = sayac + 2;
            
            % Çaprazlama yapılan segmentleri ve sonuçları yazdır
            fprintf('Parent1: %s\n', mat2str(parent1(1, :)));
            fprintf('Parent2: %s\n', mat2str(parent2(1, :)));
            fprintf('Segment [%d, %d] arasında OX çaprazlaması yapıldı\n', cp1, cp2);
            fprintf('Child1: %s\n', mat2str(child1(1, :)));
            fprintf('Child2: %s\n\n', mat2str(child2(1, :)));

            % Crossover işlemi bilgisini sakla
            crossoverInfo{parent1idx, 1} = parent1idx;
            crossoverInfo{parent1idx, 2} = parent2idx;
            crossoverInfo{parent1idx, 3} = cpoint + 1;
            crossoverInfo{parent2idx, 1} = parent1idx;
            crossoverInfo{parent2idx, 2} = parent2idx;
            crossoverInfo{parent2idx, 3} = cpoint;
        end
    end
end

function [child, cp1, cp2] = OX_crossover(parent1, parent2)
    len = length(parent1);
    child = zeros(1, len);
    
    % Segment seçimi
    cp1 = randi([1, len-1]);
    cp2 = randi([cp1+1, len]);
    
    % Segmenti child'a yerleştir
    child(cp1:cp2) = parent1(cp1:cp2);
    
    % parent2'den kalanları child'a ekle
    currentIndex = mod(cp2, len) + 1;
    for i = 1:len
        gene = parent2(mod(cp2 + i - 1, len) + 1);
        if ~ismember(gene, child)
            child(currentIndex) = gene;
            currentIndex = mod(currentIndex, len) + 1;
        end
    end
end
