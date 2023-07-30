Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01DFF7687EC
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 22:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjG3U2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 16:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjG3U2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 16:28:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DE4113;
        Sun, 30 Jul 2023 13:28:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A676F60D14;
        Sun, 30 Jul 2023 20:28:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0E1CDC433C8;
        Sun, 30 Jul 2023 20:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690748885;
        bh=XW15IFQlup6NvG3jYCOSt7VDiweeq7S6TMV7Xpg+Its=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jOuxbGs7DdhZDEu0HkAWNHEP9J1Sw853r+qclw4VqT20PKBlndSg1oq8hh7fQJLrS
         ktNnNVOKm1ibmdnSW9mwOzAafHMI/zCKGoHFewaUmLM3KSRzq7R3qR1SgaYVO/jUHs
         mqiV9nGDUAFkgemrpp6MDV2gvDjYfHLcE102t/hQLSRFdRGXlHmQUPWGIYz2ctpCxW
         +3tuPYIcij/lAgfE4FxuJR7l/Wdiupp4Z6behzA5CICg9+aokxRC4P0XIeD6diS3DY
         XBDfx6uwGZB0CHQ8/pRh7ml09FwzqyA4Tu4aZVN83RQf2sm0i70VhR0ClT1mLVCWyh
         VpCp9N2z1Iexg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CF77BC39562;
        Sun, 30 Jul 2023 20:28:04 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.5-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <818b4c905bc295ef7b7e773ff3bbc0c5.broonie@kernel.org>
References: <818b4c905bc295ef7b7e773ff3bbc0c5.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <818b4c905bc295ef7b7e773ff3bbc0c5.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.5-rc3
X-PR-Tracked-Commit-Id: cc71c42b3dc1085d3e72dfa5603e827b9eb59da1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d5bb4b89ac6996fe51a3ab63fdb25e15743e4351
Message-Id: <169074888481.12703.17212012792856602932.pr-tracker-bot@kernel.org>
Date:   Sun, 30 Jul 2023 20:28:04 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 30 Jul 2023 16:58:30 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.5-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d5bb4b89ac6996fe51a3ab63fdb25e15743e4351

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
