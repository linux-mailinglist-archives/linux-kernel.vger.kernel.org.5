Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400D07903B3
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 00:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350914AbjIAWk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 18:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350915AbjIAWk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 18:40:26 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D960E10E0;
        Fri,  1 Sep 2023 15:40:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 56ECBCE240F;
        Fri,  1 Sep 2023 22:40:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E58B9C433C7;
        Fri,  1 Sep 2023 22:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693608017;
        bh=FX91qLUPL+aqjdwh/qYmQMs0fQruwSMxGsEiL0OqDnw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=N1afeLzmiBOpNFZcu2733OnX48s/ErdgatvI5jl6gIrdfGMAQTUPrOEqCmjKqML1A
         ORTWtaWuAXlmzbqEn5IgdFjF83SlVtSVo1tXGR1nxDuHNsw1+4FxZtKX7gg9/LoY32
         yU7EFCYUYoFEsE67fVQ1trqS2Hh1/kjIDXHJeQKnkLvBwBlOTUAhKAg7IYbZtcNggB
         AlU7g2Y8P9t8hCiCiFdklkKFm4/YFJqkyZxD6hyuwjBBgsY61tz6CA4h5sz5gTbaOo
         xtggmM/NawFj52hWyjZL0skEREaYsimprqAAQuFmEaXERuhUIGPHZ9JcUDGqCMMTFn
         yfDTGdbwH1W+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BF547C595D2;
        Fri,  1 Sep 2023 22:40:17 +0000 (UTC)
Subject: Re: [GIT PULL for v6.6-rc1] media updates
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230901142147.096c1b57@sal.lan>
References: <20230901142147.096c1b57@sal.lan>
X-PR-Tracked-List-Id: <linux-media.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230901142147.096c1b57@sal.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.6-1
X-PR-Tracked-Commit-Id: 9a5d660fdb25d20748d7f9e9559c86073c3bb368
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 307d59039fb26212a84a9aa6a134a7d2bdea34ca
Message-Id: <169360801774.11463.711568536057455009.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Sep 2023 22:40:17 +0000
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 1 Sep 2023 14:21:47 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.6-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/307d59039fb26212a84a9aa6a134a7d2bdea34ca

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
