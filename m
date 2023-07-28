Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF5476759F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 20:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234838AbjG1Sjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 14:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjG1Sj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 14:39:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631051731
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 11:39:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01176621DD
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 18:39:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55845C433C7;
        Fri, 28 Jul 2023 18:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690569567;
        bh=o3SsijfdI1phCLJd+KTksYHWEhDO4H+RtJLiigjsY74=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LfaeoHckhnSb5ogiSH8DlD7fvvrZHnc1pUknFPxlfa7E8BB9RlDFe7MyL1vGbUimM
         BUSwC+RRsW0VJYSkmw+CN54pEs2IaSN6nzZ1j+IZKSSNN0Q34mSeuj4CJbkGTmku1d
         iY4ivWQ5Vm+fl1mkjME986OMoplHYFuQdkxbZAvadAnzjacSTZ48BZWHKktDZVxxVo
         gtsDl/aYXjKrUzet2Dg3vXJRO373/ovqQOPk8XOchdaf5R4FASlkkUbxqv8Ky87ygc
         AlPG7hMLqFLbs/DBZypyXyIsvsLG24XnglWuFIIYMEdzHescMXSMi88vyQHLQKZdxc
         hIiWtKGxX/hog==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 40994C43169;
        Fri, 28 Jul 2023 18:39:27 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for 6.5-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZMPj2vX57s2hrNqk@arm.com>
References: <ZMPj2vX57s2hrNqk@arm.com>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <ZMPj2vX57s2hrNqk@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: 003e6b56d780095a9adc23efc9cb4b4b4717169b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f837f0a3c94882a29e38ff211a36c1c8a0f07804
Message-Id: <169056956726.21363.13920848422160460535.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Jul 2023 18:39:27 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 28 Jul 2023 16:50:50 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f837f0a3c94882a29e38ff211a36c1c8a0f07804

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
