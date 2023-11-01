Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85057DE70A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 22:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343518AbjKAUuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 16:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235431AbjKAUuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 16:50:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16BB11C;
        Wed,  1 Nov 2023 13:50:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 821A3C433CD;
        Wed,  1 Nov 2023 20:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698871809;
        bh=E4bT10Ir/moCMVgRg5+asUaNegub2zZRo8/KT9ELB2Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WbhPYXuxixwKjh32kbWT5DQQG9ZxVlcVYi6J7SKuZdifT/c38R9kngfhVrZSi6zsl
         zQs5PodPUh6pJNL2XyJHLnvZ45V8R8LoRTQPGoAd+nY6a88PaqbD/PjnGM6W6tdVpT
         gn9X0xKNV9Sys5sUAzYSqNKDC/RyWmFxHV0OULx9CClnbJQ8MWe27JojqVShzJ+hyl
         THpwqx4boLKvcpmZwLtp4X2LK5vo1Mg7450qo8tI2hvZlIMhFckALyRBcoxWm5cIMi
         2P3zaNQFFA1tFSWApT4rUbl84J7P6MRUD4oFWzgdrXy6XoT3aoOyXhUgR9QQu648h5
         qf5Fgm0S3tymg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6DBDAC3959F;
        Wed,  1 Nov 2023 20:50:09 +0000 (UTC)
Subject: Re: [GIT PULL] parisc architecture fixes for v6.7-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZUDWhieODHLXVZf0@p100>
References: <ZUDWhieODHLXVZf0@p100>
X-PR-Tracked-List-Id: <linux-parisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZUDWhieODHLXVZf0@p100>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.7-rc1
X-PR-Tracked-Commit-Id: 8a32aa17c1cd48df1ddaa78e45abcb8c7a2220d6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f00593e09968ed6dfcd10aebb13f470fbe3343b4
Message-Id: <169887180942.2957.15590784486647204831.pr-tracker-bot@kernel.org>
Date:   Wed, 01 Nov 2023 20:50:09 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 31 Oct 2023 11:27:18 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f00593e09968ed6dfcd10aebb13f470fbe3343b4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
