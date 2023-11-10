Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847427E8366
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 21:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345471AbjKJUFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 15:05:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345998AbjKJUFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 15:05:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81686D1;
        Fri, 10 Nov 2023 12:05:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2AA44C433CA;
        Fri, 10 Nov 2023 20:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699646740;
        bh=ARP+zypkVSUL+VyGDMOYLU8xDKn33Zs5tSzeItDgan4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=X4Gb9liK+yiLkJKaFbthTV1mJcPj2dNSrTMEiPv153r0bvbE4MnrWVTd3HShNFJzN
         QoR+s2p6JJItl1RDuAWyIDsEUU9Kulb6rx8VHwMDkgTvHGDAPm5pBTk8mPyrnxOiks
         Y1RhMs1hjdw1dgSrtqkYegNyfWufvUBClGBufBLQvxRkmUU514TE8YzN+mMr4siqOm
         v+Ac3a7ekjxoeQKLPPAA3cBQHkvp6ab0Lzf90CGSffNUdWmhuQ+WH0PGeg8OoKfmQF
         LdbvfZIvp/p/Cthbs1ItlMGqQZp5UBHGpUc/w6In7Oyoe28UOl4BlNkgLIyoh+wlcU
         v97ALirObePWw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 17D1FC43158;
        Fri, 10 Nov 2023 20:05:40 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.7-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87y1f6q7zg.wl-tiwai@suse.de>
References: <87y1f6q7zg.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87y1f6q7zg.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-6.7-rc1
X-PR-Tracked-Commit-Id: bce36aa682da7ca996d4a02636ebfb6b5f2c3f83
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e1d809b3c5d1d9988350755454747a105dad331b
Message-Id: <169964674009.27739.2966438121797137253.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Nov 2023 20:05:40 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Sound Mailing List <linux-sound@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Nov 2023 10:21:23 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-6.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e1d809b3c5d1d9988350755454747a105dad331b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
