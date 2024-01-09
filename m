Return-Path: <linux-kernel+bounces-21433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89427828F0D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 22:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0A3E1C249BC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 21:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488E53FB35;
	Tue,  9 Jan 2024 21:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gsbRRbJw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06AC3EA8E;
	Tue,  9 Jan 2024 21:40:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 95A92C41606;
	Tue,  9 Jan 2024 21:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704836414;
	bh=KKzal4z+PZYtfYvSCTdQuxTaBXkQPDi+REQvj39mmfE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gsbRRbJwypX2ny/9sMQS8aq16o3+G+HlpeRm/TCsmYiRXwMrQ3ScIwdfvD3935yDq
	 g5krf+TnY32XpdKJB+F7470mG2L1+cIx5NNtGAFbfBfwQSwexuq0i9vwTQEFqRMkrn
	 h3DCs0BRnbhLKPdawEwLGkFdg9g4QaVlR4TENbkinWXNYIvKSEtuUgz1+p3U2MnPkz
	 4dXY1lsaAv9tIOJCafu6J7GX/Bc+wxYshpjytlBSyvdHjgGBxWG+oqnXJt7MlExXxT
	 xhG7Ll0Ql2v3hSbUwN1SwQxwtQPE9rnd8eanCsnozYFfmfPffSFFH1e9RcKmTRBUj8
	 OPm6UG54uBYhQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7F1A7C4166F;
	Tue,  9 Jan 2024 21:40:14 +0000 (UTC)
Subject: Re: [GIT PULL] non-MM updates for 6.8-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240109110420.dcdefe80d76257d9ff645a32@linux-foundation.org>
References: <20240109110420.dcdefe80d76257d9ff645a32@linux-foundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240109110420.dcdefe80d76257d9ff645a32@linux-foundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-nonmm-stable-2024-01-09-10-33
X-PR-Tracked-Commit-Id: 6dff315972640bfe542e2d044933751afd8e6c4a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9f2a635235823cf016eb8af0aeb3c0b2b25cea64
Message-Id: <170483641451.1854.7559287361279332962.pr-tracker-bot@kernel.org>
Date: Tue, 09 Jan 2024 21:40:14 +0000
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org, mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 9 Jan 2024 11:04:20 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-nonmm-stable-2024-01-09-10-33

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9f2a635235823cf016eb8af0aeb3c0b2b25cea64

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

