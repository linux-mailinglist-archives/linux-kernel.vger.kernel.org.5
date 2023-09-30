Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2BB67B42E6
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 20:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234713AbjI3SMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 14:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbjI3SMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 14:12:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE17D3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 11:12:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A83B4C433C9;
        Sat, 30 Sep 2023 18:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696097534;
        bh=rODG9meJvQQKVZQq3SEU3TKXsowFJwEyJ6gP61XYwFs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cheQi4FWKv6Gvd7ZNLn7/ad7lyo/FJ2C6BX9mgw/gf4CosD7aKbRGtPKqliWBvHNk
         QGJTSgB/zDdIxeaSAmmiMGZaJKzuQFQ797U64TYDjx5ev1YAcg4mM8zqXpyrbt9tyN
         GLjfUd3NvWTYYHYwUx3TkDEf0NGg6C2oNJRQmb4D7/MUy8kjZadogwP2U1thAOAdOY
         1tbvHHYW6W560kRpFVvU3OhIgUD+PtK/OzRXloU4YnN4ihI4QyZPt6zui409qAhruX
         pPhWB6jDjL5dkCwJrbYsrvbWJ0XoGWJ+IrYUP1c8N1BQac7oswIPFaBJ3rgmwPxO2q
         mTcHoveuSPRNQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 94837C395E0;
        Sat, 30 Sep 2023 18:12:14 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping fixes for Linux 6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZRhZrvxhAf78PgAt@infradead.org>
References: <ZRhZrvxhAf78PgAt@infradead.org>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <ZRhZrvxhAf78PgAt@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.6-2023-09-30
X-PR-Tracked-Commit-Id: 2d5780bbef8dbe6375d481cbea212606a80e4453
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3b517966c5616ac011081153482a5ba0e91b17ff
Message-Id: <169609753459.20440.4990827339784432932.pr-tracker-bot@kernel.org>
Date:   Sat, 30 Sep 2023 18:12:14 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 30 Sep 2023 19:23:58 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.6-2023-09-30

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3b517966c5616ac011081153482a5ba0e91b17ff

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
