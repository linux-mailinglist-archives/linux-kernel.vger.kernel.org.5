Return-Path: <linux-kernel+bounces-20278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FC1827CBF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 03:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B5572855F5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 02:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9A728F1;
	Tue,  9 Jan 2024 02:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YY4dh8XO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEDF4680
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 02:11:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 90D85C4166A;
	Tue,  9 Jan 2024 02:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704766264;
	bh=RNgpOaHPrtXodeWZn/PngHYcMYNzRecXizVQUzdNinE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YY4dh8XOv6t11PBSOh8DnEdz05SSiWzdvWqOnuMTLGa4B2bXbxuFDM4kIDpIAo3gZ
	 WE7u435JPHkeMPPNAOzxDmfvvzN5nEmrSUNYFE76O/PGCidfQ+yw89VbctA4K8NRhk
	 WFW1r4zZ11jHGj6lJ2Z5Yq/2GdvKaM7kPmebXBD75pSMQpzEVWPqsQoIZ3FHnqRRBV
	 MzyKz4gSkCbB8WO69GAcKS9MKMmUthRztFm3smpStQ6pF4DiE+Yytw+XG5nUSZHfXz
	 82adXvdVkutHp3nacu8YpMy7XuxtYQ0gLC2Z9NDBxtzuXIUqkgODEDOrTjfM2Xt2VZ
	 ZOXIuNbAXNdKw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7EBB8D8C977;
	Tue,  9 Jan 2024 02:11:04 +0000 (UTC)
Subject: Re: [GIT PULL] x86/entry changes for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZZvcx3N1KxL2GBb8@gmail.com>
References: <ZZvcx3N1KxL2GBb8@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZZvcx3N1KxL2GBb8@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-entry-2024-01-08
X-PR-Tracked-Commit-Id: 1e4d3001f59fb7a9917cb746544b65e616b5f809
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2fdbcf715a1b9dd1468317f7cd4b4cd327a09781
Message-Id: <170476626451.5897.11139030238925460916.pr-tracker-bot@kernel.org>
Date: Tue, 09 Jan 2024 02:11:04 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 8 Jan 2024 12:30:15 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-entry-2024-01-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2fdbcf715a1b9dd1468317f7cd4b4cd327a09781

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

