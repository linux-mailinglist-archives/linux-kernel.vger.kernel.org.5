Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7767A77AA3A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 19:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbjHMRIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 13:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjHMRIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 13:08:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C02EE6A;
        Sun, 13 Aug 2023 10:08:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D640E60BEF;
        Sun, 13 Aug 2023 17:08:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49732C433C7;
        Sun, 13 Aug 2023 17:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691946498;
        bh=vqzRzGsD+4lAuXPcijag3Op+Qq4bwE8BJXX+RMXxy/I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qErN6LItMhUD3aoJJdII/0dIBujdofMtFHCblin5xUc8+uu10GTawIWurRmZ/OqYk
         8vPJmlZukCYPO8Vey800eZdD7spo4cIjvFxZWxgGWQEzYP1WWZKVH+pRFpw4ftjM9Z
         reQdjYxpMPeMC6LMRlzXUnDmeGG0WlZ63X9ZOQ4tEznyJ1EIyJHvbqBLs+1uQhBjqx
         JY3KBP1NCo9tmVnIkGDzrRAyMnns9pH3rP+aFlB9QGHT/z0RtfsaY6XuOnhHUNSBuG
         WjoiD6xyDL4XkYzVOC73Ma34ZhYe12TaGVwtEzaGMnoBqXMcvuzQdimcuycrcWVMqE
         LD2m3gEM/eLbg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 36A80C39562;
        Sun, 13 Aug 2023 17:08:18 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 6.5-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <4987ff9fa2467bc036759afac47b95c77a415963.camel@HansenPartnership.com>
References: <4987ff9fa2467bc036759afac47b95c77a415963.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <4987ff9fa2467bc036759afac47b95c77a415963.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: ef222f551e7c4e2008fc442ffc9edcd1a7fd8f63
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7308e92756d5891d58e7bcae01a516514583921d
Message-Id: <169194649821.27578.9594304586335451768.pr-tracker-bot@kernel.org>
Date:   Sun, 13 Aug 2023 17:08:18 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 12 Aug 2023 07:45:11 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7308e92756d5891d58e7bcae01a516514583921d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
