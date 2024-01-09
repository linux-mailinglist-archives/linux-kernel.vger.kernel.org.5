Return-Path: <linux-kernel+bounces-21432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B7C828F0A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 22:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23A581F21A7F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 21:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4AF3F8C0;
	Tue,  9 Jan 2024 21:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OfRmO26V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB2C3EA71;
	Tue,  9 Jan 2024 21:40:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 37245C433B2;
	Tue,  9 Jan 2024 21:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704836414;
	bh=hig6NXjCWH9GaOKCUc+tVklF45G17+rQSA8RGJ5JmjI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=OfRmO26VQ7a1bby3KiQzeQGx1Nh/X0ImlTmBxIVSPjixo/TrhIeBTTCrQT2fCil6a
	 4LqCbDkS8Ev9cyzKeC6/Fm6lRMw0c8IsNkhHWH2cZ+0pAqpyH58PRLrG5ZfTBQIMEh
	 nTf4mqOSYamYhMK49mhG6HX6RnimKuZeyZUrlzYnII6qHQlnE2pjUCFJ/Z6IXL7vr0
	 Y0kLwXAInfxAXaYkEFaypsoYw2m3VlCHScKatSsSjRNkb4VYXWwTJKwcUyTx2jP6rS
	 IHeyJAIGAp1ViCLFIc6SO0jWmz/EzVnpi4YHN21088tR9m6BHchOA++3mU3HVCxV5g
	 1mjiksewI2YLg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 25F48C4167D;
	Tue,  9 Jan 2024 21:40:14 +0000 (UTC)
Subject: Re: [GIT PULL] MM updates for 6.8-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240108155039.fd2798712a2a93a108b710ce@linux-foundation.org>
References: <20240108155039.fd2798712a2a93a108b710ce@linux-foundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240108155039.fd2798712a2a93a108b710ce@linux-foundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-stable-2024-01-08-15-31
X-PR-Tracked-Commit-Id: 5e0a760b44417f7cadd79de2204d6247109558a0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fb46e22a9e3863e08aef8815df9f17d0f4b9aede
Message-Id: <170483641415.1854.13586582747763064200.pr-tracker-bot@kernel.org>
Date: Tue, 09 Jan 2024 21:40:14 +0000
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org, mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 8 Jan 2024 15:50:39 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-stable-2024-01-08-15-31

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fb46e22a9e3863e08aef8815df9f17d0f4b9aede

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

