Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55997E0DF2
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 06:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378518AbjKDF0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 01:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378510AbjKDF03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 01:26:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4F51B9
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 22:26:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC675C433C8;
        Sat,  4 Nov 2023 05:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699075586;
        bh=TFCRJsn5dNBGpsbNnM7YvdrnbApMBm+mR1YYLNL4r4g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=u/Wm1vdoxnrxAsbX7SOhru77xIMYLRmWqIj7npq5solt0Vl9QeSR2yL00Gkbf9EP4
         I6ByV2mIgJrVAmn5uggqzfgPenCsgR0hDVgvnXADz/2pVbjnecRMDhND/59A2nNTTB
         ZjfenpvzCRLz/rb3ISvUEuEtTy7D90Xc5J1laFg8FKPdnvwZSCI4xPnWEb05zpbt7x
         N0xgt7XiGNj/tbpdE0AldAHY/aPCMIcULbiJo59enDGXGcv47cQAAHQ3ZwjNp/e3yJ
         4vWUfVI/qBvI2S/eLUl0q+kAv6Ex52aMKB4ZIzKNjYxd7OMGmo9wNnllwwbwXTLVU2
         yRCgoV9/5V+Sw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B440FC4316B;
        Sat,  4 Nov 2023 05:26:26 +0000 (UTC)
Subject: Re: [GIT PULL]: dmaengine updates for v6.7-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZUTkosu6RDwHOg2x@matsya>
References: <ZUTkosu6RDwHOg2x@matsya>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZUTkosu6RDwHOg2x@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-6.7-rc1
X-PR-Tracked-Commit-Id: 03f25d53b145bc2f7ccc82fc04e4482ed734f524
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d934aef6bb9ec1b42dfe1f5c1f945fa0d2d0752c
Message-Id: <169907558673.8300.15291462991499421032.pr-tracker-bot@kernel.org>
Date:   Sat, 04 Nov 2023 05:26:26 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 3 Nov 2023 17:46:34 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-6.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d934aef6bb9ec1b42dfe1f5c1f945fa0d2d0752c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
