Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4640E78131F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 20:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379550AbjHRSzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 14:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379529AbjHRSz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 14:55:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544943C2D
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 11:55:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6CA161FF9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 18:55:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 52800C433C7;
        Fri, 18 Aug 2023 18:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692384927;
        bh=T2ywlv+BoNgqsmnhsSDk1OSACf9/Hdu88O3TW+ogeyo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=e/UVr11ivhzFi/5qBIdozT8scHrvUVUyRptTRg3kVltSTPSz1deUjEmGes8jWchli
         98ZQcu0Hr2QU6lDFuIK/qUbuw9ID1o0YF3GNoG2+EDNo/mhOJkczbNkVU9pe8stsP1
         h4GfE5/ppgokJzgd0Lr4651LU7TJHX0qAptqrohhdQk1t0ESCJ8eIRz0bJTwykw8gV
         8bLawqwoZ+ylyKsOVnB58luZP7DfL/dHGLMvlqJGisxGAOUNCkIwCz19RVUnS/wuI5
         bpCVVkQ/0f4DIpjLWect9/iPJEigVWyQzvvDeXEk/leYK37jSyPSpdUpROVMldz1QB
         TXKoj94PJIb2Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3AE9EE26D32;
        Fri, 18 Aug 2023 18:55:27 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for 6.5-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZN+3cmX+pGEqCNrb@arm.com>
References: <ZN+3cmX+pGEqCNrb@arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZN+3cmX+pGEqCNrb@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: 2f43f549cd0b3164ea0345e59aa3958c0d243383
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d4ddefee5160dc477d0e30c9d7a10ce8861c3007
Message-Id: <169238492723.16005.6149246747690619238.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Aug 2023 18:55:27 +0000
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

The pull request you sent on Fri, 18 Aug 2023 19:24:50 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d4ddefee5160dc477d0e30c9d7a10ce8861c3007

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
