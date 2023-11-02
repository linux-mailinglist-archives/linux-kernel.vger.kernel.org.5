Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777F77DE92E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 01:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234352AbjKBABf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 20:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbjKBABZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 20:01:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBD510E
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 17:01:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 059CFC433C7;
        Thu,  2 Nov 2023 00:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698883280;
        bh=mCxDYGios1GP2bUsZU4vUlVFM6mDneQhL3Hpf86hB/c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OwQ532yuYl6ybv/7yPmdbdGsVqDwawXdvZq9YAhzrTVND6v/ZmhQzmloEa9O81oO1
         LAmXz9UoWLVNit8JearJ1XqBuoQSpZOWda0qq3ZwIb4jrAj7eYVP7blsNLoItIFpqZ
         qjUR+JpCi0La0rNPS7jJKGRIj1fKZdorRjnaxnb1OiIohUK6+ZHWqYiPAkSR10xD/D
         88QiCux4dHKDLzdz7Sb22s6CJuTqS9pCN9g2AcsCQzxfkE3PEQu2abJJVNEwY0d8Qj
         4Euk6IuCgU0A/aQ8ta2yW7bMc619xKK/ZIgteoDZUL0zHeG12BjypVGkuQrA/efFkl
         vWn/y4IwRgmuA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E8E80C3959F;
        Thu,  2 Nov 2023 00:01:19 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping updates for Linux 6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZT-46QZiN8b37Swy@infradead.org>
References: <ZT-46QZiN8b37Swy@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZT-46QZiN8b37Swy@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.7-2023-10-30
X-PR-Tracked-Commit-Id: 36d91e851598a9ea523ad4681dd11fa661d59695
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 009fbfc97b6367762efa257f1478ec86d37949f9
Message-Id: <169888327994.31464.13950085084685736255.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Nov 2023 00:01:19 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Oct 2023 15:08:41 +0100:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.7-2023-10-30

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/009fbfc97b6367762efa257f1478ec86d37949f9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
