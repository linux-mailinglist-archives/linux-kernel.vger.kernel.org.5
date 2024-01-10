Return-Path: <linux-kernel+bounces-22746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1147D82A272
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B31E81F2393E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62E551004;
	Wed, 10 Jan 2024 20:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3UFhGS+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D9B50264;
	Wed, 10 Jan 2024 20:38:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6376C433B2;
	Wed, 10 Jan 2024 20:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704919122;
	bh=2mjKkzzOYlSCKt8mUe8FGqAqfeRkSi7ACiFLdUYfWlI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Q3UFhGS+DZ7dHKqVMsru8b4mKypabksC2QEfTYxj1f17UGoJiS1QgNGe2ZhMn+C2C
	 sIuGXMk9y7/3FQbKp8VHqGYIXb6QJEZp2X/qGDdjsD1yCwNF4Z4YnlZsfE1uFwrMfj
	 u+w8Z+W0zsOo9cnBZfav9AyC8qpNCQzDQx2EqvnJhdBoUuM8OApqPbq4x9uRFi/iRS
	 Q0RKpemgfagjqTCh0+7gK8atAXgPyO7XeJteocwsm8jXqmwzonN0WtwFL6UtZY2xHy
	 ybLkawMGUKj7PgyytzSZo0tdpy16K7EiVq7l/3bsbF+Kzrr5Z0xRmJ6Ww3xkfS0Fjq
	 pO0sHUa6JbQTw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D4909DFC686;
	Wed, 10 Jan 2024 20:38:42 +0000 (UTC)
Subject: Re: [GIT PULL] gfs2 changes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240108120553.4993-1-agruenba@redhat.com>
References: <20240108120553.4993-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <gfs2.lists.linux.dev>
X-PR-Tracked-Message-Id: <20240108120553.4993-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v6.7-rc1-fixes
X-PR-Tracked-Commit-Id: e345b87b0b0444d1c644b0ea15cfb50e88f10b55
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bfed9a92940bae1fbdaad80b82562ce4e122434a
Message-Id: <170491912286.22036.8062770293294752523.pr-tracker-bot@kernel.org>
Date: Wed, 10 Jan 2024 20:38:42 +0000
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andreas Gruenbacher <agruenba@redhat.com>, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon,  8 Jan 2024 13:05:53 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v6.7-rc1-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bfed9a92940bae1fbdaad80b82562ce4e122434a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

