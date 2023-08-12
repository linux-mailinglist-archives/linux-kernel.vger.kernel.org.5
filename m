Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7B4779CDA
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 04:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236905AbjHLC4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 22:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236810AbjHLCz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 22:55:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB40930EC;
        Fri, 11 Aug 2023 19:55:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51A1D64910;
        Sat, 12 Aug 2023 02:55:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BA8FFC433C8;
        Sat, 12 Aug 2023 02:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691808958;
        bh=Kw/Lh1GcDwTAc/SW9sKfCCi6oXvuikO3jzTENvfwgKE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=foFuNZZvlpkcq67d4r3+HneQ58ah2YlJcAu4+2C1IIoBWPGYkyAkQgSlMt5EHm072
         FOqXfmJWJPW+3AcEomp9gMoDOzvqN3y128fThjeGPDT5TFmscEle9uguhULHUiTx+C
         iY0K3KuZ+/+htkKwf6Q17Be1xRAqhIGbTDTMg7NvDSTCpXc8tUxTTm4VsqQGRXt96K
         DVoBmF4CozUi6V7faIRIKkHRktyrdZtUi+1bHDvEsFOxQ2r9lga1QYT5W/yCM7Jdq5
         RXJX0DfoEVwBJZFD6Q//Vydrz5kByNnKDu7Z9PrWGgwIZWeZVwhESScI5taDgb7++5
         CGbSNpw7ts1Aw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A9BC7C395C5;
        Sat, 12 Aug 2023 02:55:58 +0000 (UTC)
Subject: Re: [GIT PULL] hwmon fixes for v6.5-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230811230142.2291484-1-linux@roeck-us.net>
References: <20230811230142.2291484-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230811230142.2291484-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.5-rc6
X-PR-Tracked-Commit-Id: 56b930dcd88c2adc261410501c402c790980bdb5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5512c33c7b942033f772db56be46d5de9493deae
Message-Id: <169180895869.32599.3117991925692857269.pr-tracker-bot@kernel.org>
Date:   Sat, 12 Aug 2023 02:55:58 +0000
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 11 Aug 2023 16:01:42 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.5-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5512c33c7b942033f772db56be46d5de9493deae

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
