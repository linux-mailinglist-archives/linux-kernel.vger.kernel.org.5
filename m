Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F7F7E8280
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346470AbjKJTak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346031AbjKJTaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:30:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A6C11416
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 11:28:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7FE64C433C7;
        Fri, 10 Nov 2023 19:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699644531;
        bh=ywUW5j97OHKk1zv7otB3YR/kwql+zwlFhc/cQmlB928=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WbHthTL1QJT4BGB16uJ8F17opGlBrwrUcnoug8roAyP1eFnHN1cFBl6QY+FrukA2Q
         KdV2nsKBBZoFA1TrCxV0PDKUArA2YazWSGbR/hyW4QD1b4V5y9QGj41rrNWOj8ZP9R
         rYdizjZgBVXQOGSrfbOg6F/diPVZIdK7W2gIebFvq1fsfo7RHkGLa/KlvGV9P2W+HL
         xvoz25CXBnJgSXMIZUD5HjRHc+nduZsc4KRC287kfbTf8cRlPa/MZeNHD/9phLHS2K
         yyrqhadrMvJXINs/h9d6qPu9Qs/PP3GsOSQvSyr+HpBp1WPADJbhC6bZxhDTq5CvMI
         u4mzFiHHWkRtA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6BF8CEAB08C;
        Fri, 10 Nov 2023 19:28:51 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping fixes for Linux 6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZU3U759SwIC4Vv-F@infradead.org>
References: <ZU3U759SwIC4Vv-F@infradead.org>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <ZU3U759SwIC4Vv-F@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.7-2023-11-10
X-PR-Tracked-Commit-Id: 53c87e846e335e3c18044c397cc35178163d7827
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 391ce5b9c46ebf23cd049bb552a899dfc0cfb838
Message-Id: <169964453143.4685.3653756585506805115.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Nov 2023 19:28:51 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Nov 2023 07:59:59 +0100:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.7-2023-11-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/391ce5b9c46ebf23cd049bb552a899dfc0cfb838

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
