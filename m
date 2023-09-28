Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876C87B2540
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 20:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbjI1S2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 14:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbjI1S2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 14:28:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C33BF;
        Thu, 28 Sep 2023 11:28:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2730CC433C9;
        Thu, 28 Sep 2023 18:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695925685;
        bh=Y99vSndaWpIx6KDR1Ty0eyUrzzn/60G8dFupz2JnQnA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NBKBvaIGrU/a+Mnvoz1El85YUIdurrr+qbIuYHiKsVyxEni9JmDP4IQcnnZIiFCN2
         iDa9abqtUmv+iBMC8HD1ZYlIYpKzpsxw2EBexwLziIXDCW1VUZLDDmukY12h7gHrBR
         LQIRcXCsH4DUy9H+/gdPkl4f5rev2WxPLeTEu3TBi8fraa1QiACh0VmIGu1kAP9N70
         5+rqeTzueCAArg9bsRWk6PGo65zfBeVfNuWjkExfemhy4gu0fFeRvuM9y1JW0+oKMq
         v0zwJ1z3Lu8PN2Dj8dnM0Fiva5E1J3wZCkfeWpfE4ixUNfLJURCWsrlMwsQqkAs/fG
         d2Rf/YACG3/0A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 08F87E29AFE;
        Thu, 28 Sep 2023 18:28:05 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.6-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <eec4dc5364587e55e6564d1cb3b3c40e.broonie@kernel.org>
References: <eec4dc5364587e55e6564d1cb3b3c40e.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <eec4dc5364587e55e6564d1cb3b3c40e.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.6-rc3
X-PR-Tracked-Commit-Id: 1a8196a93e493c0a50b800cb09cef60b124eee15
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9ed22ae6be817d7a3f5c15ca22cbc9d3963b481d
Message-Id: <169592568503.30580.3831640695652178554.pr-tracker-bot@kernel.org>
Date:   Thu, 28 Sep 2023 18:28:05 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 28 Sep 2023 15:25:29 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.6-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9ed22ae6be817d7a3f5c15ca22cbc9d3963b481d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
