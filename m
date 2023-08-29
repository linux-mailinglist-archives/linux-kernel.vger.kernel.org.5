Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0662978CBCD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 20:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238449AbjH2SIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 14:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238454AbjH2SII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 14:08:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B25110
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 11:08:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6511C63B06
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 18:08:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CCBB8C433BB;
        Tue, 29 Aug 2023 18:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693332484;
        bh=Ethf8pLsM7fjMHCsA/J5fCOkpKFKsFA1ys2t0PYnwiM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=j6vmhREYKp8RWQFlMJrDBCv1hk+9hStqBAuTvL4HI7XfvQzSA6UHE10rabwov5p+i
         WQOxNiEuX6d9LbQDVeQTz1ggumkYc5D34A8a/mnIe2s5of7UaWe3I51Ud7id6JdQKe
         B01u9fW4m667r5Q3fP/e5WHDrfv9cKeLO8Cj2hyTy6j5iECn7ABw80UpTEoy2KwWVS
         1n4RdUJqjvIaVMboaevD6Bg5TmK7iIkJgWvOHbNmLSDW41GomwpTtZVDWG4n7bJEyW
         U2txl6I3m1eWki9VT49kivoUl54SvYIX7+/w/JYvkfi1ojnuh1DBodHDQk1jx/VYf2
         hjsKMi1pBIOWw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B45F5C3959E;
        Tue, 29 Aug 2023 18:08:04 +0000 (UTC)
Subject: Re: [GIT PULL] hsi changes for hsi-6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230822231822.tck3u67hxgndosnt@mercury.elektranox.org>
References: <20230822231822.tck3u67hxgndosnt@mercury.elektranox.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230822231822.tck3u67hxgndosnt@mercury.elektranox.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi.git tags/hsi-for-6.6
X-PR-Tracked-Commit-Id: 7ebf243a201856adcac240e490596bb908ee5fcc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c35c486c127c7a777982f7cb4ec82b048a9ecfcb
Message-Id: <169333248473.16601.12715233119092458651.pr-tracker-bot@kernel.org>
Date:   Tue, 29 Aug 2023 18:08:04 +0000
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 23 Aug 2023 01:18:22 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi.git tags/hsi-for-6.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c35c486c127c7a777982f7cb4ec82b048a9ecfcb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
