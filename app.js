const categories = [
  { id: 'all', name: 'Todas' },
  { id: 'valves', name: 'Válvulas' },
  { id: 'connections', name: 'Conexões' },
  { id: 'extensions', name: 'Extensões' },
  { id: 'regulators', name: 'Reguladores' },
  { id: 'accessories', name: 'Acessórios' },
];

const products = [
  {
    id: '001',
    name: 'Válvula de Segurança SV-100',
    category: 'valves',
    description: 'Válvula de segurança de alta precisão para sistemas GLP com pressão até 60 bar.',
    specifications: ['Pressão máxima: 60 bar', 'Material: Latão niquelado', 'Vazão: 100 kg/h', 'Certificação: ISO 9001'],
    imageUrl: 'https://via.placeholder.com/640x420?text=Valvula+SV-100',
    material: 'Latão niquelado',
    pressure: '60 bar',
    temperature: '-20°C a +60°C',
    connection: 'NPT 3/4"',
    price: 'R$ 250,00',
    inStock: true,
    tags: ['válvula', 'segurança', 'GLP', 'alta pressão'],
    manufacturer: 'Atlas Industrial',
  },
  {
    id: '002',
    name: 'Conexão Rápida CQ-45',
    category: 'connections',
    description: 'Conexão rápida para tubulações de GLP com vedação garantida.',
    specifications: ['Diâmetro: 1/2"', 'Material: Aço carbono galvanizado', 'Vazão: 150 kg/h', 'Vedação: O-ring nitrílico'],
    imageUrl: 'https://via.placeholder.com/640x420?text=Conexao+CQ-45',
    material: 'Aço carbono galvanizado',
    pressure: '40 bar',
    temperature: '-10°C a +50°C',
    connection: 'Rosca NPT',
    price: 'R$ 85,50',
    inStock: true,
    tags: ['conexão', 'rápida', 'aço', 'vedação'],
    manufacturer: 'Atlas Industrial',
  },
  {
    id: '003',
    name: 'Extensão Flex XF-18',
    category: 'extensions',
    description: 'Extensão flexível para distribuição de GLP com acabamento resistente.',
    specifications: ['Comprimento: 1,8m', 'Material: PVC reforçado', 'Pressão de trabalho: 45 bar', 'Temperatura: -15°C a +55°C'],
    imageUrl: 'https://via.placeholder.com/640x420?text=Extensao+XF-18',
    material: 'PVC reforçado',
    pressure: '45 bar',
    temperature: '-15°C a +55°C',
    connection: 'Engate rápido',
    price: 'R$ 122,90',
    inStock: true,
    tags: ['extensão', 'flexível', 'GLP', 'PVC'],
    manufacturer: 'Atlas Industrial',
  },
  {
    id: '004',
    name: 'Regulador de Pressão RP-22',
    category: 'regulators',
    description: 'Regulador de pressão para tubos GLP com ajuste fino de fluxo.',
    specifications: ['Faixa de pressão: 0,5-5 bar', 'Material: Alumínio anodizado', 'Temperatura: -20°C a +70°C', 'Entrada: 1/2"'],
    imageUrl: 'https://via.placeholder.com/640x420?text=Regulador+RP-22',
    material: 'Alumínio anodizado',
    pressure: '0,5-5 bar',
    temperature: '-20°C a +70°C',
    connection: '1/2" NPT',
    price: 'R$ 312,00',
    inStock: true,
    tags: ['regulador', 'pressão', 'GLP', 'ajuste'],
    manufacturer: 'Atlas Industrial',
  },
  {
    id: '005',
    name: 'Acessório de Vedação AV-11',
    category: 'accessories',
    description: 'Kit de vedação para juntas e conexões com resistência química.',
    specifications: ['Material: Borracha nitrílica', 'Temperatura: -30°C a +120°C', 'Diâmetro: 20mm', 'Uso: GLP e gás industriais'],
    imageUrl: 'https://via.placeholder.com/640x420?text=Veda%C3%A7%C3%A3o+AV-11',
    material: 'Borracha nitrílica',
    pressure: '30 bar',
    temperature: '-30°C a +120°C',
    connection: 'Kit multifuncional',
    price: 'R$ 36,80',
    inStock: true,
    tags: ['acessório', 'vedação', 'gaxeta', 'GLP'],
    manufacturer: 'Atlas Industrial',
  },
];

