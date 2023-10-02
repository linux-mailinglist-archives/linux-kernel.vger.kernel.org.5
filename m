Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C9E7B5C84
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 23:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjJBVjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 17:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjJBVja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 17:39:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F651AB
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 14:39:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AAC89C433C7;
        Mon,  2 Oct 2023 21:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696282764;
        bh=ndHudXxfpkFVThd9Wgq9YbeY/Bk5VGTSkZo7dmn2Lhc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dWlvBgh7WMDf2Hnu+fdKBOL+WXajVwzlBF8J+ndRbdzPCeAVBga2RPkqaVvbvqQan
         91AZ+BYcxy77Mgx8EaMDBuLW7LSEccboQheEqB/wrh2/H1BEzoyjdJxR5q+gldVBvY
         KYaZg8IvUYx4/HZ0+EMHUA7dR7B4nPXveL/m1EUECfA/S6qygb6oyFq83rSJNlmbKC
         nSgJ81QagbnDwFZQ9eT0SPg953hqNXht4Zomv9NmMtjrlVquiElm16p1gYo4GbpFMf
         i0dPcqGUkZkEIFHYb3bXnSRtpukirpNcDOnmNfWCGRAjh+JaW1NzMo7nm4/nVZgSI1
         Lh02i1AEVCf2g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 98133E632D0;
        Mon,  2 Oct 2023 21:39:24 +0000 (UTC)
Subject: Re: [GIT PULL] UBI fixes for v6.6-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <764987343.25592.1696244076263.JavaMail.zimbra@nod.at>
References: <764987343.25592.1696244076263.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: Linux MTD discussion mailing list <linux-mtd.lists.infradead.org>
X-PR-Tracked-Message-Id: <764987343.25592.1696244076263.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/ubifs-for-linus-6.6-rc5
X-PR-Tracked-Commit-Id: 017c73a34a661a861712f7cc1393a123e5b2208c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ce36c8b149873b50f2a4b9818eb3dcdd74ddd5a3
Message-Id: <169628276461.9367.12359946752946294729.pr-tracker-bot@kernel.org>
Date:   Mon, 02 Oct 2023 21:39:24 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 2 Oct 2023 12:54:36 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/ubifs-for-linus-6.6-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ce36c8b149873b50f2a4b9818eb3dcdd74ddd5a3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
