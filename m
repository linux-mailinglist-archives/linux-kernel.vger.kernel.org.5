Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB377F5071
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 20:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344396AbjKVTRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 14:17:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344371AbjKVTRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 14:17:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D35210C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 11:16:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4577DC433CA;
        Wed, 22 Nov 2023 19:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700680618;
        bh=V+bcEHuaoT0QO1L4PpY2MsEghTUZNEpjix34EZdyApg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rZj9WW0ex44DdDLUe4dtr+cE5Zc8RXL/V/i0eiQRdwCJH61zVPY0GkGkO/6GeBgY7
         s+jwiE5TjVU11PFWqdxGrvs/7Th7T7BLul83EqutTQLAih22EF1o2e+YVZdpo8StdL
         F4RcudE22Lbx8/Cyg4vHSSBAEPHND6a39QQI7ysM5m8PQG8uL8qoRtwdPK+hry3c7x
         ov92VwKJOp0esc7vFWwUh+/h4x9y93acAyl0JyiZdgQ2ez2jhiQuVfd6kOnU+CDbSl
         QaBUtxGnDZPTtftZKtFQLS1bOHBp0a1Qd36iiMIKfC6kzOj1j7Z8UgpO5BZOYd4eBN
         dOPUJLXyn5RDQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 311AEEAA958;
        Wed, 22 Nov 2023 19:16:58 +0000 (UTC)
Subject: Re: [GIT PULL] LoongArch fixes for v6.7-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231122151245.1730120-1-chenhuacai@loongson.cn>
References: <20231122151245.1730120-1-chenhuacai@loongson.cn>
X-PR-Tracked-List-Id: <linux-arch.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231122151245.1730120-1-chenhuacai@loongson.cn>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.7-1
X-PR-Tracked-Commit-Id: c517fd2738f472eb0d1db60a70d91629349a9bf8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9b6de136b5f0158c60844f85286a593cb70fb364
Message-Id: <170068061818.6718.7703537633390907893.pr-tracker-bot@kernel.org>
Date:   Wed, 22 Nov 2023 19:16:58 +0000
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 22 Nov 2023 23:12:45 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.7-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9b6de136b5f0158c60844f85286a593cb70fb364

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