const categoryButtons = document.getElementById('categoryButtons');
const productGrid = document.getElementById('productGrid');
const searchInput = document.getElementById('searchInput');
const modalOverlay = document.getElementById('productModal');
const modalContent = document.getElementById('modalContent');
const closeModal = document.getElementById('closeModal');

let activeCategory = 'all';
let searchTerm = '';

function init() {
  renderCategories();
  renderProducts(products);
  searchInput.addEventListener('input', (event) => {
    searchTerm = event.target.value.trim().toLowerCase();
    updateDisplay();
  });
  closeModal.addEventListener('click', hideModal);
  modalOverlay.addEventListener('click', (event) => {
    if (event.target === modalOverlay) hideModal();
  });
}

function renderCategories() {
  categories.forEach((category) => {
    const button = document.createElement('button');
    button.className = 'category-button';
    button.textContent = category.name;
    button.dataset.category = category.id;
    if (category.id === activeCategory) button.classList.add('active');
    button.addEventListener('click', () => {
      activeCategory = category.id;
      document.querySelectorAll('.category-button').forEach((btn) => btn.classList.remove('active'));
      button.classList.add('active');
      updateDisplay();
    });
    categoryButtons.appendChild(button);
  });
}

function updateDisplay() {
  const filtered = products.filter((product) => {
    const matchesCategory = activeCategory === 'all' || product.category === activeCategory;
    const matchesSearch = searchTerm === '' ||
      product.name.toLowerCase().includes(searchTerm) ||
      product.description.toLowerCase().includes(searchTerm) ||
      product.tags.some((tag) => tag.toLowerCase().includes(searchTerm));
    return matchesCategory && matchesSearch;
  });
  renderProducts(filtered);
}

function renderProducts(items) {
  productGrid.innerHTML = items.length
    ? items.map(createProductCard).join('')
    : '<p class="empty-state">Nenhum produto encontrado. Tente outra busca ou categoria.</p>';
}

function createProductCard(product) {
  return `
    <article class="product-card">
      <div class="product-badge">${product.category.toUpperCase()}</div>
      <h3>${product.name}</h3>
      <p>${product.description}</p>
      <div class="product-tags">${product.tags.map((tag) => `<span class="product-tag">${tag}</span>`).join('')}</div>
      <div class="product-actions">
        <span class="product-price">${product.price}</span>
        <button class="btn btn-secondary" onclick="showProductModal('${product.id}')">Detalhes</button>
      </div>
    </article>
  `;
}

function showProductModal(productId) {
  const product = products.find((item) => item.id === productId);
  if (!product) return;

  modalContent.innerHTML = `
    <h3>${product.name}</h3>
    <p>${product.description}</p>
    <div class="product-badge">${product.category.toUpperCase()}</div>
    <div class="modal-meta">
      <div><strong>Fabricante:</strong> ${product.manufacturer}</div>
      <div><strong>Material:</strong> ${product.material}</div>
      <div><strong>Conexão:</strong> ${product.connection}</div>
      <div><strong>Temperatura:</strong> ${product.temperature}</div>
      <div><strong>Pressão:</strong> ${product.pressure}</div>
      <div><strong>Disponibilidade:</strong> ${product.inStock ? 'Em estoque' : 'Indisponível'}</div>
    </div>
    <h4>Especificações</h4>
    <ul class="modal-list">
      ${product.specifications.map((spec) => `<li>${spec}</li>`).join('')}
    </ul>
    <p><strong>Preço:</strong> ${product.price}</p>
  `;
  modalOverlay.classList.remove('hidden');
}

function hideModal() {
  modalOverlay.classList.add('hidden');
}

init();
