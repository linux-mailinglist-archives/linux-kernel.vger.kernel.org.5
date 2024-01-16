Return-Path: <linux-kernel+bounces-27555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1497282F213
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 17:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F741B22AE3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE031CA9B;
	Tue, 16 Jan 2024 16:02:56 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5A31C68C;
	Tue, 16 Jan 2024 16:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentinobst.de
Received: from localhost.localdomain ([217.245.156.100]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mow4E-1qmZCE25Ne-00qV0H; Tue, 16 Jan 2024 17:02:36 +0100
From: Valentin Obst <kernel@valentinobst.de>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Valentin Obst <kernel@valentinobst.de>
Subject: [PATCH 01/13] rust: kernel: fix multiple typos in documentation
Date: Tue, 16 Jan 2024 17:01:26 +0100
Message-ID: <20240116160141.165951-2-kernel@valentinobst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116160141.165951-1-kernel@valentinobst.de>
References: <20240116160141.165951-1-kernel@valentinobst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:5a5kO99YMVZNCl/XnVf1l8Q43RLe84qbmVpAjJJUvblmFHUDQnc
 d2yrMIVdBjyqZ/ZdLoK+i7NLcTeVnZ+EsNQf5uB3TeVBpr/Tv0zVRId31su0SmtfRxYc3RP
 qlG1AV32/tSs0SuUPZIHW5hkr+Vyb+j6JS/orrQbASsWPShNVeMZ7IJ0I3BrcTQ/1CleH4G
 Li+OFgSa4baAGQIwcdt9g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:U5M+o6PWla4=;xCZsCsV91GvI0tFrcS7Xo1Uz4my
 ebA6L5c6sqI5O/vBEzw3fxL6z80pNP6X7dKqHFMLI1H2o5x30RAJ4Sw5p/ar1bON01TyBIDCz
 O8CimUDHvWb7ngLVjZQznQLM/5zGwCe82qZFTNrFZD5pyX8WicIrWccd8iTR8GmCfnFzodEEh
 iDoCHerH7D7zhK7VWpgMUChY/cCprLf6q/ZU1eeEO/oXev0SVtWX971R1xiDElpD5CWQUPC29
 xzAdm+Z3TxcQlQsc6AoYA5AoQSyEaidkn5LDpK8D0oI3MF9rkK7gWZFDeSviJUh/r4w0ATibE
 Rxi9Tct0hb+FvO7edkatUfVp+7FDB6VW0eY8CxWN/PRO66bAOJ7F0AVg+zgOBGs+CWHdAv0p4
 myjbUM/PtRT8Bm2yPHl3cO70LIbSrFbkuxiwiAbgiD3YvgxSXJd26qQp+jEx3Ta7jocwC6Wpv
 bLxD7gPZOQQJGazRGjdXUDPs8HSjA21pe9lJuCRm3s4T8vyRBExbsrKQPn+HGBKEexLvNq0cn
 7WBk1c8+bz855Zr3Op6NEF4/kdzyJ6an5iXbBPY7/xgxhxrreuUhEsrle9XX1ckdDRqaufjMI
 OdhlZqM/qqbEHBbkwArssfwVUVxN+7jBDYaoenidQBFWQW1R1Rx5c/Y/cO2kG++xczbhN4waK
 C5IPentpGMurez4JSMGH6N7+XOrXtw4YxaDoB38TO82fxyv+6ybxBEd7P9B775nov1cxSz5nz
 eRv6qge/dPkEsvHsx1IXx3FbZt03b+2BOYjtAq0TwMuc4y/FEL7sFQZ7pTD3oaKLGGd8qt+Pn
 qBK8tqrk1cL9heSNGfI68AYS/pybLYx/j0L3NHoU+brs+SFmfikCpxRv8aLxVTV8Il58UpYaI
 Wk2lE5mpT+7nwDA==

Fixes multiple trivial typos in documentation and comments of the
kernel crate.

allocator:
- Fix a trivial list item alignment issue in the last SAFETY comment of
`krealloc_aligned`.

init:
- Replace 'type' with 'trait' in the doc comments of the `PinInit` and
`Init` traits.
- Add colons before starting lists.
- Add spaces between the type and equal sign to respect the code
formatting rules in example code.
- End a sentence with a full stop instead of a colon.

ioctl:
- Replace 'an' with 'a' where appropriate.

str:
- Replace 'Return' with 'Returns' in the doc comment of `bytes_written`
as the text describes what the function does.

sync/lock/spinlock:
- The code in this module operates on spinlocks, not mutexes. Thus,
replace 'mutex' with 'spinlock' in the SAFETY comment of `unlock`.

workqueue:
- Replace "wont" with "won't" in the doc comment of `__enqueue`.

Signed-off-by: Valentin Obst <kernel@valentinobst.de>
---
 rust/kernel/allocator.rs          |  2 +-
 rust/kernel/init.rs               | 16 ++++++++--------
 rust/kernel/ioctl.rs              |  4 ++--
 rust/kernel/str.rs                |  2 +-
 rust/kernel/sync/lock/spinlock.rs |  2 +-
 rust/kernel/workqueue.rs          |  2 +-
 6 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/rust/kernel/allocator.rs b/rust/kernel/allocator.rs
index 4b057e837358..01ad139e19bc 100644
--- a/rust/kernel/allocator.rs
+++ b/rust/kernel/allocator.rs
@@ -35,7 +35,7 @@ unsafe fn krealloc_aligned(ptr: *mut u8, new_layout: Layout, flags: bindings::gf
     // - `ptr` is either null or a pointer returned from a previous `k{re}alloc()` by the
     //   function safety requirement.
     // - `size` is greater than 0 since it's either a `layout.size()` (which cannot be zero
-    //    according to the function safety requirement) or a result from `next_power_of_two()`.
+    //   according to the function safety requirement) or a result from `next_power_of_two()`.
     unsafe { bindings::krealloc(ptr as *const core::ffi::c_void, size, flags) as *mut u8 }
 }
 
diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index 65be9ae57b80..16a99984622c 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -751,10 +751,10 @@ macro_rules! try_init {
 ///
 /// # Safety
 ///
-/// When implementing this type you will need to take great care. Also there are probably very few
+/// When implementing this trait you will need to take great care. Also there are probably very few
 /// cases where a manual implementation is necessary. Use [`pin_init_from_closure`] where possible.
 ///
-/// The [`PinInit::__pinned_init`] function
+/// The [`PinInit::__pinned_init`] function:
 /// - returns `Ok(())` if it initialized every field of `slot`,
 /// - returns `Err(err)` if it encountered an error and then cleaned `slot`, this means:
 ///     - `slot` can be deallocated without UB occurring,
@@ -861,10 +861,10 @@ unsafe fn __pinned_init(self, slot: *mut T) -> Result<(), E> {
 ///
 /// # Safety
 ///
-/// When implementing this type you will need to take great care. Also there are probably very few
+/// When implementing this trait you will need to take great care. Also there are probably very few
 /// cases where a manual implementation is necessary. Use [`init_from_closure`] where possible.
 ///
-/// The [`Init::__init`] function
+/// The [`Init::__init`] function:
 /// - returns `Ok(())` if it initialized every field of `slot`,
 /// - returns `Err(err)` if it encountered an error and then cleaned `slot`, this means:
 ///     - `slot` can be deallocated without UB occurring,
@@ -1013,7 +1013,7 @@ pub fn uninit<T, E>() -> impl Init<MaybeUninit<T>, E> {
 ///
 /// ```rust
 /// use kernel::{error::Error, init::init_array_from_fn};
-/// let array: Box<[usize; 1_000]>= Box::init::<Error>(init_array_from_fn(|i| i)).unwrap();
+/// let array: Box<[usize; 1_000]> = Box::init::<Error>(init_array_from_fn(|i| i)).unwrap();
 /// assert_eq!(array.len(), 1_000);
 /// ```
 pub fn init_array_from_fn<I, const N: usize, T, E>(
@@ -1027,7 +1027,7 @@ pub fn init_array_from_fn<I, const N: usize, T, E>(
         // Counts the number of initialized elements and when dropped drops that many elements from
         // `slot`.
         let mut init_count = ScopeGuard::new_with_data(0, |i| {
-            // We now free every element that has been initialized before:
+            // We now free every element that has been initialized before.
             // SAFETY: The loop initialized exactly the values from 0..i and since we
             // return `Err` below, the caller will consider the memory at `slot` as
             // uninitialized.
@@ -1056,7 +1056,7 @@ pub fn init_array_from_fn<I, const N: usize, T, E>(
 ///
 /// ```rust
 /// use kernel::{sync::{Arc, Mutex}, init::pin_init_array_from_fn, new_mutex};
-/// let array: Arc<[Mutex<usize>; 1_000]>=
+/// let array: Arc<[Mutex<usize>; 1_000]> =
 ///     Arc::pin_init(pin_init_array_from_fn(|i| new_mutex!(i))).unwrap();
 /// assert_eq!(array.len(), 1_000);
 /// ```
@@ -1071,7 +1071,7 @@ pub fn pin_init_array_from_fn<I, const N: usize, T, E>(
         // Counts the number of initialized elements and when dropped drops that many elements from
         // `slot`.
         let mut init_count = ScopeGuard::new_with_data(0, |i| {
-            // We now free every element that has been initialized before:
+            // We now free every element that has been initialized before.
             // SAFETY: The loop initialized exactly the values from 0..i and since we
             // return `Err` below, the caller will consider the memory at `slot` as
             // uninitialized.
diff --git a/rust/kernel/ioctl.rs b/rust/kernel/ioctl.rs
index f1d42ab69972..59050e5f5a5a 100644
--- a/rust/kernel/ioctl.rs
+++ b/rust/kernel/ioctl.rs
@@ -28,13 +28,13 @@ pub const fn _IO(ty: u32, nr: u32) -> u32 {
     _IOC(uapi::_IOC_NONE, ty, nr, 0)
 }
 
-/// Build an ioctl number for an read-only ioctl.
+/// Build an ioctl number for a read-only ioctl.
 #[inline(always)]
 pub const fn _IOR<T>(ty: u32, nr: u32) -> u32 {
     _IOC(uapi::_IOC_READ, ty, nr, core::mem::size_of::<T>())
 }
 
-/// Build an ioctl number for an write-only ioctl.
+/// Build an ioctl number for a write-only ioctl.
 #[inline(always)]
 pub const fn _IOW<T>(ty: u32, nr: u32) -> u32 {
     _IOC(uapi::_IOC_WRITE, ty, nr, core::mem::size_of::<T>())
diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 7d848b83add4..0a8569594fc3 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -449,7 +449,7 @@ pub(crate) fn pos(&self) -> *mut u8 {
         self.pos as _
     }
 
-    /// Return the number of bytes written to the formatter.
+    /// Returns the number of bytes written to the formatter.
     pub(crate) fn bytes_written(&self) -> usize {
         self.pos - self.beg
     }
diff --git a/rust/kernel/sync/lock/spinlock.rs b/rust/kernel/sync/lock/spinlock.rs
index 068535ce1b29..e5e0bf621988 100644
--- a/rust/kernel/sync/lock/spinlock.rs
+++ b/rust/kernel/sync/lock/spinlock.rs
@@ -112,7 +112,7 @@ unsafe fn lock(ptr: *mut Self::State) -> Self::GuardState {
 
     unsafe fn unlock(ptr: *mut Self::State, _guard_state: &Self::GuardState) {
         // SAFETY: The safety requirements of this function ensure that `ptr` is valid and that the
-        // caller is the owner of the mutex.
+        // caller is the owner of the spinlock.
         unsafe { bindings::spin_unlock(ptr) }
     }
 }
diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index 498397877376..8775c34d12a5 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -253,7 +253,7 @@ fn run(mut this: Pin<Box<Self>>) {
 /// actual value of the id is not important as long as you use different ids for different fields
 /// of the same struct. (Fields of different structs need not use different ids.)
 ///
-/// Note that the id is used only to select the right method to call during compilation. It wont be
+/// Note that the id is used only to select the right method to call during compilation. It won't be
 /// part of the final executable.
 ///
 /// # Safety
-- 
2.43.0


