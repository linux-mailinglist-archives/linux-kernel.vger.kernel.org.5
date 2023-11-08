Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A7B7E4E6F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 02:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344242AbjKHBGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 20:06:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343896AbjKHBGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 20:06:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB360181
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 17:06:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7EFBAC433C7;
        Wed,  8 Nov 2023 01:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699405589;
        bh=rxh4KpNzyOUW+37yXVjLPBdbFqv3mkuq9SOJpX3kcBM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NukyelWrg5qdIeLhQ65HN/NGdkSgLOqFpXpK8l5Ep4oqj5aTyqG1RD1fWzrYeopop
         NTwEAkf/F9metNwjXC0ymNEYZfBuMPUq4wMsQIGpqyGHr4Y81uByuNQfw1j6xwFRR7
         anQWz1uaKXDeHa4s9R5kl9gewWrzGP+Joko7YG9u3DJ5x//+0kuwWtxzSsfhYY84Xo
         zpxwNg1ybyB9jKH02Ldil6bJxrBQV4Q0RL40I/mWSrur1R+mIaksmtk3ScOOThHJo4
         NaiLbnDSrz1OSBH4wTa0WsfCgLvHWjnCkpAf70D2HtodAvdsRmt67z+hlglfbf3iMe
         9n99QBUs49VFw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 65BC3C395FC;
        Wed,  8 Nov 2023 01:06:29 +0000 (UTC)
Subject: Re: [GIT PULL] regmap fixes for v6.7-merge-window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <e3356ba4abdbbb74002a76ea30dd6a4e.broonie@kernel.org>
References: <e3356ba4abdbbb74002a76ea30dd6a4e.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <e3356ba4abdbbb74002a76ea30dd6a4e.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v6.7-merge-window
X-PR-Tracked-Commit-Id: 984a4afdc87a1fc226fd657b1cd8255c13d3fc1a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eaec7c9892bd565ffc7dcd32515b157011ca2323
Message-Id: <169940558940.17903.2409892672161814065.pr-tracker-bot@kernel.org>
Date:   Wed, 08 Nov 2023 01:06:29 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 07 Nov 2023 16:03:00 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v6.7-merge-window

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eaec7c9892bd565ffc7dcd32515b157011ca2323

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
