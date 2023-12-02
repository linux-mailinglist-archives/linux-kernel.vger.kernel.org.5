Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04394801FD0
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 00:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjLBXwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 18:52:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbjLBXwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 18:52:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBBDC8
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 15:52:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8998CC433CB;
        Sat,  2 Dec 2023 23:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701561165;
        bh=GGIa3n94kqspY3wZ09hTkEhBVKQgLDRVe/WLvBfgyog=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=vKIFlWmWKpyTnv6FAwBIG37v+3D6T5smIZt3Mx7pmhw+sPbseKa4Dyq5e/D6b286k
         8Y7mjMoQ+CZ8k7384R01Y+JIySwCYZSCp/irRr7EtAvlqbcqxajoI5LwlrV1Hfaxp9
         eO1tlkt19UcabFH06nneB9bVL/OLpy0zQwhAaVrcAwXNJkCK3/Tysou3yvxiwD/Spm
         8rtm2nHM/gvtjDn9wbIFzS40CUGzeaGXyl7vjRZ31iIhxVJTnQU1OYSz9wzB3hu/iW
         Q4xliOTzyJTfyYIgzhSxMTzhaV5J/nvFoyuCcswh3SJXG8BKlwmG+m/ESlK6gsadql
         EKWpcSTqw/iOw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 71A79DFAA94;
        Sat,  2 Dec 2023 23:52:45 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v6.7-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231202072359.30587-1-jgross@suse.com>
References: <20231202072359.30587-1-jgross@suse.com>
X-PR-Tracked-List-Id: Xen developer discussion <xen-devel.lists.xenproject.org>
X-PR-Tracked-Message-Id: <20231202072359.30587-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.7a-rc4-tag
X-PR-Tracked-Commit-Id: 7f3da4b698bcc21a6df0e7f114af71d53a3e26ac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: deb4b9dd3b539c8331bbc0d64dff3b4fb57296ef
Message-Id: <170156116546.30388.4620138403094279812.pr-tracker-bot@kernel.org>
Date:   Sat, 02 Dec 2023 23:52:45 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, sstabellini@kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat,  2 Dec 2023 08:23:59 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.7a-rc4-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/deb4b9dd3b539c8331bbc0d64dff3b4fb57296ef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
