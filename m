Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAF47DA863
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 20:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjJ1SH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 14:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ1SHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 14:07:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A038EED
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 11:07:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 47886C433C8;
        Sat, 28 Oct 2023 18:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698516467;
        bh=u029BSArg6DTWpBFupXIZPaIEj10s/9bf7C+dzH1ATo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dWpRb8XZiKYafic1XI/y5+2GsJT6wjtHGJhHEsl9aHSKDUdNT/MIBYR6zAJfZDsvW
         wppqk722MD7axUNh7fnQqkFL/bSdaQxFTOROK1NBItOz/6cOaisCNZrJM+FMSMkbvw
         S0I4bBvJ0Wdn5PgsF0dfatlbnJBSoZCBa4667Tz1NwBJ1OIFU/BGzlfcyfZ8mZ8Kzb
         pc9fRkzi3WLPv2QiACg00GMXxzBMX3Pyto7/lZIbrnMscYGSFISHIBRjC1ZoPT2f2P
         frt/YVfxHJOoTWR+lpc27qwnTIPSfka0owfXwMnpZvvX25mHfHlsQPNNxP6aQJKWFT
         7z6M+c/sw6+gA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 31D7AC4316B;
        Sat, 28 Oct 2023 18:07:47 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping fix for Linux 6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZT0vORvO7dAaHPvj@infradead.org>
References: <ZT0vORvO7dAaHPvj@infradead.org>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <ZT0vORvO7dAaHPvj@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.6-2023-10-28
X-PR-Tracked-Commit-Id: d5090484b021794271280ab64d20253883b7f6fd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bd80d2ef59bb6436effa6b7f77746b1418cf0a15
Message-Id: <169851646719.24400.15210486419229657165.pr-tracker-bot@kernel.org>
Date:   Sat, 28 Oct 2023 18:07:47 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 28 Oct 2023 17:56:41 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.6-2023-10-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bd80d2ef59bb6436effa6b7f77746b1418cf0a15

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
