Return-Path: <linux-kernel+bounces-22748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFEE82A277
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A22EE1F23682
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F03651007;
	Wed, 10 Jan 2024 20:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mHMwFkGL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790D651C3E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 20:38:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 50889C43390;
	Wed, 10 Jan 2024 20:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704919125;
	bh=1r5k0bLV+cuzim+kekNMBpccTVBN1yLgMZyYKkNFgp0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mHMwFkGL9qrj++Re6j4q07XL4+go495Aj/K3w7VMjlSO5dnnyGkW5Qdv6znSffvAS
	 1eHaP4shgtQaTphMbmrkQYiIwLbfiwR/6ONN+bWcNEkD2jqQyB4CzC7052ckXoVu3C
	 2Zv/yRIitp3KOaFvzoY93CqG1JwvanHJsNtvicD31tKJLcnvgTy6qmPyv+CGqZrYck
	 az16lGsmut/PyHnOb5hxvdvv9f9h6vqBzDGxBkMVYjR729+op2m6Css/0yJsO2Oe3N
	 ksPLw7q26Sey7ej0iAQFynwamVZ3VobauAVgy9Poef/8+LONeHpxtcU+4rMRSz4vZW
	 M1GEjdr2afRfA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3FE8CD8C96F;
	Wed, 10 Jan 2024 20:38:45 +0000 (UTC)
Subject: Re: [GIT PULL] jfs updates for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <6d22d04c-07a8-40b7-9f29-6862a48f070d@oracle.com>
References: <6d22d04c-07a8-40b7-9f29-6862a48f070d@oracle.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <6d22d04c-07a8-40b7-9f29-6862a48f070d@oracle.com>
X-PR-Tracked-Remote: git@github.com:kleikamp/linux-shaggy.git tags/jfs-6.8
X-PR-Tracked-Commit-Id: a280c9ceeca73fad22af79b08b470fc7126cf1d5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 032500abc5dc7add035ad5bc8eddf67e97f686b6
Message-Id: <170491912525.22036.9972924584728088326.pr-tracker-bot@kernel.org>
Date: Wed, 10 Jan 2024 20:38:45 +0000
To: Dave Kleikamp <dave.kleikamp@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, "jfs-discussion@lists.sourceforge.net" <jfs-discussion@lists.sourceforge.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 8 Jan 2024 09:45:05 -0600:

> git@github.com:kleikamp/linux-shaggy.git tags/jfs-6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/032500abc5dc7add035ad5bc8eddf67e97f686b6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

