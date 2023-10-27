Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D243F7D9D4B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 17:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346252AbjJ0Pqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 11:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346188AbjJ0Pqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 11:46:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF9D196
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 08:46:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9AB0CC433C8;
        Fri, 27 Oct 2023 15:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698421600;
        bh=ICLLe1P77YEAbgrIOoWuE9i17o0dtIBIQ75UB5huibA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ZDTnFlK4AbT+APoNSgbezl3RmYPzkFiqGlT/3/mA5YLCulanGCLii6z9KKH3KxtzW
         8EaC3QWCO9F/glv3Nnc4rohPNTFQmheJVaBwLaEsSDlZDbrSZJl/84pYRC1QHeJWwH
         0hXf+radWVkbaaK25lltiBMqhrXXiqN4yY42qElbgclz1wyt8cLCm7OCjFhehP5VZU
         g60pzTiDUiVH8xbzJkKBpcuNaDUZcHVFuXtd+ndVM6b/NDhaC/p902tYbDNeLwA/wf
         LmrErmYIKUKXJgwASI7sRTGp6DH/vmhs0kJ5ucWHUnoCv5Qwd4iJx1rcZ3utGfuiHH
         uLiC7hHnfL1Pg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8997EC41620;
        Fri, 27 Oct 2023 15:46:40 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fix for Linux v6.6-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZTtwNUIIenr5xRPO@8bytes.org>
References: <ZTtwNUIIenr5xRPO@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZTtwNUIIenr5xRPO@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fix-v6.6-rc7
X-PR-Tracked-Commit-Id: 6e6c6d6bc6c96c2477ddfea24a121eb5ee12b7a3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 888cf78c29e223fd808682f477c18cf8f61ad995
Message-Id: <169842160054.21759.12836632651981604416.pr-tracker-bot@kernel.org>
Date:   Fri, 27 Oct 2023 15:46:40 +0000
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

The pull request you sent on Fri, 27 Oct 2023 10:09:25 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fix-v6.6-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/888cf78c29e223fd808682f477c18cf8f61ad995

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
