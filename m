Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566517DC364
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 01:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236024AbjJ3XuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 19:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235990AbjJ3XuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 19:50:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB693100;
        Mon, 30 Oct 2023 16:50:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 76035C433CB;
        Mon, 30 Oct 2023 23:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698709804;
        bh=yE6TPz07cDO8yRD2PpcD18BEK8ueT/K071kpiowAJKo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=vJFs/nHfghpq/cU1KKxbJalV5rB6ouHVcjcXrkG0HYLkYslMJrHCPUWf0Z23Geb7s
         hDtPBRhArOIkzk3hB+tGdWHkP0vqOi546KyOt5LibPCEtKEk6MXFOC41+hGPNVkVPq
         wcl83Wh/fjDFOzr8gPSYqPM4kNY1DENtHFUaI+gZRpFif4N+X8ddV8EkFLkBmAHTde
         b5itA/VSC7AGCHiDbzq99z7XOZOVOh6FlLol0JMNC3mwXkHgK+pd2I6ch0/5si8Je0
         tVZJem+p8fjp6j99D5PHzBaqUg/W6B9ZM0Q+pa1sqEvtMB1MKNrkGRINrDwHWzrsCW
         24inCgdz/voMg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4B02BE0008F;
        Mon, 30 Oct 2023 23:50:04 +0000 (UTC)
Subject: Re: [GIT PULL] EDAC updates for v6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231027100920.GAZTuMUJEP5LI7mZ+S@fat_crate.local>
References: <20231027100920.GAZTuMUJEP5LI7mZ+S@fat_crate.local>
X-PR-Tracked-List-Id: <linux-edac.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231027100920.GAZTuMUJEP5LI7mZ+S@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_v6.7
X-PR-Tracked-Commit-Id: 6f15b178cd6315c997981f76c6ebed7ad39144c5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 66cc8838c72b165048f49f88fc9d1be996abd35b
Message-Id: <169870980425.17163.4367361186365175089.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Oct 2023 23:50:04 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 27 Oct 2023 12:09:20 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_v6.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/66cc8838c72b165048f49f88fc9d1be996abd35b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
