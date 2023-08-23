Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4BC7862B0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 23:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238130AbjHWVln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 17:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238567AbjHWVlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 17:41:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D4711F;
        Wed, 23 Aug 2023 14:40:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A772762505;
        Wed, 23 Aug 2023 21:40:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CCD1BC433C8;
        Wed, 23 Aug 2023 21:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692826852;
        bh=OJoinr9NasZYSHUKzxf+4iL/gfReFtLllCtMGAVmrOI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Hu1XR/+Q+AjfLfdaw6xMOWmMh79wDdKRy88b1W70G/KTtZnywpWd980mMeN5D3on7
         XSj/r0rCr96FSvMV4SMtqXguZz796wMLONjQURPOh9E9YmLZo1jM6dSk7K0226TH1G
         n/2b7fl2C8aitepsu7dru3cUagkn9Vb5yFDQqm7i3qj6M3668dezX3HnmpG2KbJy4p
         Rv3YGJaKb4VOU+1tf0YApIL9fzIITxS60fCl5xQuvHyuwumyhNVwi+yl6Vqi8BX+ub
         z1RMeUemm1MQp3vbdShaXGU6PSRMitWYcS7wgk/Ku/nwMVT/Eqx6uctpdfb/PcMKjy
         /8+b7UG2hySKQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ACD6FC4314B;
        Wed, 23 Aug 2023 21:40:52 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fix for v6.5-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gGifSL5e30wYj7kRfAuzYerAH1hwkz3j8ayYZ7Y15LkQ@mail.gmail.com>
References: <CAJZ5v0gGifSL5e30wYj7kRfAuzYerAH1hwkz3j8ayYZ7Y15LkQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gGifSL5e30wYj7kRfAuzYerAH1hwkz3j8ayYZ7Y15LkQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.5-rc8
X-PR-Tracked-Commit-Id: 453b014e2c294abf762d3bce12e91ce4b34055e6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 93f5de5f648d2b1ce3540a4ac71756d4a852dc23
Message-Id: <169282685269.21732.1927971752718750893.pr-tracker-bot@kernel.org>
Date:   Wed, 23 Aug 2023 21:40:52 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
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

The pull request you sent on Wed, 23 Aug 2023 21:38:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.5-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/93f5de5f648d2b1ce3540a4ac71756d4a852dc23

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
