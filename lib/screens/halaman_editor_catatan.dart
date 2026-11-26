import 'package:flutter/material.dart';

class HalamanEditorScreen extends StatefulWidget {
  final String initialTitle;
  final String initialContent;
  final String initialFolder;

  const HalamanEditorScreen({
    super.key,
    this.initialTitle = 'judul note',
    this.initialContent =
        'deskripsi atau content note.',
    this.initialFolder = 'Private',
  });

  @override
  State<HalamanEditorScreen> createState() => _HalamanEditorScreenState();
}

class _HalamanEditorScreenState extends State<HalamanEditorScreen> {
  late final TextEditingController _titleController;
  late final TextEditingController _contentController;

  String _selectedFolder = 'Private';
  bool _isSaved = true;
  bool _isBold = false;
  bool _isItalic = false;
  bool _isUnderline = false;
  int _activeFormatIndex = -1;

  final List<String> _folders = ['Private', 'Research', 'Personal', 'Work'];

  @override
  void initState() {
    super.initState();
    _selectedFolder = widget.initialFolder;
    _titleController = TextEditingController(text: widget.initialTitle);
    _contentController = TextEditingController(text: widget.initialContent);

    _titleController.addListener(_onTextChanged);
    _contentController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    if (_isSaved) {
      setState(() {
        _isSaved = false;
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF070707),
      body: SafeArea(
        child: Column(
          children: [
            // 1. Top App Bar (Back + Cloud Saved + AI Sparkle + More)
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 8),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Color(0xFFF3EFEA),
                      size: 24,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 6),
                  Icon(
                    Icons.cloud_done_outlined,
                    size: 18,
                    color: Colors.white.withValues(alpha: 0.72),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _isSaved ? 'Saved' : 'Saving...',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withValues(alpha: 0.78),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2B2622),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.auto_awesome,
                        color: Color(0xFFC9A882),
                        size: 20,
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('AI Assistant untuk catatan ini'),
                            duration: Duration(milliseconds: 800),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 4),
                  IconButton(
                    icon: const Icon(
                      Icons.more_vert,
                      color: Color(0xFFF3EFEA),
                      size: 22,
                    ),
                    onPressed: () {
                      setState(() {
                        _isSaved = true;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Catatan ditandai tersimpan'),
                          duration: Duration(milliseconds: 700),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // 2. Konten Utama (Judul, Folder Selector, Isi Catatan)
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Kotak Judul
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF151413),
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.09),
                        ),
                      ),
                      child: TextField(
                        controller: _titleController,
                        style: const TextStyle(
                          fontFamily: 'serif',
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFF6F3EE),
                          height: 1.25,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          isCollapsed: true,
                          hintText: 'Note title...',
                          hintStyle: TextStyle(
                            fontFamily: 'serif',
                            fontSize: 28,
                            color: Colors.white.withValues(alpha: 0.3),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    // Pemilih Folder (Private v)
                    PopupMenuButton<String>(
                      color: const Color(0xFF1C1A18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      onSelected: (value) {
                        setState(() {
                          _selectedFolder = value;
                          _isSaved = false;
                        });
                      },
                      itemBuilder: (context) => _folders
                          .map(
                            (folder) => PopupMenuItem<String>(
                              value: folder,
                              child: Text(
                                folder,
                                style: const TextStyle(
                                  color: Color(0xFFF3EFEA),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 4,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.folder_outlined,
                              size: 18,
                              color: Colors.white.withValues(alpha: 0.72),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _selectedFolder,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.white.withValues(alpha: 0.85),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Icon(
                              Icons.keyboard_arrow_down,
                              size: 18,
                              color: Colors.white.withValues(alpha: 0.65),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 22),

                    // Area Teks Catatan
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: TextField(
                        controller: _contentController,
                        maxLines: null,
                        cursorColor: Colors.white.withValues(alpha: 0.75),
                        style: TextStyle(
                          fontFamily: 'serif',
                          fontSize: 21,
                          height: 1.4,
                          fontWeight:
                              _isBold ? FontWeight.w700 : FontWeight.w400,
                          fontStyle:
                              _isItalic ? FontStyle.italic : FontStyle.normal,
                          decoration: _isUnderline
                              ? TextDecoration.underline
                              : TextDecoration.none,
                          decorationColor: const Color(0xFFF3EFEA),
                          color: const Color(0xFFF3EFEA),
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          isCollapsed: true,
                          hintText: 'Start writing...',
                          hintStyle: TextStyle(
                            fontFamily: 'serif',
                            fontSize: 21,
                            color: Colors.white.withValues(alpha: 0.3),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 3. Bottom Formatting Toolbar
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF141312),
                border: Border(
                  top: BorderSide(
                    color: Colors.white.withValues(alpha: 0.06),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // B (Bold)
                  GestureDetector(
                    onTap: () => setState(() => _isBold = !_isBold),
                    child: Container(
                      width: 44,
                      height: 44,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _isBold
                            ? const Color(0xFF3A352F)
                            : const Color(0xFF282624),
                      ),
                      child: const Text(
                        'B',
                        style: TextStyle(
                          fontFamily: 'serif',
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFE5DFD7),
                        ),
                      ),
                    ),
                  ),

                  // I (Italic)
                  GestureDetector(
                    onTap: () => setState(() => _isItalic = !_isItalic),
                    child: Container(
                      width: 44,
                      height: 44,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _isItalic
                            ? const Color(0xFF3A352F)
                            : const Color(0xFF282624),
                      ),
                      child: const Text(
                        'I',
                        style: TextStyle(
                          fontFamily: 'serif',
                          fontSize: 17,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFE5DFD7),
                        ),
                      ),
                    ),
                  ),

                  // U (Underline)
                  GestureDetector(
                    onTap: () => setState(() => _isUnderline = !_isUnderline),
                    child: Container(
                      width: 44,
                      height: 44,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _isUnderline
                            ? const Color(0xFF3A352F)
                            : const Color(0xFF282624),
                      ),
                      child: const Text(
                        'U',
                        style: TextStyle(
                          fontFamily: 'serif',
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                          decorationColor: Color(0xFFE5DFD7),
                          color: Color(0xFFE5DFD7),
                        ),
                      ),
                    ),
                  ),

                  // Align / Paragraph
                  GestureDetector(
                    onTap: () => setState(() {
                      _activeFormatIndex = _activeFormatIndex == 3 ? -1 : 3;
                    }),
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _activeFormatIndex == 3
                            ? const Color(0xFF3A352F)
                            : const Color(0xFF282624),
                      ),
                      child: const Icon(
                        Icons.format_align_center,
                        size: 20,
                        color: Color(0xFFD5CFC7),
                      ),
                    ),
                  ),

                  // Bullet List
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _activeFormatIndex = _activeFormatIndex == 4 ? -1 : 4;
                        _contentController.text =
                            '${_contentController.text}\n• ';
                        _contentController.selection =
                            TextSelection.fromPosition(
                          TextPosition(
                            offset: _contentController.text.length,
                          ),
                        );
                      });
                    },
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _activeFormatIndex == 4
                            ? const Color(0xFF3A352F)
                            : const Color(0xFF282624),
                      ),
                      child: const Icon(
                        Icons.format_list_bulleted,
                        size: 20,
                        color: Color(0xFFD5CFC7),
                      ),
                    ),
                  ),

                  // Checklist
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _activeFormatIndex = _activeFormatIndex == 5 ? -1 : 5;
                        _contentController.text =
                            '${_contentController.text}\n☐ ';
                        _contentController.selection =
                            TextSelection.fromPosition(
                          TextPosition(
                            offset: _contentController.text.length,
                          ),
                        );
                      });
                    },
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _activeFormatIndex == 5
                            ? const Color(0xFF3A352F)
                            : const Color(0xFF282624),
                      ),
                      child: const Icon(
                        Icons.checklist,
                        size: 20,
                        color: Color(0xFFD5CFC7),
                      ),
                    ),
                  ),

                  // Image
                  GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Sisipkan gambar ke catatan'),
                          duration: Duration(milliseconds: 700),
                        ),
                      );
                    },
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF282624),
                      ),
                      child: const Icon(
                        Icons.image_outlined,
                        size: 20,
                        color: Color(0xFFD5CFC7),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}