Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044E0791EF6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 23:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240318AbjIDVNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 17:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233615AbjIDVNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 17:13:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D628212E
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 14:13:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7413E616B9
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 21:13:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D83E7C433C9;
        Mon,  4 Sep 2023 21:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693862016;
        bh=74HqmvkMSIvimYlpTKK7PqmbZSuQM9xNV2zjp/lyW4U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DhlfxAq1w1vLPZ3EWlznuWa3ZXM3kuxdg8NM2SGPknlRH1fmmvHu/3f6xDMTtomMN
         h5I1UXOBPtDfHRhhjPPO4medoyiI3oolk8Fo7/VqJ/KdEa9KqVBoLGynuHqAxNzbKI
         nvOtj2s8J1VZv3y2ihaoXC0348jDnWpzfwpIBqSwTVYuHZQiMVH66zX/6xHSU2AR93
         PUvm0gqb/2E7EmbfPGXUU1okZSiWw4lcjFg6x8fcowJnsVSoDx5l4ZdqoVH+a+rdSQ
         Ol6JEpAyJ2k76ycSuMzvV8U/vWt619fDHsi8ae/9TRoOhG00yNlRJqlyC1VVhJV185
         IfPRd5RWPiuAQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BBE51C0C3FD;
        Mon,  4 Sep 2023 21:13:36 +0000 (UTC)
Subject: Re: [GIT PULL] MFD for v6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230904140444.GA13143@google.com>
References: <20230904140444.GA13143@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230904140444.GA13143@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-next-6.6
X-PR-Tracked-Commit-Id: 9aab92bc3a8922d4b2e24d10271dfe3034cbf5c2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d8723062a26b17080d89e6b4d360ba50d1e453dd
Message-Id: <169386201676.29740.16174834129666867553.pr-tracker-bot@kernel.org>
Date:   Mon, 04 Sep 2023 21:13:36 +0000
To:     Lee Jones <lee@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Lee Jones <lee@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 4 Sep 2023 15:04:44 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-next-6.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d8723062a26b17080d89e6b4d360ba50d1e453dd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
