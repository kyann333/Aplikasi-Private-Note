import 'dart:math';
import 'package:flutter/material.dart';

class HalamanBerandaScreen extends StatefulWidget {
  const HalamanBerandaScreen({super.key});

  @override
  State<HalamanBerandaScreen> createState() => _HalamanBerandaScreenState();
}

class _HalamanBerandaScreenState extends State<HalamanBerandaScreen> {
  bool isListView = true;
  int selectedTopIndex = -1;

  final List<NoteItem> _notes = [
    NoteItem(
      title: 'judul note 1',
      content:
          'deskripsi note 1',
      tags: ['Research', 'Pinned'],
      timeAgo: '15d',
      dotColor: const Color(0xFFC9A882),
      isPinned: true,
    ),
    NoteItem(
      title: 'judul note 2',
      content:
          'deskripsi note 2',
      tags: ['Draft'],
      timeAgo: '10d',
      dotColor: const Color(0xFFC9A882),
      isPinned: false,
    ),
    NoteItem(
      title: 'judul note 3',
      content:
          'deskripsi note 3',
      tags: ['Architecture'],
      timeAgo: '7d',
      dotColor: const Color(0xFFC9A882),
      isPinned: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    const topIcons = [
      Icons.tune,
      Icons.lock_outline,
      Icons.search,
      Icons.visibility_outlined,
      Icons.folder_outlined,
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF0A0908),
      body: Stack(
        children: [
          const Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(painter: _StarDustPainter()),
            ),
          ),
          SafeArea(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 110),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      // 1. Top Action Bar
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF141210).withValues(alpha: 0.92),
                          borderRadius: BorderRadius.circular(36),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.08),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(topIcons.length, (index) {
                            final isSelected = selectedTopIndex == index;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedTopIndex = isSelected ? -1 : index;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Tombol ke-${index + 1} ditekan'),
                                    duration: const Duration(milliseconds: 700),
                                  ),
                                );
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 180),
                                width: 46,
                                height: 46,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isSelected
                                      ? const Color(0xFFC9A882)
                                          .withValues(alpha: 0.25)
                                      : const Color(0xFF23201D),
                                ),
                                child: Icon(
                                  topIcons[index],
                                  size: 20,
                                  color: isSelected
                                      ? const Color(0xFFD6B895)
                                      : const Color(0xFFB8B2AA),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),

                      const SizedBox(height: 16),

                      
                      
                      const SizedBox(height: 28),

                      // 2. Library & View Mode Toggle
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'LIBRARY',
                                  style: TextStyle(
                                    fontSize: 12,
                                    letterSpacing: 1.6,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white.withValues(alpha: 0.45),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                const Text(
                                  'Note Terbaru',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFFF6F3EE),
                                    letterSpacing: -0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: const Color(0xFF161412),
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.08),
                              ),
                            ),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () => setState(() => isListView = true),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 180),
                                    width: 44,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      color: isListView
                                          ? const Color(0xFFC7A680)
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    child: Icon(
                                      Icons.view_agenda_outlined,
                                      size: 18,
                                      color: isListView
                                          ? const Color(0xFF14110E)
                                          : Colors.white.withValues(alpha: 0.75),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => setState(() => isListView = false),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 180),
                                    width: 44,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      color: !isListView
                                          ? const Color(0xFFC7A680)
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    child: Icon(
                                      Icons.grid_view_rounded,
                                      size: 18,
                                      color: !isListView
                                          ? const Color(0xFF14110E)
                                          : Colors.white.withValues(alpha: 0.75),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // 3. List atau Grid Catatan
                      if (isListView)
                        Column(
                          children: _notes.map((note) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 14),
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF151311)
                                      .withValues(alpha: 0.95),
                                  borderRadius: BorderRadius.circular(24),
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha: 0.07),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: note.dotColor,
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Text(
                                            note.title,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFFF3EFEA),
                                            ),
                                          ),
                                        ),
                                        if (note.isPinned) ...[
                                          Transform.rotate(
                                            angle: 0.55,
                                            child: Icon(
                                              Icons.push_pin,
                                              size: 17,
                                              color: Colors.white
                                                  .withValues(alpha: 0.65),
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                        ],
                                        Icon(
                                          Icons.more_vert,
                                          size: 20,
                                          color:
                                              Colors.white.withValues(alpha: 0.7),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 14),
                                    Text(
                                      note.content,
                                      style: TextStyle(
                                        fontSize: 15.5,
                                        height: 1.45,
                                        color:
                                            Colors.white.withValues(alpha: 0.78),
                                      ),
                                    ),
                                    const SizedBox(height: 18),
                                    Wrap(
                                      spacing: 8,
                                      runSpacing: 8,
                                      children: note.tags.map((tag) {
                                        final isFolderTag = tag == 'Research';
                                        return Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 6,
                                          ),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF26221E),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              if (isFolderTag) ...[
                                                Icon(
                                                  Icons.folder_outlined,
                                                  size: 14,
                                                  color: Colors.white
                                                      .withValues(alpha: 0.75),
                                                ),
                                                const SizedBox(width: 6),
                                              ],
                                              Text(
                                                tag,
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white
                                                      .withValues(alpha: 0.85),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                    const SizedBox(height: 14),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.access_time,
                                          size: 14,
                                          color: Colors.white
                                              .withValues(alpha: 0.5),
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          note.timeAgo,
                                          style: TextStyle(
                                            fontSize: 13.5,
                                            color: Colors.white
                                                .withValues(alpha: 0.55),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        )
                      else
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _notes.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 0.8,
                          ),
                          itemBuilder: (context, index) {
                            final note = _notes[index];
                            return Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: const Color(0xFF151311)
                                    .withValues(alpha: 0.95),
                                borderRadius: BorderRadius.circular(22),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.07),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 9,
                                        height: 9,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: note.dotColor,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          note.title,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFFF3EFEA),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Expanded(
                                    child: Text(
                                      note.content,
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 13.5,
                                        height: 1.4,
                                        color: Colors.white
                                            .withValues(alpha: 0.75),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    note.timeAgo,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color:
                                          Colors.white.withValues(alpha: 0.5),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      // 4. Floating Action Buttons
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: const Color(0xFF1A1715),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            ),
            child: IconButton(
              icon: const Icon(Icons.mic_none, color: Color(0xFFC9A882)),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Voice note ditekan'),
                    duration: Duration(milliseconds: 700),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: const Color(0xFF1F1C19),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
            ),
            child: IconButton(
              icon: const Icon(Icons.add, color: Color(0xFFF3EFEA), size: 26),
              onPressed: () {
                setState(() {
                  _notes.insert(
                    0,
                    NoteItem(
                      title: 'New note',
                      content: 'Start writing your private note here...',
                      tags: ['Draft'],
                      timeAgo: 'Just now',
                      dotColor: const Color(0xFFC9A882),
                      isPinned: false,
                    ),
                  );
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class NoteItem {
  final String title;
  final String content;
  final List<String> tags;
  final String timeAgo;
  final Color dotColor;
  final bool isPinned;

  NoteItem({
    required this.title,
    required this.content,
    required this.tags,
    required this.timeAgo,
    required this.dotColor,
    required this.isPinned,
  });
}

class _StarDustPainter extends CustomPainter {
  const _StarDustPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final random = Random(42);
    for (int i = 0; i < 85; i++) {
      final dx = random.nextDouble() * size.width;
      final dy = random.nextDouble() * size.height;
      final radius = random.nextDouble() * 1.4 + 0.4;
      final paint = Paint()
        ..color =
            Colors.white.withValues(alpha: random.nextDouble() * 0.35 + 0.08);
      canvas.drawCircle(Offset(dx, dy), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}