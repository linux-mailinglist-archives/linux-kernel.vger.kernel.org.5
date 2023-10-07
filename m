Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63547BC9B3
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 22:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344147AbjJGUOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 16:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343782AbjJGUOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 16:14:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54D1BC;
        Sat,  7 Oct 2023 13:14:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 67E9EC433C7;
        Sat,  7 Oct 2023 20:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696709651;
        bh=r8YPN/InWGmKUZHjbOzGQzJdmasY6fpsO3Odc4dBKFA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=aWkNn2i4mVYkAZxRGWmnd1Ho2W8661UsARTc9bniKx2Kw+ITz+MrbTaAI98WhToYk
         ulTTi6FtKCBFKX+rTm5ukem2WpNtUyGSfesikXMldTN6DsPA+D41TLnWfLtqvCDsC+
         fnCjJgX5eX58+M90tBy4G9spIJ54G9OP9BpIPiI1D2byPk1uY4UPUS+oLxhXY6IsCl
         94R6RcHHj7LKTHkYDg4NSmSor98ZwOGAtEJcoJiHBmBu30KeoO36oOqMK35lcXSD2d
         ogtZcs0P/dcZS09/Mrx/ryhmUn21l0rOsofq+mXA8ahv9vYi2wjycIXQFZNhHztwK/
         5ZqJmUl7Rz9rQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 55014C41671;
        Sat,  7 Oct 2023 20:14:11 +0000 (UTC)
Subject: Re: [GIT PULL] parisc architecture fixes for v6.6-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZSGpG0hwU9O5S9vD@p100>
References: <ZSGpG0hwU9O5S9vD@p100>
X-PR-Tracked-List-Id: <linux-parisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZSGpG0hwU9O5S9vD@p100>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.6-rc5
X-PR-Tracked-Commit-Id: 914988e099fc658436fbd7b8f240160c352b6552
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b9ddbb0cde2adcedda26045cc58f31316a492215
Message-Id: <169670965132.5032.6796898628901651255.pr-tracker-bot@kernel.org>
Date:   Sat, 07 Oct 2023 20:14:11 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 7 Oct 2023 20:53:15 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.6-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b9ddbb0cde2adcedda26045cc58f31316a492215

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
