# Instagram Clone

A Flutter-based mobile application inspired by Instagram, utilizing Firebase for backend services. This project aims to replicate core social media functionalities including user authentication, image posting, and content feeds.

## Features

### User Authentication
- **Email & Password Registration:** Allows new users to sign up securely.
- **Email & Password Login:** Enables existing users to access their accounts.
- **Profile Image Upload:** Users can set a profile picture during registration.

### Content Sharing & Interaction
- **Image Posting:** Authenticated users can create new posts by uploading images.
- **Captions:** Users can add descriptive text (captions) to their image posts.
- **Global Post Feed:** Displays a chronological feed of the latest posts from all users.
  - _Backend method: `getLatestPosts()`_
- **User-Specific Post Feed (Implied):** Functionality exists to retrieve posts for a specific user, likely for viewing user profiles.
  - _Backend method: `getPostsForUser()`_
- **View Individual Posts (Implied):** Functionality exists to fetch and display details of a single post.
  - _Backend methods: `getAPost()`, `fetchPostById()`_

### User & Profile Management
- **User Data Storage:** Stores essential user information (name, email, profile image URL) in Firestore.
- **Retrieve User Data:** Fetches user profile information as needed.
  - _Backend method: `getUserData()`_
- **List Users (Implied):** Capability to fetch a list of all registered users.
  - _Backend method: `getUsers()`_

### Backend & Technology
- **Firebase Authentication:** Securely manages user identities and authentication states.
- **Cloud Firestore (Database):**
    - Stores user profiles in a `users` collection.
    - Stores post details (uploader info, image URL, caption, timestamp) in a `posts` collection.
    - Utilizes real-time listeners (`snapshots()`) for dynamic feed updates.
- **Firebase Storage:**
    - Securely stores user-uploaded images (profile pictures and post content).
    - Organizes images in storage paths based on user ID for better management.

---

## Technical Details

- **Language:** Dart
- **Framework:** Flutter
- **Backend:** Firebase
    - Firebase Authentication
    - Cloud Firestore
    - Firebase Storage

---

