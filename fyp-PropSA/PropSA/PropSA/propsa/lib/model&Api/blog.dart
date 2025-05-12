
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.business, color: Colors.blue.shade800, size: 24),
            ),
            const SizedBox(width: 12),
            Text(
              'Blog for u',
              style: TextStyle(
                color: Colors.blue.shade800,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('blog').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('No blog posts available'));
            }

            return BlogGridView(blogPosts: snapshot.data!.docs);
          },
        ),
      ),
    );
  }
}

class BlogGridView extends StatelessWidget {
  final List<QueryDocumentSnapshot> blogPosts;

  const BlogGridView({Key? key, required this.blogPosts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 16.0,
        childAspectRatio: 1.1,
      ),
      itemCount: blogPosts.length,
      itemBuilder: (context, index) {
        final blog = blogPosts[index].data() as Map<String, dynamic>;
        return BlogCard(
          imageUrl: blog['url'] ?? '',
          title: blog['heading'] ?? 'Untitled',
          subtitle: blog['sub'] ?? 'No description',
          des:blog['des'],
          blogId: blogPosts[index].id,
        );
      },
    );
  }
}

class BlogCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final String blogId;
  final String des;

  const BlogCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.des,
    required this.blogId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Blog Image
          Expanded(
            flex: 6,
            child: BlogImage(imageUrl: imageUrl),
          ),
          // Blog Content
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Blog Title
                  BlogTitle(title: title),
                  const SizedBox(height: 4.0),
                  // Blog Subtitle
                  BlogSubtitle(subtitle: subtitle),
                  const Spacer(),
                  // Read More Button
                  ReadMoreButton(title:title,url:imageUrl,sub:subtitle,des:des,blogId: blogId),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BlogImage extends StatelessWidget {
  final String imageUrl;

  const BlogImage({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: Colors.grey[300],
          child: const Center(
            child: Icon(
              Icons.image_not_supported,
              size: 50,
              color: Colors.grey,
            ),
          ),
        );
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
    );
  }
}

class BlogTitle extends StatelessWidget {
  final String title;

  const BlogTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class BlogSubtitle extends StatelessWidget {
  final String subtitle;

  const BlogSubtitle({
    Key? key,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      subtitle,
      style: TextStyle(
        fontSize: 14,
        color: Colors.grey[600],
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class ReadMoreButton extends StatelessWidget {
  final String blogId; 
  final String url;
   final String title;
    final String sub;
     final String des;

  const ReadMoreButton({
    Key? key,
    required this.blogId,
    required this.url,
    required this.des,
    required this.title,   
    required this.sub,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlogDetailScreen(title:title,url:url,sub:sub,des:des,blogId: blogId),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue.shade800,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text('Read More',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
      ),
    );
  }
}




class BlogDetailScreen extends StatelessWidget {
  final String blogId;
  final String url;
  final String title;
  final String sub;
  final String des;

  const BlogDetailScreen({
    Key? key,
    required this.blogId,
    required this.url,
    required this.title,
    required this.sub,
    required this.des,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.blue.shade800),
        title: Row(
          children: [
            Icon(Icons.article_outlined, color: Colors.blue.shade800, size: 28),
            const SizedBox(width: 8),
            Text(
              'Blog Details',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.blue.shade800,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Blog Image
              Center(
  child: ClipRRect(
    borderRadius: BorderRadius.circular(16),
    child: Image.network(
      url,
      width: 900, // Smaller width
      height: 400, // Smaller height
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) =>
          const Center(child: Icon(Icons.broken_image, size: 100)),
    ),
  ),
),

              const SizedBox(height: 20),

              // Card Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Text(
                          title,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Subtitle
                        Text(
                          sub,
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: Colors.blueGrey,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Divider
                        const Divider(thickness: 1.2),
                        const SizedBox(height: 16),
                        // Description
                        Text(
                          des,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            height: 1.5,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(height: 20),
                        // Tags or extra visual elements
                        Wrap(
                          spacing: 8,
                          children: [
                            Chip(
                              label: Text("property"),
                              backgroundColor: Colors.blue.shade50,
                              labelStyle: TextStyle(color: Colors.blue.shade800),
                            ),
                            Chip(
                              label: Text("investmeents"),
                              backgroundColor: Colors.green.shade50,
                              labelStyle: TextStyle(color: Colors.green.shade800),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}