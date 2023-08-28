Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD05A78BB5D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 01:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234393AbjH1XKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 19:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234375AbjH1XKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 19:10:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD59FDF
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 16:10:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B77F6178B
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 23:10:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9A11C433C7;
        Mon, 28 Aug 2023 23:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693264232;
        bh=y3OAgGLfECF37MkRUjBXXoWsMhsu0butb6OKRv28sZc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jydiptcpSusWhudNFDaTaPXplQPUYIl39S+LO0xM33kJelRcIc3h8jxG/9fKZ0dKB
         IOkBlsMTeHdsk7g/ld3OJIY3ESikph/DpKpzgfY24kpoTvJX6TttsB733P/wxFMshE
         zA7OB0dyUlm9Z1zoP1MA3yCVjbkHcq7AuY6kb6NsckvOjt6orSv+M/ZYLxh6SBG3RU
         Ia4AzXdVEVbzgqmbnXv2lvkqL0bEQhgtQnGu0BeZp7LXE3wznvSUIWjW8+gzZs6Uxi
         bpXP+mYWkHjA/hJkjQqBcXJjOd327qD/wLBoA2SN2C1c+DfXAQR508SnUkztUpjOID
         gffnOjEyK2YjQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B6145C3274C;
        Mon, 28 Aug 2023 23:10:32 +0000 (UTC)
Subject: Re: [GIT PULL] x86/boot for v6.6-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230828053543.GAZOwyL40QMun5zKU5@fat_crate.local>
References: <20230828053543.GAZOwyL40QMun5zKU5@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230828053543.GAZOwyL40QMun5zKU5@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_boot_for_v6.6_rc1
X-PR-Tracked-Commit-Id: a1b87d54f4e45ff5e0d081fb1d9db3bf1a8fb39a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bd9e99f790f21374b831a7dcf638156beacf3bf4
Message-Id: <169326423273.4748.6496837576990824559.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Aug 2023 23:10:32 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Aug 2023 07:35:43 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_boot_for_v6.6_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bd9e99f790f21374b831a7dcf638156beacf3bf4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
