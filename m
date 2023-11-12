Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A147E9237
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 20:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbjKLTSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 14:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbjKLTSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 14:18:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD89258E
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 11:18:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 63D03C433C8;
        Sun, 12 Nov 2023 19:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699816691;
        bh=YCASNaA9apHrWV6XvNG2YqzSqL/8KIldQaaqwKBZ+ro=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=F47AzYfOn+nHjmt3Jf95efOfK5jZ3Rw+qHtySAYGyP8aXX0NgdbBfpEmAQyuBoR+T
         WMYwM/tZ7lwYikPZ5RZwJkQvtFec8PJHtcZnV3e77WVTh4hSgTgk5uc0BoiiZFq55V
         aeUwqveKVScFZ6uKYDDaIEFyqZqniXYTahXwiebhtuukCOaPDFuNr1URpFSORTPTzs
         iiX6p4Kh3Z3QktHOYI1bPdsGu3EbM5xBpFwUmvNJz4XGgTMhkQepLO4Ht3sLdO++hE
         DHd64aG2qAhMMdulBpQaL48J5CLkYWY2/ihFY+99VqaiFd5cMznfz6vVETCycgq5vl
         wVfw71JhLSMpw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4FB96EAB08C;
        Sun, 12 Nov 2023 19:18:11 +0000 (UTC)
Subject: Re: [GIT PULL] LoongArch changes for v6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231112051248.272444-1-chenhuacai@loongson.cn>
References: <20231112051248.272444-1-chenhuacai@loongson.cn>
X-PR-Tracked-List-Id: <loongarch.lists.linux.dev>
X-PR-Tracked-Message-Id: <20231112051248.272444-1-chenhuacai@loongson.cn>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-6.7
X-PR-Tracked-Commit-Id: 1d375d65466e5c8d7a9406826d80d475a22e8c6d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4eeee6636af819454d7c43702e77ec7857a63000
Message-Id: <169981669132.29349.8417024851700164619.pr-tracker-bot@kernel.org>
Date:   Sun, 12 Nov 2023 19:18:11 +0000
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 12 Nov 2023 13:12:48 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-6.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4eeee6636af819454d7c43702e77ec7857a63000

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
