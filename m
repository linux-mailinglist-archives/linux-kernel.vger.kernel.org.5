Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037CD7DDBAB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 04:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbjKADuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 23:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjKADuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 23:50:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1A3A4;
        Tue, 31 Oct 2023 20:50:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36D54C433C8;
        Wed,  1 Nov 2023 03:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698810604;
        bh=WjZPYbBK28m7Y4iYjINd+iZIDdVK/iMbF60VEJ4S+N8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XHpu20iPhbpjkfMEs3EEm9o2R09PRJK1hFVN4zRQ8LMRkb9vycdz9Gx274WEK+7bH
         xc/kp+p5kUqDntyniXf++symGNTQOOQNIXKz3vhUPpBmZTo/R/hmYEsbWXuLuQ+0En
         mJeVKoCmumz7OAVPusP8KenGQi5S+s4bjTr+mI0LwxtkK83g9RrDaOH4cG6QRZHHS3
         fp+oL/4gwpapqpq9UeHJ0VwLl1JQ4H+s9wKfCwe1wVrjDwH9PQqPDrxCt6rQd+OQIy
         7VjYnY1rZe01ADBKnUh8CFFIf38UjzrXHULGDPgQC7OgtX4pPnpfPtVsV1E3ZxL7oz
         V70QjVFIs1dtw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0FC5EC3959F;
        Wed,  1 Nov 2023 03:50:04 +0000 (UTC)
Subject: Re: [GIT PULL] SPI updates for v6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231030133445.45062C433C8@smtp.kernel.org>
References: <20231030133445.45062C433C8@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231030133445.45062C433C8@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.7
X-PR-Tracked-Commit-Id: 1b2e883e1af895b62808b044ac96b77e7c9017b1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 34aac0a33de21ec6e03b689342c0933a4989fbc2
Message-Id: <169881060399.15630.9490558263515140228.pr-tracker-bot@kernel.org>
Date:   Wed, 01 Nov 2023 03:50:03 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Oct 2023 13:34:36 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/34aac0a33de21ec6e03b689342c0933a4989fbc2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
