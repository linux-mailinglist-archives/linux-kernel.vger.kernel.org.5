Return-Path: <linux-kernel+bounces-17356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03492824C37
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 01:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16F151C22673
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 00:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D479F1C02;
	Fri,  5 Jan 2024 00:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwPc/S1V"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B482119;
	Fri,  5 Jan 2024 00:43:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EBEE4C433CA;
	Fri,  5 Jan 2024 00:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704415407;
	bh=0ALR9i5u4x8CEja2JA3sxpvqLGsyenbxpiX4V7hmgPs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gwPc/S1VL3sfYT46lahjXxp89FCPU3fVP53s+NoWmNyMlPVnRmkkHq+IlM/RzPOmQ
	 3q43CNSWVzMdewu9kwDbuINVK6VfNzYQXVAcRFp0Tepp1T5KbZ2vB/Kj2OZDDoqJmm
	 SUgphRTBU9NEIyV6dj4r8lk4gtOF872LMG8JazQYzynlYEcA+qnQA3t76sOwzPpE6v
	 cZgwHI72m07f4JLeE0IhO6FpbeLZu6MdQYw+34IoD4jMxNLc4IOeFU36AHyxV4H0yh
	 7T5HuZMpW4tziYCFymIoAAFEBNdLBffLs0N1wayuV1QYdaO2Q7pUD627FgU6IJqo6+
	 O5BkO05g0DpYg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D8585C4166F;
	Fri,  5 Jan 2024 00:43:26 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.7-rc9
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240104182252.1963951-1-kuba@kernel.org>
References: <20240104182252.1963951-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240104182252.1963951-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.7-rc9
X-PR-Tracked-Commit-Id: 4c8530dc7d7da4abe97d65e8e038ce9852491369
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1f874787ed9a2d78ed59cb21d0d90ac0178eceb0
Message-Id: <170441540687.16491.16965051525476963960.pr-tracker-bot@kernel.org>
Date: Fri, 05 Jan 2024 00:43:26 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  4 Jan 2024 10:22:52 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.7-rc9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1f874787ed9a2d78ed59cb21d0d90ac0178eceb0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

