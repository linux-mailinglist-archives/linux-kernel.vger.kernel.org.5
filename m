Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECAF7DFDAA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 02:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376632AbjKCBAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 21:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347983AbjKCBAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 21:00:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BF81A1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 18:00:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 95B03C433CC;
        Fri,  3 Nov 2023 01:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698973226;
        bh=8iZQj/OHYgwKPIXlhanVZ0XSfbAMKaWjZQmSZUJWjoI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=e6cQ+Y0Ep+AjBfHkPQ9yyrgEcCqoLkzSp/JVZdILesCtSm7dJDUjjDYATIHOj5a0y
         8ypwRNLQssmmjU0SRrB/UoVO8A5Ka9XHP1IqTbjz3xt7MFx0O3JcH44PYJh2H0dX9v
         cdlBr/V6KHG6NXYN6Elbx7qLUzhYpfF/MqoUUCnigkc2xh1aGSg+B61EQ+JcvASmnS
         tB0XW+7dlQhTzZioqUoUyRq4JSWtEJY5roLMTq0w04NdrupElEhWBWXBYstCq1f9zB
         xep1UsTXpzBlb+E4xS24x3WSOnEE+eHsttU5DHviWxnIbdUzbfbZNenuQpW/QkiRf7
         S8GKn6Nrcr45w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 80D65C43168;
        Fri,  3 Nov 2023 01:00:26 +0000 (UTC)
Subject: Re: [GIT PULL] sound updates for 6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <878r7gjlbw.wl-tiwai@suse.de>
References: <878r7gjlbw.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <878r7gjlbw.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.7-rc1
X-PR-Tracked-Commit-Id: dc6e08b1a2ae262c23e14f5c259b4ca63a554e4f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: edd8e84ae9514e93368f56c3715b11af52df6c3b
Message-Id: <169897322652.13409.17241372499063433986.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Nov 2023 01:00:26 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 02 Nov 2023 15:12:19 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/edd8e84ae9514e93368f56c3715b11af52df6c3b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
