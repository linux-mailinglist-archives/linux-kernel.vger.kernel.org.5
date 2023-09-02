Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B2679045F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 02:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351463AbjIBABG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 20:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351440AbjIBAA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 20:00:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16B6E7F
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 17:00:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65B13B826B9
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 00:00:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27D84C433CB;
        Sat,  2 Sep 2023 00:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693612852;
        bh=j6368SGGCT5955CBrDnXY50NE0Ss5DNSuPNZM6Ponuo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fvxzN/Rqdomc257zsXH0g2FIi2BqWmED/r+yz83/qWW19tnlqG2EkuNXmEnnCJTVF
         7kI1S0vCvh9aZx4OqAOQ5XiN12KANvOGqqWTUmsTK15tUbb8nKXnPtQ0RUx2E9iYul
         4eiQEUaZvQ43PnQ3m6sqtifAuw8EA/6ekf8A1vy9H0QViGoWetIoUBPuP2wvps0Vsb
         5OAs1xc7l0mWx9AZGC4iJqyz2boK1iXqaGzZ/H2mM6Ic0lxIE77S4Yi7V1qdaiYjWY
         l4KLFJNvnzzhb+WbVdTSjqIrWzzNC3hgGeUJElpqdwZXAdQ2CYO1GYmZO2zSqMcmPe
         PxAf2OhdJSiwA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 16557E29F3C;
        Sat,  2 Sep 2023 00:00:52 +0000 (UTC)
Subject: Re: [git pull] IOMMU Updates for Linux v6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZPHw-MSyehz1wF7c@8bytes.org>
References: <ZPHw-MSyehz1wF7c@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZPHw-MSyehz1wF7c@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v6.6
X-PR-Tracked-Commit-Id: d8fe59f11096d6470b5f53739e49cdce67f3e127
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0468be89b3fa5b9249cee1097f1d50314950a2df
Message-Id: <169361285208.26727.10463797394902478198.pr-tracker-bot@kernel.org>
Date:   Sat, 02 Sep 2023 00:00:52 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 1 Sep 2023 16:11:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v6.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0468be89b3fa5b9249cee1097f1d50314950a2df

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
