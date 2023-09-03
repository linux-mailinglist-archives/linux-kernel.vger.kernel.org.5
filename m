Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBBCB790DB1
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 21:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347056AbjICTXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 15:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236599AbjICTX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 15:23:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A1A94
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 12:23:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 992B3B80B78
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 19:23:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5AFD0C433C9;
        Sun,  3 Sep 2023 19:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693769003;
        bh=Ui+RyGgc3ZP4WwB++wTdPi3Hn2/N80MIK57evN2LOb0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jQFIIhIWTSfseYGkOtQXCGxLj+/amfb9/p6KFvClIUKvERLnv8rWnMBvSMEEDNDdm
         lrKBycdJ4ooswtpDO+m7j38pBzPc/fdr2Gx0DfPzhXHHcJAqpabQe0St4Zq0GX3nDd
         ULxJ8biL5aLuSyrniD6ws+boE4oAfo3QdC4sitJxS2skmeJyOIfNvU3QGvFX/42oJH
         uKF4zfuKKjPTbCfP2zQkiiSXIgA/vxcZTzsFXntqKWBOfGbSu2a/4OcQfpBVPDA8z5
         HLlZgui7Sdz5fHkGYcxsLF95Hb8taZoWPFgetsU48bhVIJdufirUkKPf7R28/Cg+Fd
         6py7sMHF8q/Xw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0BB68E270FB;
        Sun,  3 Sep 2023 19:23:23 +0000 (UTC)
Subject: Re: [GIT PULL]: Generic phy updates for v6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZPTCrHYAUP/+wXJ8@matsya>
References: <ZPTCrHYAUP/+wXJ8@matsya>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZPTCrHYAUP/+wXJ8@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-for-6.6
X-PR-Tracked-Commit-Id: 691525074db97d9b684dd1457fd8dc9842a36615
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: db906f0ca6bb55b7237b880e06ec2fc95ab67e16
Message-Id: <169376900286.24971.4284709829775992503.pr-tracker-bot@kernel.org>
Date:   Sun, 03 Sep 2023 19:23:22 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 3 Sep 2023 23:00:20 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-for-6.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/db906f0ca6bb55b7237b880e06ec2fc95ab67e16

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
