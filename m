Return-Path: <linux-kernel+bounces-2751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6A2816151
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 18:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF0DE1C22047
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 17:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C8C46BB6;
	Sun, 17 Dec 2023 17:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUpEutvr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C75746541
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 17:38:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A2DF2C433CB;
	Sun, 17 Dec 2023 17:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702834726;
	bh=5ymQK8OIcGq4aXUPem88vOEdBH32YS/9zd6rF7SqaFM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mUpEutvrqAsJG9aWhdCpPEZM1G3lkvbgwWMuRE7+iLCx/8SNxclYs9wtuDEwmY9Bg
	 AjJZseVHXneb2k505rgoGbytwAZQ+RIkzcIVOZRFnQ8Kb6e0jMnJRON8H7yC/OKsAp
	 4AFSpAgbMJX5il5TQK/Ki0lldBzgWCg2o4djrni4vbmOm93w/p2sWl7cBdWU7W0gUd
	 BWVHusbfgs4/mrOZAiBPMalKIPWS+XTwNRt7nHZAj61OKb2ujn0AmFIyT3SI6egDOb
	 Rm+Q2J+kMKTxzuNCgJpnv5qqb1V2m7P5Ni9be5Fu6avZlL1mRvLumVtW5IQVvPRTNS
	 DgvUceaAKO1lg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8DBCBC04DD9;
	Sun, 17 Dec 2023 17:38:46 +0000 (UTC)
Subject: Re: [GIT PULL]: Generic phy fixes for v6.7
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZX8nzO8SuXpTV1dQ@matsya>
References: <ZX8nzO8SuXpTV1dQ@matsya>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZX8nzO8SuXpTV1dQ@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-fixes-6.7
X-PR-Tracked-Commit-Id: 2a9c713825b3127ece11984abf973672c9779518
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7f499ec27ca25c7faad74e15a6e2c72a1ea3e63c
Message-Id: <170283472657.25242.8339591754069465160.pr-tracker-bot@kernel.org>
Date: Sun, 17 Dec 2023 17:38:46 +0000
To: Vinod Koul <vkoul@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 17 Dec 2023 22:24:36 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-fixes-6.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7f499ec27ca25c7faad74e15a6e2c72a1ea3e63c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

