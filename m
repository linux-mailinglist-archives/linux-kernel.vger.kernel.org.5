Return-Path: <linux-kernel+bounces-18181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0879F8259C1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 19:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9FD31F215EF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 18:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B8035EE5;
	Fri,  5 Jan 2024 18:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ranP5ZS/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21A734CFB
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 18:10:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC77EC433C7;
	Fri,  5 Jan 2024 18:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704478234;
	bh=HV2Y664w3mLSdcccQxqpMckpIZZA7fliiX+xduyIYU4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ranP5ZS/0VAQMFjQQAnHEuL3IvGGnV0EEN04s0gf1WClxJpZOMKgVbULhIbpqXUj4
	 cF8noUwaCBoqHwI/TU1tle6v5E4yNulcC56t5NMDj8GZ3GLWUe/6SCb/MkDixzMCqo
	 PJ1xvGWQTuIm1mQ0pxN6vk4PnZ55TEzK/Pf6Yg5WQZjE6AzJfA4sNI8D4YVigzIJZ5
	 YUYx/ChfRn+VGFBuoiIyeqPLsTn/rj+WxVw/BL02NPeJFJ44VpUhIaIQf7HXY8IeMe
	 pAqwdi4SvsRMnKP1j4ASRMyq1Yn0bvRwGZD3cyISpJbNkMFVBnum71zw3DfqMHuFrY
	 NOGBl3ZIG7z8g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9A222C4167E;
	Fri,  5 Jan 2024 18:10:34 +0000 (UTC)
Subject: Re: [GIT PULL] probes: Fixes for v6.7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240105001858.865e3794558a326e146e9c3a@kernel.org>
References: <20240105001858.865e3794558a326e146e9c3a@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240105001858.865e3794558a326e146e9c3a@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-fixes-v6.7-rc8
X-PR-Tracked-Commit-Id: f5d03da48d062966c94f0199d20be0b3a37a7982
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7131c2e9bba7aef8669fc8b21a52de5cf134b010
Message-Id: <170447823462.11319.12754990664222080547.pr-tracker-bot@kernel.org>
Date: Fri, 05 Jan 2024 18:10:34 +0000
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jinghao Jia <jinghao7@illinois.edu>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 5 Jan 2024 00:18:58 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-fixes-v6.7-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7131c2e9bba7aef8669fc8b21a52de5cf134b010

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

