Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A57F768792
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 21:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjG3Tnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 15:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjG3Tn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 15:43:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E8310CC
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 12:43:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA81B60D27
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 19:43:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4497DC433C9;
        Sun, 30 Jul 2023 19:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690746206;
        bh=dgMphorhTuKUz1uJpsrrwVe6OPXrxX06GnIT03JrCTo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mNkVB3fUEydQf0yuYZ7+eJ+P6q3eyHnbTQDgx/ctzu0Di+8XJ5qCUjnkl+9MN/34T
         OWEaooLMghf1YIsZyUUGSTd86a6w/g/gsqVqjTwfyTfhbDTUSo8FH9ZG7Go/l5grCa
         QMxO+lzI5cDe3orypiRAq+EVxh6bPur+xl99EoDh6KJZk8tgKTyGP5If+pEEynOUOP
         scZLOfTD/TdgRYjkhiF3w8CH1D9k1+a7k6EwYRTCc7jXce7B6p6TIQdhMqw5tUHxsP
         OFow4F6sdBz/djg5LKgaemrwQY0qkYDOyrxkZTX1olyJz33qkHmq8a+R6EXIuHT50T
         M8a9yO1AAIIZw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 33EB4C43169;
        Sun, 30 Jul 2023 19:43:26 +0000 (UTC)
Subject: Re: [GIT PULL] irq/urgent for v6.5-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230730091303.GAZMYpn+LlFokfH0XD@fat_crate.local>
References: <20230730091303.GAZMYpn+LlFokfH0XD@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230730091303.GAZMYpn+LlFokfH0XD@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/irq_urgent_for_v6.5_rc4
X-PR-Tracked-Commit-Id: de990908521073d98a46ad0e29885df447e95242
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eb9fe1791ba87ec95a0408b7074f2400459aa1e4
Message-Id: <169074620620.25913.4016419808244609578.pr-tracker-bot@kernel.org>
Date:   Sun, 30 Jul 2023 19:43:26 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 30 Jul 2023 11:13:03 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/irq_urgent_for_v6.5_rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eb9fe1791ba87ec95a0408b7074f2400459aa1e4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
