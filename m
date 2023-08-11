Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456067794FE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 18:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236349AbjHKQpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 12:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236089AbjHKQpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 12:45:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8002D7D;
        Fri, 11 Aug 2023 09:45:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E90AB67702;
        Fri, 11 Aug 2023 16:45:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56AD9C433C8;
        Fri, 11 Aug 2023 16:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691772307;
        bh=y8irfhbayHMZCwSi2BNA7YdqtZ4rbEQUHcyNEOZEnCg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FIb6nXyD76CitZsfo7Vm+ZbF53FS/78DhBmqFITpkl2RULLw87O3F8f4jD7GRgS6a
         o61QskqB2yW12LloeR/zGFq3a9y7v/MzUku1FT4SSU63dauho+hclPXZ/hw8wz1plJ
         2yYGwGrKSx/zHT370SshxitaZpR6UBHQBuxeL1I4UnAU4uWpMgXdsUY2Yg/VdMLLc7
         9ZWjrTyen59SSIvZGIsPfoHZIdDcLfNGG3UJidAH4GuSCY0PlrE/JoZIR7ovORhCAU
         5PNckH5+WRjCa4VBSdKhv7EivWfOgX9En4RJ4rZ3kTyWrbwqb0HJPGeJHIhb2ve6Bb
         UAlrDxycRmvvw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4283BC3274B;
        Fri, 11 Aug 2023 16:45:07 +0000 (UTC)
Subject: Re: [GIT PULL] parisc architecture fixes for v6.5-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZNZI1sVFrK97d/gW@p100>
References: <ZNZI1sVFrK97d/gW@p100>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZNZI1sVFrK97d/gW@p100>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.5-rc6
X-PR-Tracked-Commit-Id: d863066e6ce0a70c479a7f618088912ac0ba44ac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: feb0eee9aa3c85aa15e3b60f82cb8d1fae28f2fe
Message-Id: <169177230726.3076.5138334969294889011.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Aug 2023 16:45:07 +0000
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

The pull request you sent on Fri, 11 Aug 2023 16:42:30 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.5-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/feb0eee9aa3c85aa15e3b60f82cb8d1fae28f2fe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
