Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402F37D14DB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 19:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377945AbjJTR2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 13:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377936AbjJTR2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 13:28:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA2D124
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 10:28:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65B6BC433C8;
        Fri, 20 Oct 2023 17:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697822889;
        bh=X4QB2lpGaxlWrCqA5AJ7s1WLRSS55GpOzezkfRrRPD4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FKMHC+kCz21r5nO1E2IBtcCyWzPvK9CTBuB0vN/+fh/Kzf+B3fSwNEq0ZVzCQlWXS
         SvoaYJ/BQopLR3y0tWgeGKdcZcpCk4/0dONkSRmoZP0EARtM/OJ4oDFo91jCx9zfyV
         i83dM/bIevhThrg8f0Q4oiqmtRKzfrBNLv8d9RR9d/FP82V4ObZUhyJsq7GOOcZ8i/
         gFH3R7xwUHAkvLqFsTC1IgU3FX4KDMTbWlJDU0XlrpLIDjihvcH/smVTZzbkhqcgAB
         x6NPbhiM7rUhJT8QBQd9+5BX/ldyK2dMgKxpWbdtGYY+5D7mEqf5qflfNmRsPmfDmv
         4mRU6qLO7cL9Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 53566C595CE;
        Fri, 20 Oct 2023 17:28:09 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.6-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <877cnhjry3.wl-tiwai@suse.de>
References: <877cnhjry3.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <877cnhjry3.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.6-rc7
X-PR-Tracked-Commit-Id: 8e13caa2150b5a1287a1900952d3d7e04363f921
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 14f6863328164a9e66024bce5f2fa27de7dc00f0
Message-Id: <169782288933.8382.9586565169394139044.pr-tracker-bot@kernel.org>
Date:   Fri, 20 Oct 2023 17:28:09 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 20 Oct 2023 16:20:52 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.6-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/14f6863328164a9e66024bce5f2fa27de7dc00f0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
