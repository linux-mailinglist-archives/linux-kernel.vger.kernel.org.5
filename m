Return-Path: <linux-kernel+bounces-20229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D31D827C38
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 01:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41FB72854FA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 00:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B7753BE;
	Tue,  9 Jan 2024 00:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GEoJ2mko"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F1C4688
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 00:47:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9AA77C43330;
	Tue,  9 Jan 2024 00:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704761257;
	bh=+oQJsokzrxVqMYPC+nqzhJ2yMYPPzZsdywRPOaYw/Ow=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GEoJ2mkoaCfNY5ESgyCtF6QHZmIfhHRoI0C0e2ImzHOnbIC/mHC1iMHdJ3BSKu6Hf
	 W5CZdqp6C+9IVdB9VvOR5Hzdj+KtHincpJNHxjGPelZY6bmerKwvbpV1F/XS0wV/PN
	 JswF07AD3mpX8Sa2/5QVgpnkniQ5b6MtNkqgprpGm3nZMtxbWwFkGmgtB5FxlfzWN8
	 pjoAZB2+AtDoiD6vJZEyFDtASAsS3gy4S9P4Wjox8P4LI51VT+wWT56rZvyBQuQu6Z
	 JXrGQFUJ/wQZSSq2fCGBcG/9hK4xdMzlBnxZLYO6v3miIFtSMKezFaGODyru/jighu
	 WggLE+48NfWAg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8A541DFC688;
	Tue,  9 Jan 2024 00:47:37 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 updates for 6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240105130523.GA9015@willie-the-truck>
References: <20240105130523.GA9015@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240105130523.GA9015@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream
X-PR-Tracked-Commit-Id: db32cf8e280b46726065c518e90761bb0229bacf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ab5f3fcb7c72094684760e0cd8954d8d570b5e83
Message-Id: <170476125756.27312.18057371451596298557.pr-tracker-bot@kernel.org>
Date: Tue, 09 Jan 2024 00:47:37 +0000
To: Will Deacon <will@kernel.org>
Cc: torvalds@linux-foundation.org, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel-team@android.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 5 Jan 2024 13:05:23 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ab5f3fcb7c72094684760e0cd8954d8d570b5e83

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

