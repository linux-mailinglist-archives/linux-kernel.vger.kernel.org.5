Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB5E78124D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 19:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379094AbjHRRtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 13:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379252AbjHRRsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 13:48:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81413C23
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 10:48:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 464E3640DE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 17:48:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 91AD6C4339A;
        Fri, 18 Aug 2023 17:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692380919;
        bh=vuyuQ3ZzBx5/f+UC6zHEhN+eXrIt228e9HLy1l6zmZs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=n0M/uftVhywPqyX15JW1kC4lMz9o/w61tisEKtwVmiWt1C6ytWP1woMn1BvcKLp7J
         6JhXGz59pjEU0Xp1HCW/Yx6eSXFBwFYN8XlBCdUnYu3yWyw3SEcZjMDq3QZRFIuMsh
         6u4prOdHM4rPcx5FmvcQo8WzcelO97Ky024WLqygY04o+8yYmJewAHyJ7RutYsS1OW
         oXiWSjO8uADwuxCMlCjsDXtoFDGQEs3z7nT2EhoOKDOvUxaUO1WW+54Ep5x/NS/oyy
         NOuwXNEeMQSHazriuifhYZ2jnUFnYS/pO32x78Ncm/R8mWQMRYX247LI5jZEDgDbLB
         DwIsT24UyvPRg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7FC64C395DC;
        Fri, 18 Aug 2023 17:48:39 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.5-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87sf8gk6l0.wl-tiwai@suse.de>
References: <87sf8gk6l0.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87sf8gk6l0.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.5-rc7
X-PR-Tracked-Commit-Id: 46cdff2369cbdf8d78081a22526e77bd1323f563
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ce03e1807c1f71abcba185e6052cbef250600514
Message-Id: <169238091951.10816.15001210393073852680.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Aug 2023 17:48:39 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 18 Aug 2023 12:06:35 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.5-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ce03e1807c1f71abcba185e6052cbef250600514

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
