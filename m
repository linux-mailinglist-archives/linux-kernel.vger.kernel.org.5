Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA117675A3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 20:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbjG1Sjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 14:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234124AbjG1Sja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 14:39:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8E41731;
        Fri, 28 Jul 2023 11:39:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BF9D621DD;
        Fri, 28 Jul 2023 18:39:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 903F7C433CC;
        Fri, 28 Jul 2023 18:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690569568;
        bh=y+UeJBg95KXiSFCWh5eZlmTP9R2h5xpIFf8GCIVD3ek=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MILudJSvmvZvJPveEoWoNut98zvSk0yAl7yQpq7ItPPpzEgARmbn1CEixb7K98x+6
         GSkvXKnAN5HQpVtbI7Oe4EV/dP/YV6+BC4oeYBUaKJo0jMqA8SFgF0fCtnUcR1v/4d
         /F2xhwdXv7WR3pXGO8nPrJvcEVE3OPPIM0dtfM7rw4A6ZTvIvUN6LMdKghrGolavTF
         sATyRTb8dPAhxUCdGAx6KiNS5kxZ9q/wyhX+9gVlqB+IX1uPgFn9eHo0id4q7pDdew
         ag7QcW/Ccb8yyXcG9S9+N0BBYuDggE8ze4VbecAGVZgkVaooeopcdx1tGIfxNmx7uf
         n5/6B64Q7a4uw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7C3B0C43169;
        Fri, 28 Jul 2023 18:39:28 +0000 (UTC)
Subject: Re: [GIT PULL] Ceph fixes for 6.5-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230728163347.176178-1-idryomov@gmail.com>
References: <20230728163347.176178-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <ceph-devel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230728163347.176178-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git tags/ceph-for-6.5-rc4
X-PR-Tracked-Commit-Id: 588159009d5b7a09c3e5904cffddbe4a4e170301
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e62e26d3e9ab89a0d40f94b237676b7e540d6d5c
Message-Id: <169056956850.21363.4526144975511238715.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Jul 2023 18:39:28 +0000
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 28 Jul 2023 18:33:46 +0200:

> https://github.com/ceph/ceph-client.git tags/ceph-for-6.5-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e62e26d3e9ab89a0d40f94b237676b7e540d6d5c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
