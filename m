Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C557EF473
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 15:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbjKQO3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 09:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232335AbjKQO3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 09:29:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D854DB8;
        Fri, 17 Nov 2023 06:29:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 704E7C433C9;
        Fri, 17 Nov 2023 14:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700231342;
        bh=KtNleCXbmP6oXopuazabM9x52Jwj6RVFAnlsBSL12JI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=SKlHt9+CcOFZEWjrJ/KV7OWbiXcB0nQZmnLUTw51g2rsWfvZkGpDisMT4FP2vp1qV
         4fzYlVQzIF2ABKTAbUX7jj0y+lD7fZDY3jn48eN00rK/tB8owDVP4bPipZEycNpNB3
         uCL8ywjrXP0BGGf2rV5Wks/Ib+O1vdv1oiUA7f4//zFLiR2wI1ZEDKoxO/ALUCyPA4
         ZOL8h0OxD0esM8QuWgrK0S242ERuWxCPaPnE3Pmg8jI2BNQeYrjeWUpdX3VtctDDkD
         5faZ1RRUjH9Bt3E/+H9XyTCXDQVapJDecFLz1M32BKmuiTKC5JbyknF43dEIpcHV+R
         jaBJ/1W5T0qfg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5C7E8C4316B;
        Fri, 17 Nov 2023 14:29:02 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.7-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87y1ewlq1g.wl-tiwai@suse.de>
References: <87y1ewlq1g.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87y1ewlq1g.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.7-rc2
X-PR-Tracked-Commit-Id: 5d639b60971f003d3a9b2b31f8ec73b0718b5d57
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eb9a643c1739b732b90714131962bee76d279600
Message-Id: <170023134236.28622.12659179728111166160.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Nov 2023 14:29:02 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 17 Nov 2023 09:52:59 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.7-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eb9a643c1739b732b90714131962bee76d279600

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
