Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307107D17B2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 23:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbjJTVIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 17:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjJTVIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 17:08:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56575112
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 14:08:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F30F2C433C7;
        Fri, 20 Oct 2023 21:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697836080;
        bh=r3v80w6Wcqh/7K95U1NJAWREKtTllxrfj7m6laTXixQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uhMMC7D4348x3m4ODSsAiIg2hNTNXXSM91i8pOWxkcNyAG680wAPYSwi8QnjKme+7
         O+3VIsjCdh4rtW0cNIdRI/HT+yb9GpHWQzgoosOIDHUHB51yhHetdB0nSX+vYw1+5o
         0su8jKu9XzMqHaOYOEez+U38QD0YnTQMKMxd4ybySzdSMUkfxeyuCESZqt85f4pmm5
         6XgnZO19Oj8NvwUz01zY4wyHPjxzizvPaN3n9HTJby+q3ml+zOuEX25dznlgfvs1EO
         SnK2zYRZu2u0+pALx25hz908hJrGd8UEdA2tmVVFSXMOMOOvLGAJEplYQzeCkUqofU
         GgbhnM6PP3VOw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D6EA6C595CB;
        Fri, 20 Oct 2023 21:07:59 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fixes for v6.6-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gJZdGLmJQvKcOtVuJr1XX8J_3kH2jg2rUM1=_1XPCknw@mail.gmail.com>
References: <CAJZ5v0gJZdGLmJQvKcOtVuJr1XX8J_3kH2jg2rUM1=_1XPCknw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gJZdGLmJQvKcOtVuJr1XX8J_3kH2jg2rUM1=_1XPCknw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.6-rc7
X-PR-Tracked-Commit-Id: 9caa3a2de955238df742572812178568fed173f7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f20f29cbcb438ca37962d22735f74a143cbeb28c
Message-Id: <169783607987.30992.4792776334030206387.pr-tracker-bot@kernel.org>
Date:   Fri, 20 Oct 2023 21:07:59 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 20 Oct 2023 18:39:01 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.6-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f20f29cbcb438ca37962d22735f74a143cbeb28c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
