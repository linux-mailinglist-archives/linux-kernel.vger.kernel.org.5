Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC64790952
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 21:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbjIBTSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 15:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjIBTSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 15:18:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF4FCD7;
        Sat,  2 Sep 2023 12:18:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34EB560AE1;
        Sat,  2 Sep 2023 19:18:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8E328C433C7;
        Sat,  2 Sep 2023 19:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693682312;
        bh=2t9OaVOAU4X/VPxc0uIvTvEOMgS/9R01uM/8vOV+sC4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=K8mMQS6H3DjtVbvv7d6EQ/cVNiwNkQW18y+yPz8VrPm+dm11fZgPk4lK+fyppENv+
         SWA6MSrvHO2J/bdE0yFisyCvz4ug0lK8nXDJSNiL0EbNAPIIP6+m0SMz5ZeQgKVajP
         ysHAAArp29kvqFuSe7gYD0jPa5HLXSMzBHxvJA6/8MV3/ljPukasjx/YLZhZAcX837
         faGhMxOQEVnsjCGcYfDJctb/QDNxXbEpk+eq4X3fbkr4cBfXqF/y8wYlV+OECgLj9F
         WDC54XAgCRh+FwQ9ZTFr+2dgAWoV0japfBnuPoJqRXJwJqWqCW/z5Zgpzb69iZiQj+
         Ph+s/gcIdPnYA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6DC43E26D49;
        Sat,  2 Sep 2023 19:18:32 +0000 (UTC)
Subject: Re: [GIT PULL] first round of SCSI updates for the 6.4+ merge window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <6908480e8808a2d025926f2ff1f9a2468d1b6bb9.camel@HansenPartnership.com>
References: <6908480e8808a2d025926f2ff1f9a2468d1b6bb9.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <6908480e8808a2d025926f2ff1f9a2468d1b6bb9.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc
X-PR-Tracked-Commit-Id: e03843a0f0bceb7ecff78584b242aad94fc0c64f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b89b029377c8c441649c7a6be908386e74ea9420
Message-Id: <169368231237.25293.3929023886121101199.pr-tracker-bot@kernel.org>
Date:   Sat, 02 Sep 2023 19:18:32 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 02 Sep 2023 08:39:13 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b89b029377c8c441649c7a6be908386e74ea9420

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
