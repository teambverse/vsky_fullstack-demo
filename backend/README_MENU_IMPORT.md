# 🍽️ Menu Data Import System

This system handles importing restaurant menu data from inconsistent formats (Excel, CSV, JSON) with validation, normalization, and multilingual support.

## 🎯 Features

- **✅ Multi-Format Support**: Excel (.xlsx, .xls), CSV, JSON
- **✅ Data Validation**: Schema and business rule validation
- **✅ Normalization**: Standardize names (e.g., "10\" Pizza" → "10 Inch Pizza")
- **✅ Multilingual Support**: Handle multiple language columns
- **✅ Deduplication**: Safe re-runs without creating duplicates
- **✅ Idempotency**: Transaction-safe imports

## 📁 Project Structure

```
menu_imports/
├── apps.py              # Django app configuration
├── parsers.py           # File format parsers
├── services.py          # Validation, normalization, multilingual handling
├── importer.py          # Database import logic
├── views.py             # API views for upload
├── urls.py              # URL patterns
└── __init__.py

test_menu_import.py      # Test script
```

## 🚀 Quick Start

### 1. Install Dependencies

```bash
pip install -r requirements.txt
# New packages added: pandas, openpyxl, chardet
```

### 2. Run Migrations

```bash
python manage.py migrate
```

### 3. Test the System

```bash
python test_menu_import.py
```

## 📊 End-to-End Data Flow

### File Upload → Parser → Validator → Normalizer → DB Importer → Order API

#### 1. **File Upload** (`POST /api/menus/upload/`)
- **Input**: Multipart file + restaurant_id
- **Validation**: File size (<10MB), format check
- **Output**: Upload ID for tracking

#### 2. **Parser** (Format-Specific)
- **Excel**: Uses pandas to read sheets, handles encoding
- **CSV**: Detects encoding with chardet, parses with csv module
- **JSON**: Validates structure, handles nested data
- **Output**: List of raw menu items

#### 3. **Validator** (Data Quality)
- **Schema Checks**: Required fields, data types
- **Business Rules**: Price > 0, name length < 255
- **Error Collection**: Per-row errors for reporting
- **Output**: Valid items + error list

#### 4. **Normalizer** (Standardization)
- **Name Normalization**: "10\" Pizza" → "10 Inch Pizza"
- **Category Mapping**: "pizzas" → "Pizza"
- **Hash Generation**: For deduplication
- **Output**: Normalized items with metadata

#### 5. **DB Importer** (Idempotent Insert)
- **Upsert Logic**: Update existing or create new
- **Transaction Safety**: Rollback on errors
- **Multilingual Handling**: Store translations in MenuItemTranslation
- **Output**: Import summary (imported/updated/skipped)

#### 6. **Order API Integration**
- Orders reference normalized menu items by ID
- Multilingual names pulled based on user locale
- Existing orders remain unaffected by new imports

## 🔧 API Endpoints

### Upload Menu File
```http
POST /api/menus/upload/
Content-Type: multipart/form-data

file: <menu_file>
restaurant_id: <uuid>
```

**Response:**
```json
{
  "upload_id": "uuid",
  "message": "Menu imported successfully",
  "results": {
    "total_items": 10,
    "imported": 8,
    "updated": 2,
    "skipped": 0,
    "errors": []
  }
}
```

### Check Import Status
```http
GET /api/menus/status/{upload_id}/
```

## 📋 Supported File Formats

### Excel (.xlsx, .xls)
- **Columns**: name, price, category, description (case-insensitive)
- **Features**: Multi-sheet support, automatic encoding detection

### CSV
- **Delimiter**: Comma (`,`)
- **Encoding**: Auto-detected (UTF-8, Latin-1, etc.)
- **Headers**: Required, mapped to standard fields

### JSON
- **Structure**: Array of objects or `{"items": [...]}` format
- **Multilingual**: Supports `name_en`, `name_es` columns

## 🌍 Multilingual Support

### Column Naming Convention
- `name` (default, English)
- `name_en` (English)
- `name_es` (Spanish)
- `name_fr` (French)
- etc.

### Storage
- Primary name stored in `MenuItem.name`
- Translations stored in `MenuItemTranslation` table
- Supports 7 languages: en, es, fr, de, zh, ar, hi

## 🛡️ Error Handling

### Validation Errors
- **Per-Row**: "Row 5: Invalid price format"
- **Schema**: "Missing required field: name"
- **Business**: "Price must be greater than 0"

### System Errors
- **File Parsing**: "Invalid Excel file format"
- **Database**: "Transaction rolled back due to constraint violation"

## 🔄 Idempotency & Deduplication

### Safe Re-runs
- Same file can be uploaded multiple times
- Existing items updated, new items created
- No duplicate entries created

### Deduplication Strategy
- Items matched by `restaurant_id + name + category`
- Updates price/description if item exists
- Creates new item if not found

## 🧪 Testing

### Unit Tests
```python
# Test parser
parser = get_parser('menu.xlsx')
items = parser.parse(file_content, 'menu.xlsx')

# Test validator
validator = MenuDataValidator()
valid_items, errors = validator.validate_items(items)

# Test importer
importer = MenuDataImporter()
results = importer.import_menu_data(normalized_items, restaurant_id)
```

### Integration Testing
```bash
# Upload file via API
curl -X POST http://localhost:8000/api/menus/upload/ \
  -F "file=@menu.xlsx" \
  -F "restaurant_id=your-restaurant-id"
```

## 🔧 Configuration

### File Size Limits
- **Max Size**: 10MB per file
- **Configurable** in `views.py` (line 45)

### Supported Languages
- Defined in `MenuItemTranslation.LANGUAGE_CHOICES`
- Easily extensible

### Database Constraints
- Uses existing `MenuItem` and `MenuItemTranslation` models
- No schema changes required

## 🚨 Production Considerations

### Performance
- **Large Files**: Consider async processing for >1000 items
- **Memory**: Files loaded entirely into memory
- **Database**: Batch inserts for better performance

### Security
- **File Validation**: Only allow specific extensions
- **Virus Scanning**: Integrate with antivirus service
- **Rate Limiting**: Limit upload frequency per user

### Monitoring
- **Logging**: All operations logged with upload_id
- **Metrics**: Track import success rates
- **Alerts**: Notify on high error rates

This system provides a robust, scalable solution for importing restaurant menu data while maintaining data integrity and supporting your restaurant's multilingual needs!
