Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6FE7708C5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 21:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjHDTP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 15:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjHDTPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 15:15:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B8CAC
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 12:15:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E05462104
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 19:15:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D95CFC433C8;
        Fri,  4 Aug 2023 19:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691176552;
        bh=BTDmvF98QBBNdLFLZxQgPplXlHOWc41jczuAih7K3dM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VjPK5a4D/Sm2mSMjc+SrHxH7qcl73djH8HPFehkSa6G83uOu03R/uwDX8wp951The
         eei2nuQQMexaaGlnPlG7Wivc7bQBDupYyGL/+ObNn2WdY+2HGkxrZepanUWRiG2PsX
         WU4ex8wnSGX29RZWFvssvW1D3z78CQ3mXSar8EaA9ekSUeWu4f+Z6njl9qJVEdfFqn
         qj6FLIBswYJHbzKhZe0mw3vP6Dxljl3ngp8bWXktT/NRZ+iqMR5tocgfFBNVEasdgc
         iURznPIZbtXy6IjjIGcTcdrOGdBqgwO1CERjspSo8YoaoFJp7g5yihT/P4Kdp1rCMk
         0pa1XDZ4XYFZA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C2F7CC43168;
        Fri,  4 Aug 2023 19:15:52 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for 6.5-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZM1J35gT1jjr96Vh@arm.com>
References: <ZM1J35gT1jjr96Vh@arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZM1J35gT1jjr96Vh@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: 69af56ae56a48a2522aad906c4461c6c7c092737
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e6fda526d9db2c7897dacb9daff8c80e13ce893d
Message-Id: <169117655278.26898.8565972763430081977.pr-tracker-bot@kernel.org>
Date:   Fri, 04 Aug 2023 19:15:52 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 4 Aug 2023 19:56:31 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e6fda526d9db2c7897dacb9daff8c80e13ce893d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
