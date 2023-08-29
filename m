Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3308C78CEE3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 23:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236330AbjH2Vl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 17:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241259AbjH2Vkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 17:40:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340A2CE9;
        Tue, 29 Aug 2023 14:40:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DF016411E;
        Tue, 29 Aug 2023 21:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A65DEC433C7;
        Tue, 29 Aug 2023 21:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693345215;
        bh=TyLCE5qFhDYT/64LyDcZhN0caORly3fLIuK2M85oGC8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Lj2T5IWxEOgv7iobYxl32FYfgKuh+vnf/xkC0mRltDNX3vLPobetZPBcllRZuo5lP
         d7rY1P1upAvZcFG5NzTNNeArOZMkAO3ynq89ukPCKA5iozTpgvC1ZK5Xvss9k/K3kH
         qBd5py8hdulRvm+b/pIOSUVBN5m/IzC994GTqw8fRK2esY6pZSzO4vUGBFKhMMgwBZ
         qIupPj14LkWLf3ojSdlljuD0zL7F7ZsxHA0h3a+rY0o29xKzv0SG2bq8IvgoYGFr89
         WHI+LYKhWwoOUJkooNK5tzCHoPq/C0j92D2ruax1aPbKHpGe46T0NgDcPBsf0d09N3
         1Lqki1XSUoJIg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 942BEC595D2;
        Tue, 29 Aug 2023 21:40:15 +0000 (UTC)
Subject: Re: [GIT PULL] MM updates for 6.6-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230828184251.bfbc164280503903eacf498c@linux-foundation.org>
References: <20230828184251.bfbc164280503903eacf498c@linux-foundation.org>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <20230828184251.bfbc164280503903eacf498c@linux-foundation.org>
X-PR-Tracked-Remote: https://lkml.kernel.org/r/20230725094013.2dfb0168@canb.auug.org.au and
X-PR-Tracked-Commit-Id: 52ae298e3e5c9be5bb95e1c6d9199e5210f2a156
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b96a3e9142fdf346b05b20e867b4f0dfca119e96
Message-Id: <169334521558.2962.16707550970682972285.pr-tracker-bot@kernel.org>
Date:   Tue, 29 Aug 2023 21:40:15 +0000
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Aug 2023 18:42:51 -0700:

> https://lkml.kernel.org/r/20230725094013.2dfb0168@canb.auug.org.au and

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b96a3e9142fdf346b05b20e867b4f0dfca119e96

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
