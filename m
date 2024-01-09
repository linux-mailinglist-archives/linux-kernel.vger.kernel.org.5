Return-Path: <linux-kernel+bounces-21428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2070E828F02
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 22:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46CE31C20CC1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 21:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCB33E49D;
	Tue,  9 Jan 2024 21:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWuLr1U4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F683E482;
	Tue,  9 Jan 2024 21:40:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 20A74C433F1;
	Tue,  9 Jan 2024 21:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704836413;
	bh=jhIdDW5qYTBVSSDFWvMOGAI8nCs4tw8lpe0ZIwpizak=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=SWuLr1U4bunRrgt605wkzO6CihyqFW7J278JTt+/1zJqZ4UP54xOnTy9W0+lx2j+x
	 w2m9D5VoLvJSAtXaieUZdXDJ8UF/Smr4Bb2iq2SVe0hMWZLu3FW2N5jo/aYRr3hF20
	 rPfAy486DXIoVAIvwndxKsYGNYFUK7GWUHt2Uwuh1NckXlE3C225RPIMyQsf0UxHHj
	 qqNW1silCKJY9575KsnAvEdtxEEufstVi1cCQN0czuWEv9CN51BiaXdtYio0hoP2Aj
	 yDFjnr2+jfUmiwWICtlQLhpIGoOzqdvbSQwa5LG3ko5qKD1Ks8zdKn435lRpLOwhoo
	 qn2RBjj+ktZqA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0C092D8C96F;
	Tue,  9 Jan 2024 21:40:13 +0000 (UTC)
Subject: Re: [GIT PULL] slab updates for 6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <a0511a72-711b-4c8f-b9d7-da95681000c1@suse.cz>
References: <a0511a72-711b-4c8f-b9d7-da95681000c1@suse.cz>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <a0511a72-711b-4c8f-b9d7-da95681000c1@suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.8
X-PR-Tracked-Commit-Id: 61d7e367f8bcc8083f02dcc5ce89b98b1480929d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d30e51aa7b1f6fa7dd78d4598d1e4c047fcc3fb9
Message-Id: <170483641304.1854.12542188128449597766.pr-tracker-bot@kernel.org>
Date: Tue, 09 Jan 2024 21:40:13 +0000
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev, Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, Stephen Rothwell <sfr@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 5 Jan 2024 10:36:08 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d30e51aa7b1f6fa7dd78d4598d1e4c047fcc3fb9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

