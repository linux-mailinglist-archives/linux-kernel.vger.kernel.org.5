Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3BE767983
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 02:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236248AbjG2A1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 20:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236157AbjG2A1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 20:27:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C05D2D61;
        Fri, 28 Jul 2023 17:27:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 135EC62220;
        Sat, 29 Jul 2023 00:27:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7CBE2C433C7;
        Sat, 29 Jul 2023 00:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690590431;
        bh=RpY+2EEJvHm1/Z1xR2Z3I7RBDch/iGy7zj22x4Nl7UY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=sSZqSogw9lmQB6cWQdDZKc+3AMlG+y7I+3bP0q0OhyP8fGniiDp/9rk9Go6H336jS
         xASS33i6gR+i1amB3e8/cqwGGvjgFcm2QaVieDXVjOh90pP+4C5t9N4mqQvpcafnm+
         F2KBCRDT7s4XUF0a6Xd3U+KuSFcP+XEs1C+eNR8l7IQmqOEwJBS9ohvpGJePg6A6Q1
         onvR3DpfAfNs27a1IYXaB5eCPV3EZZ5L4N0EubkR3x4xX/EQghcbGybAnZeZLnCQV2
         R46hpNoaFeqMGk3hmOJWkxZCSyrVsxLZXVtME98EHAvQkgyluSIyeo2208o4e30G1O
         ACOA6v57LTmhg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 67262E1CF31;
        Sat, 29 Jul 2023 00:27:11 +0000 (UTC)
Subject: Re: [GIT PULL] hwmon fixes for v6.5-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230728195101.3112946-1-linux@roeck-us.net>
References: <20230728195101.3112946-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230728195101.3112946-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.5-rc4
X-PR-Tracked-Commit-Id: e146503ac68418859fb063a3a0cd9ec93bc52238
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2f4effd85fe9228a21bdfd037be006aa9bd7a617
Message-Id: <169059043141.2110.4340521749430053827.pr-tracker-bot@kernel.org>
Date:   Sat, 29 Jul 2023 00:27:11 +0000
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 28 Jul 2023 12:51:01 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.5-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2f4effd85fe9228a21bdfd037be006aa9bd7a617

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
