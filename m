Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E23767598
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 20:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbjG1Sja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 14:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbjG1Sj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 14:39:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883F44483
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 11:39:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B32A621DE
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 18:39:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7CCE6C433CB;
        Fri, 28 Jul 2023 18:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690569565;
        bh=MvEhmaMP0NQYXaR+ON9JAVE/AlmQzWiuNidmwMzSgiQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=D5JhO8NvVg/pM9rZrXqTCxYGIZNXztY3Kwy7yycSFalWSG0jwKMQf4GfZsrMMG/c9
         P4zLI61WWjJy8LF/ZbwCTNq6RoNWPkVX5do5W9Gsd+8fngc/7xk59ezSlBLneZd8Dr
         Q7B0EPMwYbKvnzEOmPWro9ylU1e8Ikd0Q1t3/SjDp6TBKBeKoAkvLTgobTOVtkAvnh
         wxeT4mtX5ICbXiolDyo9O3K2jlMHCW86oYdCN4vr2WCb1/YVcm/5vC3gYQSv8ichYW
         IMK7pHVqxN+qEFzDxpvAtGfxMsrqtUt3sEGkn2DOXf3natWeOmswQASuubwiLgXYb0
         J+LuiG3mt5AHw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 693D8C4166F;
        Fri, 28 Jul 2023 18:39:25 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v6.5-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230728131804.10538-1-jgross@suse.com>
References: <20230728131804.10538-1-jgross@suse.com>
X-PR-Tracked-List-Id: Xen developer discussion <xen-devel.lists.xenproject.org>
X-PR-Tracked-Message-Id: <20230728131804.10538-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.5a-rc4-tag
X-PR-Tracked-Commit-Id: c04e9894846c663f3278a414f34416e6e45bbe68
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 81eef8909d171bdca6af37028a11a24e011ed312
Message-Id: <169056956542.21363.18012666636626712275.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Jul 2023 18:39:25 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, sstabellini@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 28 Jul 2023 15:18:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.5a-rc4-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/81eef8909d171bdca6af37028a11a24e011ed312

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
