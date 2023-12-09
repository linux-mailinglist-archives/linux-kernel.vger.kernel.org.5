Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE8880B648
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 21:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjLIUeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 15:34:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjLIUeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 15:34:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAF2193
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 12:34:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 436BBC433C7;
        Sat,  9 Dec 2023 20:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702154055;
        bh=TYueBuMxe1Cd7Vs7fS2FZ4S5BtxUKU1puYqavvmzD7M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qWtbGn3qPTLbfzylBWGgxR1VNxadp6dsxfPtJkx/OIrvuDo+rij6/9ve9D7EDBh+W
         kR9cLMj/p9PlZwDoyXi+Ulwns0ZmD3AnbTcV6NMTiDUaYPc9cwomgjOnIeUynjKS6P
         QUUx3O5oZzpIMZtr432Igt8ARFWXJ0FVKha3eXLwgom7fX3h+BSJYcoX3SH5erPhSW
         Z5npHfmQSdogOfNQ2Kwm61VnIU9Ler0J4zFb2J6kcvRjHiQ1kcPdY0o8DcJeX+Kk/C
         TcRk6cvEWXDqVRzVFGOcKi/OJVrXH295bpF6yWOoSicEP+s885n32vrAtdqc3O9SDX
         SfR7k+Govk93w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3187FC41677;
        Sat,  9 Dec 2023 20:34:15 +0000 (UTC)
Subject: Re: [GIT PULL] LoongArch fixes for v6.7-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231209112317.1542046-1-chenhuacai@loongson.cn>
References: <20231209112317.1542046-1-chenhuacai@loongson.cn>
X-PR-Tracked-List-Id: <loongarch.lists.linux.dev>
X-PR-Tracked-Message-Id: <20231209112317.1542046-1-chenhuacai@loongson.cn>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.7-2
X-PR-Tracked-Commit-Id: e2f7b3d8b4b300956a77fa1ab084c931ba1c7421
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b10a3ccaf6e39f6290ca29d7c24604082eacaea0
Message-Id: <170215405519.1707.5261207253564127214.pr-tracker-bot@kernel.org>
Date:   Sat, 09 Dec 2023 20:34:15 +0000
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

The pull request you sent on Sat,  9 Dec 2023 19:23:17 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.7-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b10a3ccaf6e39f6290ca29d7c24604082eacaea0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
