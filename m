Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32EBC788CF4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 18:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244883AbjHYQK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 12:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244146AbjHYQKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 12:10:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DF91FD0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 09:10:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2C7B64AFB
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 16:10:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A8111C433C8;
        Fri, 25 Aug 2023 16:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692979812;
        bh=zQ3BRfw09JEXQI1RBkbWb3+8oFeqLBbeXcada49oDr0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=oP8v2/t07OHJTqtvUDu+nRxUP7kV3sFLCiRBAxZg9txiUUMwdoL9Wv4IZvze2Yjad
         82M2Ft22+AGwpE7aQQ7jFCldUrBx0iZ46QbfQhn7tv7f2dOLZwhXyFP7CdP3kI2iQq
         di2AT/iHX21Rl0iE7oAp6cV2Q/Q6lpzmlG6BYVlnpD2kfjxJ6ZCnWo/fR4DoAmXb9q
         mww2V14d+rtVPDNht8qOQP5dUOKVmluSCH/j0lqjcWJgHlFKVIOs5MHs7wiD2amryt
         kDc52J2g0MfswOJ7Bn9XcFrIs4rw/UekCSmmqbbHfsv+PreyPUvwzRSzx99l8pjCdC
         +HG8VI122dpPg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 95A2CC595C5;
        Fri, 25 Aug 2023 16:10:12 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <875y538qyv.wl-tiwai@suse.de>
References: <875y538qyv.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <875y538qyv.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.5
X-PR-Tracked-Commit-Id: 37e44d60cb875862930359e16a1f4764cedb342b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ced5bf2493d42fe855c224b2ae2ac6545fd91517
Message-Id: <169297981260.24147.1435527325386804883.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Aug 2023 16:10:12 +0000
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

The pull request you sent on Fri, 25 Aug 2023 10:29:44 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ced5bf2493d42fe855c224b2ae2ac6545fd91517

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
