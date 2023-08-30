Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6CD78D2A3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 05:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241977AbjH3D7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 23:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241860AbjH3D6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 23:58:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D882CC
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 20:58:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B07E61849
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 03:58:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73AA1C433C8;
        Wed, 30 Aug 2023 03:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693367906;
        bh=hb4oPX0hdidBwhA+lBxaqsDzN0wS0uaurd/16gGnqXA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=aoR7xLBJhzyznFHSvZ87kgcWvEh8MShTn85HvLf1jrgfR/2UGR1Ojq1c5q/gLnFUa
         Y1kfdUALdHDX2Noxd2msD/y73OCevEKiquxIhGAKyhShqvDvXExeKsHgh6DhVeJWZR
         NPVo+yyC74V83k1Mv+QY3eXSIfVdQK7mfFUr19vhEC4kSxNYFrmGva4k/DzyISnxgm
         vhgel5ja+RIsuhg21Jm+RHXnDEFVlfWQ42b2MIx6+G2F4YIw2cXEs7IilgghrGTH7x
         940EowdbvHF6hOMl8AZBnOQh7uHGX0iIMo5PcB7iKGb64OlO17EyRj5p/cqq6hfEvO
         kWqczVqrtQDwA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6394CE29F34;
        Wed, 30 Aug 2023 03:58:26 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping updates for Linux 6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZO4NUZ+k4Q4zPu6X@infradead.org>
References: <ZO4NUZ+k4Q4zPu6X@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZO4NUZ+k4Q4zPu6X@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.6-2023-08-29
X-PR-Tracked-Commit-Id: d069ed288ac74c24e2b1c294aa9445c80ed6c518
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6c1b980a7e79e55e951b4b2c47eefebc75071209
Message-Id: <169336790640.6268.18249090273820297966.pr-tracker-bot@kernel.org>
Date:   Wed, 30 Aug 2023 03:58:26 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        Petr Tesarik <petr.tesarik.ext@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 29 Aug 2023 17:22:57 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.6-2023-08-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6c1b980a7e79e55e951b4b2c47eefebc75071209

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
