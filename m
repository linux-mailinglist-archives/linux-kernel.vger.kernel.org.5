Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8317DDC1E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 06:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347640AbjKAEyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 00:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347420AbjKAEy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 00:54:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB3BA2;
        Tue, 31 Oct 2023 21:54:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0297DC433C8;
        Wed,  1 Nov 2023 04:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698814466;
        bh=BNmQ1yGJk2sYpGPl8yhPBCxluGIpYLRQ8Af/9zOYCyo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uak5AfGZ3eCyZCEyKcPdgxBmQ5QC9HqfuRhoOxZstRl/UYNYYvw172lQ+Rb71rsz3
         WrZ2apdqoBNqTENxE2F/ZHDc+w2Mygnf1hD17OOpT6yKlQFjg2/S6HJz9c9n8kjFhV
         kch+XTSznRxLV4brlUretxWYu5xrgcbrIu2EUtMIZTV3K30jwfa7xo2zLIs2NEjABt
         dxpwCpUo318VHO9+vrL4j0lAKJ4HDq/l/osTGFMOI2UwAGodgT2Q5YTETMkiH2dYqH
         Wl93zkFBQUxmZVHnUk/rUMLX9JeRXsBG2Wk9F2ZOWtJSlD1g5v+VOe2kiPrnMiQtPD
         3JUi1zMLQH+Ag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E595EC4166F;
        Wed,  1 Nov 2023 04:54:25 +0000 (UTC)
Subject: Re: [GIT PULL] hte: Changes for v6.7-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231031161220.978069-1-dipenp@nvidia.com>
References: <20231031161220.978069-1-dipenp@nvidia.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231031161220.978069-1-dipenp@nvidia.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/pateldipen1984/linux.git tags/for-6.7-rc1
X-PR-Tracked-Commit-Id: fc62d5e214df2dd64f5d675f01b609d86a422a2b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c52894359395ea0a562b3ed556848ed66fbfff86
Message-Id: <169881446593.23637.4546887163521210840.pr-tracker-bot@kernel.org>
Date:   Wed, 01 Nov 2023 04:54:25 +0000
To:     Dipen Patel <dipenp@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        timestamp@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 31 Oct 2023 09:12:20 -0700:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/pateldipen1984/linux.git tags/for-6.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c52894359395ea0a562b3ed556848ed66fbfff86

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
