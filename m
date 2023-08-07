Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E26773027
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 22:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjHGUKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 16:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbjHGUKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 16:10:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53936E79
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 13:10:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DDBA0621DA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 20:10:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51D22C433C7;
        Mon,  7 Aug 2023 20:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691439019;
        bh=AQ/UwNSjDPT073KIx3hUybRU6+hnKna9JZpZVfyAP+c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IiB+6XwffchuGoEnLnxcscVfEKAepPBVIVV4JiRQia/mL+8mVMnatnHcjC/c5qOrD
         kzzDvyToNNx/7GscvZHN7nZ8MR4+SFuo320yF0gtqrzh4x56wGUg6+CROjdnOeRcA2
         X2d9vax4kv+uN8BKIl+v6AmQL0JbV+QTHiGJmFwYmrtQ6xpIzsVXgI0/EJU/xBN+mJ
         N3J6yLHRKHGO9rzr4aQc8VJ4UquwxyNNbxBReX1ZkRb2pMGxsoqVwM+UA6HmsrUxse
         cZj4xF2LUzHEHdVGK4SqU2PwyP0W3bmCKadCCni6k7BaS4jMQZCY0JUKJYTzP7WJ9c
         tLraajkXp3gUg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3EC82E505D5;
        Mon,  7 Aug 2023 20:10:19 +0000 (UTC)
Subject: Re: [GIT PULL] workqueue fixes for v6.5-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZNFMpjyxtKhnLrdK@slm.duckdns.org>
References: <ZNFMpjyxtKhnLrdK@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZNFMpjyxtKhnLrdK@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.5-rc5-fixes
X-PR-Tracked-Commit-Id: aa6fde93f3a49e42c0fe0490d7f3711bac0d162e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 14f9643dc90adea074a0ffb7a17d337eafc6a5cc
Message-Id: <169143901925.15707.6712657407215240756.pr-tracker-bot@kernel.org>
Date:   Mon, 07 Aug 2023 20:10:19 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 7 Aug 2023 09:57:26 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.5-rc5-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/14f9643dc90adea074a0ffb7a17d337eafc6a5cc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
