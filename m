Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D57B7ABA72
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 22:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjIVUTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 16:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjIVUTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 16:19:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DAB1A1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 13:19:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 06336C433CD;
        Fri, 22 Sep 2023 20:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695413949;
        bh=ogdSmeQi+oa8oqkW86zG5GceT/xvuV6+KjXSOe4lBZ0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ug/2BmfBAaUCSgBunwRvez27a3Jn4Z/LKAtfoulEkS9AKFPhzsJrl6GLU+ZMe1YXX
         DoksDCbkQKeCmpVZelcTr39vZcsgWt0XMy3trafwRkvqTQSWE7IkjyBBzEI3tG15wZ
         +uuOPIrI4iMuAT32PGmnI6xTCNepjNOHCk22Ad1VQEoydTK19GNQveQfrVzMM5d/bX
         efHdrzxEXgVceaPAk/P+GLJDiE6mHn4oCBSLpBrAdKA2qAuvlCvKv25dPYR3HxsI4G
         qJ2fLlTfwskHX5hRr/8zNGQ59rY4w7YdGS5y0ovjB7OalDKLFLMXgXp+1Hr3bBk2IX
         J2MNenyywfYNA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DFE2BC04DD9;
        Fri, 22 Sep 2023 20:19:08 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for -rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230922161907.GB23332@willie-the-truck>
References: <20230922161907.GB23332@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230922161907.GB23332@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes
X-PR-Tracked-Commit-Id: 44a5b6b5c7fee5146572b4c57f0d9d9c398d1033
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 36fcf38152d8f163850831d52199adea4d6d9518
Message-Id: <169541394890.8311.17511653089977025605.pr-tracker-bot@kernel.org>
Date:   Fri, 22 Sep 2023 20:19:08 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 22 Sep 2023 17:19:07 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/36fcf38152d8f163850831d52199adea4d6d9518

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
