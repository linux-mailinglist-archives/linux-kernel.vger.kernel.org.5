Return-Path: <linux-kernel+bounces-22751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 431DA82A27F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D257928DC7F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2121853E1C;
	Wed, 10 Jan 2024 20:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d1z0CzF5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588C552F65;
	Wed, 10 Jan 2024 20:38:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2BF9CC43390;
	Wed, 10 Jan 2024 20:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704919126;
	bh=N9BpRDvSryhH4kv0IA5hBfOiZkNtg9Vwvw+n1H46bW8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=d1z0CzF56AspE9CUIxRY2++HkIzIii+m2Zs1qUW/n+QeKfSqJcu7ycoeMLj/it+0w
	 ncEZFmiYpvbg3JLdaOwWGaq48AdXCOKlKzKIJGAYi5v+RQLFpCI6UdLOPoSZK4jOL5
	 orQdgco3MkQfWUQJZaHNzofU8+sAlKDFZCVd+SIoincKHwJsChAIRPNdypm1LLjGFf
	 KlJllOhS3oj0uDA/Xcbfq/4NMEWfnEUzzydQtpRntoX8AKACVxPw487agx0+gUOY4h
	 V+QiyBBNKlcGWq68cx3+pL6BUqYlXloq/z+tsFdy5l6dxbSonx4l/SYYTHtb0NX8Jo
	 zUy0vf7lG1YEw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 17D02D8C97A;
	Wed, 10 Jan 2024 20:38:46 +0000 (UTC)
Subject: Re: [GIT PULL] tpmdd changes for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240109203514.1511503-1-jarkko@kernel.org>
References: <20240109203514.1511503-1-jarkko@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240109203514.1511503-1-jarkko@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-v6.8
X-PR-Tracked-Commit-Id: 2b6fad7a900d2a378b475e5c196c146fb71856be
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6434eade5dd51f12b464c8dc16633f0f2d26e284
Message-Id: <170491912609.22036.2618625120520329412.pr-tracker-bot@kernel.org>
Date: Wed, 10 Jan 2024 20:38:46 +0000
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jarkko Sakkinen <jarkko@kernel.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, David Howells <dhowells@redhat.com>, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue,  9 Jan 2024 22:35:14 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-v6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6434eade5dd51f12b464c8dc16633f0f2d26e284

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

