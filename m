Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348447675A6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 20:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbjG1Sjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 14:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235330AbjG1Sjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 14:39:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E624499
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 11:39:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0931621DC
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 18:39:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3BBE4C433B7;
        Fri, 28 Jul 2023 18:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690569573;
        bh=ee5985S6KrQ/n6+xdUGQVtwY+R5s91pwni1DH5t8940=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Xf5eTwJSynvWpHFgtMo6ScOZ8lVh3yppfdkSI/1xQO1DQqBWnwUtRNfg9aZyjHFqX
         3tyeF/Akwg4VRNttMwkvaTg4fWbk9c+jVNKq06pYHd7X3FNPm/LQIKnZY6vluThm1S
         AZSJOPNS3gDtAOhCR12ojr3yNTYgZbBNrTYadpjUXEVX1sl3CacAg6UHvdrADD1QV+
         ghrPUUUQmwlvoPlrxBlgr0xK9lOBvf+flhZvbme9/cYK/Krl3i4IPauGJNAkkBupoX
         kdpxSh1krKbDrydKpU9UjCL0NsK4uezF7lr2pKrfXoZiJws0tKCTLboL/+2FyeEkzn
         4yvHXWBjzMh8w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 158D4C43169;
        Fri, 28 Jul 2023 18:39:33 +0000 (UTC)
Subject: Re: [GIT PULL] fs/9p fixes for v6.5-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZMMjWSvfFutpaK6t@e8f1df9eb5bc>
References: <ZMMjWSvfFutpaK6t@e8f1df9eb5bc>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZMMjWSvfFutpaK6t@e8f1df9eb5bc>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs.git fixes/next
X-PR-Tracked-Commit-Id: e6ab0b914c12acefbb0880dded48cb930ccab5cf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 28d79b746cf46e48e5c38c6904ea5faac217da21
Message-Id: <169056957308.21363.1664033774331422146.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Jul 2023 18:39:33 +0000
To:     Eric Van Hensbergen <ericvh@kernel.org>
Cc:     torvalds@linux-foundation.org, v9fs@lists.linux.dev,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 28 Jul 2023 02:09:29 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs.git fixes/next

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/28d79b746cf46e48e5c38c6904ea5faac217da21

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
