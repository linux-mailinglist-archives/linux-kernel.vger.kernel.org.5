Return-Path: <linux-kernel+bounces-24080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 430AF82B685
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 22:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D26C22856B8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 21:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB4A58221;
	Thu, 11 Jan 2024 21:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFqpMxW2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5F358211
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 21:18:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6C7CC43390;
	Thu, 11 Jan 2024 21:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705007885;
	bh=X7u71L9U4ktY210M4G3Y7DeaXkgd400JKRllxaAlG6I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dFqpMxW2FaEzuXRp4ndkbUkSxSZn+vtF1HGCK6W3HfTFR5/1e66I/d7Uo/JZRvdzI
	 eaSoayoG68hb726iYIbxsVjhfIE5adT8EU+fm02EMhOJGkeoi5KCkAZn+dup1gXoM0
	 EqurrvjRwprclhEJnT2YvoP2KDezWNSEP7d2aHSYH1GtrD20moBBForH+ooU7VzeL+
	 K6N327YW5CxbE+SbNljIQ4tSeIP/yn8Qn4uoPThElvMtEeDykyuabtCzSnRWBHWyiV
	 H3u2Cx4BgNECNx37qO7PmCHajl1HHkP4jCziyOLluK1VWRBehp70NXhhYOO9JCx0T0
	 OSou0OkY7SimQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8F304DFC698;
	Thu, 11 Jan 2024 21:18:05 +0000 (UTC)
Subject: Re: [GIT PULL] auxdisplay for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240108015531.528189-1-ojeda@kernel.org>
References: <20240108015531.528189-1-ojeda@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240108015531.528189-1-ojeda@kernel.org>
X-PR-Tracked-Remote: https://github.com/ojeda/linux.git tags/auxdisplay-6.8
X-PR-Tracked-Commit-Id: c52391fafcefe4c562bdac62088a2735c185b942
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 457e4f99765cc41d0b90e1385f51b848d6a921d0
Message-Id: <170500788558.23189.3361166117266694255.pr-tracker-bot@kernel.org>
Date: Thu, 11 Jan 2024 21:18:05 +0000
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon,  8 Jan 2024 02:55:31 +0100:

> https://github.com/ojeda/linux.git tags/auxdisplay-6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/457e4f99765cc41d0b90e1385f51b848d6a921d0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

