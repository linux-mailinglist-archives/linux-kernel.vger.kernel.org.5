Return-Path: <linux-kernel+bounces-24274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F288482BA22
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 04:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87CA61F25F4F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 03:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7262622095;
	Fri, 12 Jan 2024 03:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOEtFr2h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB48022078;
	Fri, 12 Jan 2024 03:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 343C7C43399;
	Fri, 12 Jan 2024 03:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705031426;
	bh=YJZ6ML1A0RE9FhlS+qdtiqNQjCB51NLmM0gDMt179TM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IOEtFr2hJzqiWHFouMAIoTDRe59YRZKhnFGAm4axzyG1Giu9X+y5uzxO7NXe0PpjQ
	 GVUSDMVKUFczL93LOQmJuIZ96cwqxe7ToyVo2dx7xcbJw45plLIktu2tC8kzcdlXlX
	 sr1XuTXqfhRxOuWDNc7er+HPaLepAOGfvQImRdwOMd++uF6Bat/sgQwGrky/vmumy4
	 Urs0zwdJ7rJzvFt/6nbjHAZibg9LhnhqNMKYo6ShUjiYa3QigYuvXc3LNGOW7yevon
	 grhe66NLrv9zGvZA6z/eMsaldGn1Zg9Ls3DGSSAl8HH+DhhKhltvGXWUHCcyWsSmXW
	 E5q8xu+VQwz9Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 135D0D8C96E;
	Fri, 12 Jan 2024 03:50:26 +0000 (UTC)
Subject: Re: [GIT PULL] Documentation for 6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <87sf37vegj.fsf@meer.lwn.net>
References: <87sf37vegj.fsf@meer.lwn.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87sf37vegj.fsf@meer.lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-6.8
X-PR-Tracked-Commit-Id: 2d179e8ac02e33c82c1a314961254353eb5028b3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5b9b41617bf3e1282cc60f07d3d52e62399aa4ba
Message-Id: <170503142601.20435.15974984992469566347.pr-tracker-bot@kernel.org>
Date: Fri, 12 Jan 2024 03:50:26 +0000
To: Jonathan Corbet <corbet@lwn.net>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 08 Jan 2024 11:59:24 -0700:

> git://git.lwn.net/linux.git tags/docs-6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5b9b41617bf3e1282cc60f07d3d52e62399aa4ba

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

