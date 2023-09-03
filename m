Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C94F790DA6
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 21:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346487AbjICTQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 15:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242408AbjICTQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 15:16:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9043F94
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 12:16:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E7EC61048
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 19:16:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8E06BC433C9;
        Sun,  3 Sep 2023 19:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693768584;
        bh=K3HDUzIIVA0hF+pHI86YXjjRnU3dHOZDiBACSgdSNPs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XzuKCMbWdrPPRHltkJURn3nm4rRugUBCKwk2RVz5Tr6PiNisqKev6uilA3CLaLUCp
         6A4gIgM1GVHH/LS+Mvht5T1aVNA53vHdvzELrBYwGjXXZzIni9EPQF5UDhAl/TGj9Z
         mLl5/iGzTwjM8l/3fLJ+XdN/kgY0O5/Adsi5nYMUYOrWovmnYMy0W+PwOhxad8/sbg
         IcPeT0vIrQPgr7zlFk79jkDdiIFs4nRV0sx69dANkrHxyzBlsMedA3ETlJz4e3d9iN
         TZnE5q8mR93w1K3GX0ABhvb3hAsFgG7X/7cV+Jjr6YoVbh80eRfPlOcMvP4zafqk7U
         mPSEfpqwXGz+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 62EAEE29F3D;
        Sun,  3 Sep 2023 19:16:24 +0000 (UTC)
Subject: Re: [GIT PULL]: Soundwire subsystem updates
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZPS/vF/gX+sohJis@matsya>
References: <ZPS/vF/gX+sohJis@matsya>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZPS/vF/gX+sohJis@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-6.6-rc1
X-PR-Tracked-Commit-Id: 8c4c9a9ae5aff2125ea44f0b26f9e3701d56d6db
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6e32dfcccfcc58e46c484357ee060d42d8481df8
Message-Id: <169376858389.17631.9451108955706315119.pr-tracker-bot@kernel.org>
Date:   Sun, 03 Sep 2023 19:16:23 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 3 Sep 2023 22:47:48 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-6.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6e32dfcccfcc58e46c484357ee060d42d8481df8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
