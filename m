Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66A278E20E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 00:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244690AbjH3WG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 18:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244670AbjH3WGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 18:06:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834E3CD2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 15:06:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BDC09B82453
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 21:40:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B759C433C8;
        Wed, 30 Aug 2023 21:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693431647;
        bh=fKThmz4PGM84EVnB6bUq1TEMZyXXCKCdOiRPIaRaFu4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=k/VL9GvEn2pKpyMRNdqh1qblx8wHv61eStc8pjVKF3tf1hyQN43K9fJloQqqtSgXS
         2LZ25nQRYhlZ3YoAvReafzG9Da2sCLIyIhA7DTbEQIeIv3lWu1GpfYb9UxKN67+pGW
         jOhzPjc4CnCyzTTE26Mn5VWQ7NRlQVcztxCapYGWhPHEbPMJb+GfufG2aOVJ0643y9
         BNYaL0QpYIn3Ynwbyy5qfvsYntJebtPON3b/NB42B8FKa0aGzmDwZbmooX+EqSbgIU
         6eA+zlYlNs6XedSitx1JQRV4KRAsi5/uU6Z0uuiLWEMWumDiOvQoIpFQ0nzqB1EjvS
         zY3Cf67VOQa6g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 684E2E26D49;
        Wed, 30 Aug 2023 21:40:47 +0000 (UTC)
Subject: Re: [GIT PULL] sound updates for 6.6-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87msy8hicb.wl-tiwai@suse.de>
References: <87msy8hicb.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87msy8hicb.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.6-rc1
X-PR-Tracked-Commit-Id: 358040e3807754944dbddf948a23c6d914297ed7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4fb0dacb78c6a041bbd38ddd998df806af5c2c69
Message-Id: <169343164742.19418.6174995128768372836.pr-tracker-bot@kernel.org>
Date:   Wed, 30 Aug 2023 21:40:47 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 30 Aug 2023 13:37:08 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4fb0dacb78c6a041bbd38ddd998df806af5c2c69

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
