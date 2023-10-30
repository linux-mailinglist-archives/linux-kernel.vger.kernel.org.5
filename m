Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068727DC0F6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 21:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjJ3UFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 16:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbjJ3UFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 16:05:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A263FC
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 13:05:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CDC3AC433CD;
        Mon, 30 Oct 2023 20:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698696340;
        bh=zKLNWdO7Thoc6gUedujTFEMI4L1tCn7DkndTWEOcYkw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nuHRRVB/HgxDvzq7C39k1uJ3+UX0NJpYn29J2rkgmK9wj5uKAPIS749PKlyZyQODF
         63CfafaADJbDIxL0yti4hUl9kpMQwmqCdM3ZhfmXW+ahiV/BQ6T4Y7UrSfa6PodiXj
         S9WGproJCOUrqe9hQZTw+wy50An2PbhUrnrAomIuCr2FpIVtlJ11nfrEd43T/2foA0
         ZEsuQ+YJyUdQLLcBaejqUViIheuCXu7f3vmqlssxcuqIfdrMFgqPeNUDt8g8wVJ29r
         89ElxQEduUYNz7xh1+D8VMRbNX8LWwZx6LppipkgKeIm+ymrLCz3025QN3t79NGM3j
         vikbjR+cfEO0Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BC3A9EAB08B;
        Mon, 30 Oct 2023 20:05:40 +0000 (UTC)
Subject: Re: [GIT PULL for v6.7] vfs xattr updates
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231027-vfs-xattr-6eeea5632c93@brauner>
References: <20231027-vfs-xattr-6eeea5632c93@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231027-vfs-xattr-6eeea5632c93@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.7.xattr
X-PR-Tracked-Commit-Id: a640d888953cd18e8542283653c20160b601d69d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7352a6765cf5d95888b3952ac89efbb817b4c3cf
Message-Id: <169869634076.3440.4839441545054836819.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Oct 2023 20:05:40 +0000
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 27 Oct 2023 16:44:00 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.7.xattr

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7352a6765cf5d95888b3952ac89efbb817b4c3cf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
