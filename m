Return-Path: <linux-kernel+bounces-25146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC68D82C883
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 01:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B475B23F24
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 00:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C11E107B2;
	Sat, 13 Jan 2024 00:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nV22CbmX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73CCF4FE;
	Sat, 13 Jan 2024 00:58:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A3C23C433F1;
	Sat, 13 Jan 2024 00:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705107505;
	bh=/4QD6IGM7rqcDr7taj1p6wJy2jiV6FU2MzO0WL0hSo8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=nV22CbmXrjhf1Ew++1qd51+BmDPn4IBYWnC9I/wPHGBrC+878fgtAVMbEZF8mgDW+
	 IdrN0ylWvG+tqNnvAgIKQjbkDTq3W/KcfUWHFMUsoXd6n21ilyNRW/kCaKtnv5P76+
	 wPkT4euxkWq13pDstlzXKKzLhl9BKGixxf9HCM3UeXgSfXGvYWCoaO2DJ3oE7f1dOv
	 qyiX+yCy7dPb6i7PowMvW7ooKHTGjmPSpNpgpN0UHvZEvX7+tQ9bGKqqrwIW+9gmV7
	 TqlBpNggIS1WoCBkXFC7JqAXphIOK02FcnxWXvfxqpH6o0mC9PjZBuLF/gxTfmqhzo
	 hQp3gUJj0YrSg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8DDBFD8C96D;
	Sat, 13 Jan 2024 00:58:25 +0000 (UTC)
Subject: Re: [GIT PULL] RCU changes for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231223021434.GA2714@neeraj.linux>
References: <20231223021434.GA2714@neeraj.linux>
X-PR-Tracked-List-Id: <rcu.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231223021434.GA2714@neeraj.linux>
X-PR-Tracked-Remote: https://github.com/neeraju/linux.git tags/rcu.release.v6.8
X-PR-Tracked-Commit-Id: 7dfb03dd24d43b9e7a725e70d2e8a83bb29df294
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 23a80d462c67406303df852d58b745b8618acc4a
Message-Id: <170510750556.1054.15219442074526332796.pr-tracker-bot@kernel.org>
Date: Sat, 13 Jan 2024 00:58:25 +0000
To: "Neeraj Upadhyay (AMD)" <neeraj.iitr10@gmail.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, paulmck@kernel.org, frederic@kernel.org, mingo@kernel.org, tglx@linutronix.de, rcu@vger.kernel.org, boqun.feng@gmail.com, joel@joelfernandes.org, neeraj.upadhyay@amd.com, urezki@gmail.com, qiang.zhang1211@gmail.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 23 Dec 2023 07:44:34 +0530:

> https://github.com/neeraju/linux.git tags/rcu.release.v6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/23a80d462c67406303df852d58b745b8618acc4a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

