Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31DEB75146D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 01:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233251AbjGLX2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 19:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232894AbjGLX2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 19:28:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDFC10FA
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 16:28:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8B81618B3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 23:28:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D2BDC433C7;
        Wed, 12 Jul 2023 23:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689204481;
        bh=N/Ey9tL1E6yCalmA6USBi6aqR7gaUhi+Z10FXcSLYI4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=A9q3XvTZJtbUEBa27N8GfvyZ3Q4W3n6CAiE3hTBYg0neuWdlhx8Q4xI2J1/qcaV6h
         RFM1JqbJIb0QdxV+F3nD4r5xtdOni2WgYzsx1qeLyoeauFh95Fx1v5Si3JTtTo8M40
         E72C+izdpYa3/Y6wRxM44xBhGNaRljCA0B2XNz0deYl9MXsayg6yZJVTzlOqJrXRgF
         JsQCVb1no0cQkHXqHbhF/hUkHNyQMGoV5gPmKyGM08//y4ghrPUdxz32BBzgqrv9AV
         e8OymtLW+2dI6Bt/J6yj6Q8O9dzmme5GgOfSTIbVfpCV+ASuMGrrXv8FTi4+nnP2pN
         vb3YIuxVeEZrg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3D03DC4167B;
        Wed, 12 Jul 2023 23:28:01 +0000 (UTC)
Subject: Re: [GIT PULL] HID fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <2baquyj3auwty3plwz5eazzs4nvpe2phzpatlqblsxxuf4scrr@2ouxku4kw5el>
References: <2baquyj3auwty3plwz5eazzs4nvpe2phzpatlqblsxxuf4scrr@2ouxku4kw5el>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <2baquyj3auwty3plwz5eazzs4nvpe2phzpatlqblsxxuf4scrr@2ouxku4kw5el>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2023071101
X-PR-Tracked-Commit-Id: 87854366176403438d01f368b09de3ec2234e0f5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1d7546042f8fdc4bc39ab91ec966203e2d64f8bd
Message-Id: <168920448123.20936.7901231522403858706.pr-tracker-bot@kernel.org>
Date:   Wed, 12 Jul 2023 23:28:01 +0000
To:     Benjamin Tissoires <bentiss@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 11 Jul 2023 15:59:36 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2023071101

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1d7546042f8fdc4bc39ab91ec966203e2d64f8bd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
