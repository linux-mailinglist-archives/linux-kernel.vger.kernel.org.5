Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41495790461
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 02:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351416AbjIBABJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 20:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351445AbjIBABA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 20:01:00 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0A61A8
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 17:00:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 13E15CE2521
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 00:00:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A2764C433C8;
        Sat,  2 Sep 2023 00:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693612852;
        bh=u0VZcwv7N8IYHKjVzAn9p+9vCffx/7wDUC9tF2A3JA0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=E8L8CwNsy0GBwC0NREZSrG1Qz4y9iX2vzpXNx3OYUXwEO9PIo4F3IoHFm9tCTX1Vd
         dbtEZO6TAIucwd4RjMipE0kz2NDxeKlMX2EXYoDNISiUsa40DdvNdE/2dHaFKTAefe
         8rCUppzj4ERYS6Cct43Vg+luPWxQcsEiMuwBI5DcC5kM0RoETnKL6FkQV9TSvzx9FU
         R8u3yGqHYFvUxdFMxCu2JIYf+OZ+dQJw/sGeDvXHsAor7tfp24PRKQ3af+hgWqB/Ah
         Rpd+1UBPoKbEljJLCsyxebXoo5EjK9PFx3LQFdkRKXWhm2iwz1RmSOkhPmGnYBcQDj
         U7yhSzHOpY1Yg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8C823C64457;
        Sat,  2 Sep 2023 00:00:52 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for 6.6-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230901182054.110950-1-dave.hansen@linux.intel.com>
References: <20230901182054.110950-1-dave.hansen@linux.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230901182054.110950-1-dave.hansen@linux.intel.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86-urgent-2023-09-01
X-PR-Tracked-Commit-Id: 18032b47adf1db7b7f5fb2d1344e65aafe6417df
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2fcbb03847d89155d7b33d75ffee3a6bc5c51c97
Message-Id: <169361285257.26727.3608801685567681850.pr-tracker-bot@kernel.org>
Date:   Sat, 02 Sep 2023 00:00:52 +0000
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     torvalds@linux-foundation.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri,  1 Sep 2023 11:20:54 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86-urgent-2023-09-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2fcbb03847d89155d7b33d75ffee3a6bc5c51c97

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
