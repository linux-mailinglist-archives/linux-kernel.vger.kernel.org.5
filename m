Return-Path: <linux-kernel+bounces-24079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C582382B684
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 22:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EEAE288000
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 21:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D0F5821C;
	Thu, 11 Jan 2024 21:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YR+V/A9U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4ABB5820C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 21:18:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 78C79C433F1;
	Thu, 11 Jan 2024 21:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705007885;
	bh=a5cBofV863Ue/xfQsd7e2vc7yn9BIQzCPrFtLTRIYKU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YR+V/A9UDDD2CMs+LyAwFSb1NmKq1ZxjKtZNahPKqkb4YdzMVB4diRI6EMybmpKit
	 BGAg1Zwxluo01aZ7b+N21QggBHFIZbLp96QY33tKuh0SOoqh8CTgwAsa9xf6bA7Q+o
	 1lUEECM5qiJqSW0Ga75yUBg8yOJKbHXKlPz0FcPfdGntF7RiIqty2BEKOYbuQkjcET
	 tC9ZC6qTdsOdxDRnCiwrkeSYKswX6k4n78p3hDfrfQjIiVn35t6wFUWoCdWIl4SbRV
	 Dt+cG8ntzP1drKfok7pTlJS4SqyVanN7ThKXRKPhS32h6wRjcrZmfdb54hEzOikJPj
	 PojhV1WNZyZTw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5C4F5D8C96C;
	Thu, 11 Jan 2024 21:18:05 +0000 (UTC)
Subject: Re: [GIT PULL] clang-format for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240108014543.525447-1-ojeda@kernel.org>
References: <20240108014543.525447-1-ojeda@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240108014543.525447-1-ojeda@kernel.org>
X-PR-Tracked-Remote: https://github.com/ojeda/linux.git tags/clang-format-6.8
X-PR-Tracked-Commit-Id: 5a205c6a9f79d14db38006aa2d7c4f4e76b1bfc7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2518f39af6ba671964193c249ad1e307b51fd31a
Message-Id: <170500788536.23189.8454658048565660849.pr-tracker-bot@kernel.org>
Date: Thu, 11 Jan 2024 21:18:05 +0000
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon,  8 Jan 2024 02:45:43 +0100:

> https://github.com/ojeda/linux.git tags/clang-format-6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2518f39af6ba671964193c249ad1e307b51fd31a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

