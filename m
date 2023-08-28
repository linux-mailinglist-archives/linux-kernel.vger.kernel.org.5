Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1A278BAF1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 00:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbjH1WQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 18:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234192AbjH1WP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 18:15:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB67E12F
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 15:15:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4ABFC6178B
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 22:15:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B370AC433C7;
        Mon, 28 Aug 2023 22:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693260953;
        bh=jwLp/tmwo0WjhFaQAuWwruuph3qYUtyD5s/yPx49HK0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tjGQShaKIHqh3P8oDjf4OWPkAAkut03C6Vv89lOb1Br1wDiRvSVjwOCVQGCJfJiCp
         v9Vm6Bp/LqPKBsEFC8b7d28mV4m/1Zq1kKmKUN2zOoGv7jIAEFUAvOH7OKRMimx9CA
         u3AxwbKLVImuFVeRuBQI6Sl7hS9pz7NkZYbyB5PpdDhrs3M7xo5zl6zb65+abnvY2x
         tvg4j44N+dFcHmhKQd77nPNHMDpivGyXfYAOOGwPmGOYovbeW6Ew3lmpqrPKw3grHN
         Ge3PVXX0N/blopCuqub953ts5qnDYkTY5Y6pPnQe8a6s20pufU66q499SK0cMCksG2
         dBQFagyt6vVgw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9F801C3959E;
        Mon, 28 Aug 2023 22:15:53 +0000 (UTC)
Subject: Re: [GIT pull] smp/core for v6.6-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <169322654880.420889.9261217338657613439.tglx@xen13.tec.linutronix.de>
References: <169322654636.420889.373907562030292433.tglx@xen13.tec.linutronix.de> <169322654880.420889.9261217338657613439.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <169322654880.420889.9261217338657613439.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-core-2023-08-28
X-PR-Tracked-Commit-Id: e0a99a839f04c90bf9f16919997c4b34f9c8f1f0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6f49693a6c85e7156d8fde589d9795a01c33c51a
Message-Id: <169326095364.8741.5849016739202545962.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Aug 2023 22:15:53 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Aug 2023 15:01:12 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-core-2023-08-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6f49693a6c85e7156d8fde589d9795a01c33c51a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
