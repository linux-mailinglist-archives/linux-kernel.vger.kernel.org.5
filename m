Return-Path: <linux-kernel+bounces-27553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A7482F211
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 17:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C91E1C236DD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E2B1C69E;
	Tue, 16 Jan 2024 16:02:54 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7EC1C2AF;
	Tue, 16 Jan 2024 16:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentinobst.de
Received: from localhost.localdomain ([217.245.156.100]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MCbVD-1rGfMM1ilP-009kbA; Tue, 16 Jan 2024 17:02:37 +0100
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
Subject: [PATCH 03/13] rust: ioctl: end top level module docs with full stop
Date: Tue, 16 Jan 2024 17:01:28 +0100
Message-ID: <20240116160141.165951-4-kernel@valentinobst.de>
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
X-Provags-ID: V03:K1:Vl604ifirTqxSRb0VeZq6n9STXQC2equyytItghMfY5eTvyOnz2
 uM88EOQgOFfBZV2pVFZWqVdFt2heBqC3+1onll4HVVvSWl0hq/Sgvj1co03zc4404udJ0XO
 V0lzfaOqs4OQtaSkc+RqPiTOq/er+938r++R2R/p3ctFexrPFTJyqXphq6FQdvSgGKW5J85
 nUvnBocn8ivhaATyEjn9w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:M8ewJpf3SNc=;6DkxcoBATZk9fCkhsgRqI9hD4de
 97eMdKprz8PDEy7+1kgGahldajB3zz0kBfU477TFKBiWASXN3YHIczg4ufCS90nUVkTjLDFKD
 oBaqBowC8P8vESRyK6+q3XF3xdhiqO7eb3X+tBFPsusH/cUzZbAdFYgeu5zUCpcK+bWcduSCQ
 Gq7FCJ5oLOa6/YNeXKLqKi9n+X49JDuQ2v00ISAqr76zEhJuhNmFqwGbiRI9eYYe0upLuUq4g
 1PnlbtQFDQgj98grVp4pGExl+txnDyXCOtayxSmJqUQQas9HyASK0udF0rhKb7DYyEfG+u68j
 HZCkRXZMZBEL/610uLcZNDzqzRngKWRs1zRakzCaMEWGr9d73UKrWyW4x3qQk8/roAdyUDe6v
 1eAv1y5ifzpxO6DjIDjbMWjzSMxT3FeNagV/rIlq7U+xTkEgerrDscSuGkYnnXILzv/8le9Rs
 tHoee+FN5oCr52YX726iYwTDtb/FUe6Lvarfbv+c+g62CozwGlQbsXWD3vnHjGNqgnJr7Vsvr
 TTBYhZJwOrex3TyrKrImIAgw8PJS/GTtEUgftDiYXV+/V8ejUj7/bEU4OppS0NKTGpjmrz1ow
 asiEX25v56sRgxvhcHxiydFfIZDtL3fRo5MQCkOw0I3K/FisbQoTb9GfNvLiEUhApz4viL0V/
 xiQuqITQXfFExAhimf53hjod/OAqqk/uS0q/8yyPd6I6n/hXGczCxhk7tDd21faL9OfCHXys5
 UneRJXfZs9Qam1u4exGbAWNutykFCEU75MOJviyc85JazhAG9s3hkX6BP9qhBhjzHY8+VSl3b
 QrgU5B4XQ4cicDDTyF09avY9zhTS9bxMei0LUKY4P/+o5zYQF90tZGVeqNZOb4tvR7IS0AcPo
 OelptaDa0dTRYsQ==

Every other module ends its first line of documentation with a full
stop. Adapt the only outlier.

Signed-off-by: Valentin Obst <kernel@valentinobst.de>
---
 rust/kernel/ioctl.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/ioctl.rs b/rust/kernel/ioctl.rs
index 59050e5f5a5a..5987ad6d38a7 100644
--- a/rust/kernel/ioctl.rs
+++ b/rust/kernel/ioctl.rs
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
-//! ioctl() number definitions
+//! ioctl() number definitions.
 //!
 //! C header: [`include/asm-generic/ioctl.h`](srctree/include/asm-generic/ioctl.h)
 
-- 
2.43.0


