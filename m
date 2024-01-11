Return-Path: <linux-kernel+bounces-24078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA2C82B683
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 22:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D43E1B21C33
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 21:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8735812F;
	Thu, 11 Jan 2024 21:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="baZnl51p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CE855E5A;
	Thu, 11 Jan 2024 21:18:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 22940C433F1;
	Thu, 11 Jan 2024 21:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705007882;
	bh=W4gNLu7iRl5KrtqH7r+sc4aCOBlQ4akYGPjSoE2XqEg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=baZnl51pXyyNhrKK4i7MCn6ZXuRoVS9b5VXAjlhnP68wVEVyDm07XJ2sIekj+WYZj
	 X3DsFD9pXRGVJHk4OrRKCD2px7pTxJiDFAXKrCEQOF8IdYLBK+5kL2qRnQtVPjCT9i
	 o94hbaygtC3tcO4zhBzlKRIE/4ANSck403l/DaTWLoxZWrrCiUnipj2iasWyAYfxdh
	 EKL2doKFITZqxLM2kHB0oeDWsixNKqOjfb1PxgZsuZRiamWW0mFlMqZVIu90AVQtTk
	 eKJg1Oozl/C9X83lJG7jh5kak6ZjTfGtDy8CYPP+TyUmj/RlsJfKfKXsickd+IIEkj
	 hQ0ZgLMS/fCmA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0CB3AD8C96C;
	Thu, 11 Jan 2024 21:18:02 +0000 (UTC)
Subject: Re: [GIT PULL] Rust for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240108012055.519813-1-ojeda@kernel.org>
References: <20240108012055.519813-1-ojeda@kernel.org>
X-PR-Tracked-List-Id: <rust-for-linux.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240108012055.519813-1-ojeda@kernel.org>
X-PR-Tracked-Remote: https://github.com/Rust-for-Linux/linux.git tags/rust-6.8
X-PR-Tracked-Commit-Id: 711cbfc717650532624ca9f56fbaf191bed56e67
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b6964fe2398cb8939c3d4fc6960a6be93687305d
Message-Id: <170500788204.23189.13040745070216693754.pr-tracker-bot@kernel.org>
Date: Thu, 11 Jan 2024 21:18:02 +0000
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Miguel Ojeda <ojeda@kernel.org>, Wedson Almeida Filho <wedsonaf@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon,  8 Jan 2024 02:20:55 +0100:

> https://github.com/Rust-for-Linux/linux.git tags/rust-6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b6964fe2398cb8939c3d4fc6960a6be93687305d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

