Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9074A787BDB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 01:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244022AbjHXXPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 19:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243944AbjHXXPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 19:15:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287931BD4;
        Thu, 24 Aug 2023 16:15:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAD9D64A46;
        Thu, 24 Aug 2023 23:15:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2BCCAC433C8;
        Thu, 24 Aug 2023 23:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692918921;
        bh=q1qRoKFqM3T35QVHRGSxfbO5j++EBRhx/zhr2cPRrBE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HjZBCww4kNH4BHQ7jOVBai1E01oZKLEy0DdWtsgwJvflRDFNLQklpx8TsnPcRDmUM
         Gorard2SwxU0ba8n09DRhwonhzrXwTCOrOhS3pPjK4jPbwK/Yuv9U33Y7VZGcMk17m
         msF5/k4qss2/lepvWt2lIHR8O7desIeQVharHJTyAj+LtCOpHCb4/K/GVjLYE4OJDt
         U2qBpVZiaRo1APO9+Am/Ty8TSf3cFYv0v/4XrNItdBn7LcQMfGHpHpJH7I+lUTskr3
         dAh2+SIlLE60mRn03y7bMDHNYeMfuw475NjoK/Nmc0QXENIpmqxkMvs6atpL31453W
         NQdgbKsPp1FcQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0D286E21EDF;
        Thu, 24 Aug 2023 23:15:21 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.5-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <9a29df1bae4a68227ef337ae9f0a4cf6.broonie@kernel.org>
References: <9a29df1bae4a68227ef337ae9f0a4cf6.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <9a29df1bae4a68227ef337ae9f0a4cf6.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.5-rc7
X-PR-Tracked-Commit-Id: 627d05a41ca1fbb9d390f9513af262f001f261f7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0de5ec446310ddc2fc8d446c9bcd69313e0ce9d2
Message-Id: <169291892104.17835.5529881174011794721.pr-tracker-bot@kernel.org>
Date:   Thu, 24 Aug 2023 23:15:21 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 24 Aug 2023 20:44:21 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.5-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0de5ec446310ddc2fc8d446c9bcd69313e0ce9d2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
