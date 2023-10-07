Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F077BC988
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 20:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344114AbjJGSMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 14:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjJGSMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 14:12:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0241AB;
        Sat,  7 Oct 2023 11:12:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 469A8C433C8;
        Sat,  7 Oct 2023 18:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696702355;
        bh=KjAZCPX3IuGfslWUZILvg0c2gv4IBE2fXitmOzO1RIs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ZOb9Cphd/76l7evD3cFmvWCL8D7thfPMXi/+fKW0hzQHku4keMzOS37eje+v4Tx8u
         NXwOUF9hA/HV41NV3MmGjtgI+X5pENCPA+K+djHxwClIACYE5yfPpxX2aUNHObCwe1
         09pmuDuG4DKUuhs5beWCVti0qbcqowe2sBiw56HCIFkwac+jo5W1lX0imSjRp+7vVY
         tQrjpccoqipC0Mj8f8pfh4uMuPFuCj4YYVpNXP67qH78iDJib2BVGDxFKszz2jTz7t
         9pK+a6ZIIGqSCv8U0/VAKk33Gl8nv7SMJUUWCYlwWn6CdnYmP6cqzJ3WbXP/D17/AG
         fiD5aL+GjKmeQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2B114C41671;
        Sat,  7 Oct 2023 18:12:35 +0000 (UTC)
Subject: Re: [GIT PULL for v6.6-rc5] media fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231007091853.29a80d85@sal.lan>
References: <20231007091853.29a80d85@sal.lan>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231007091853.29a80d85@sal.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.6-3
X-PR-Tracked-Commit-Id: 1146bec0ca34375f963f79f5c4e6b49ed5386aaa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b036cda9d5240e07383c83418ad2885f38d9ded4
Message-Id: <169670235517.17695.3433755845010715582.pr-tracker-bot@kernel.org>
Date:   Sat, 07 Oct 2023 18:12:35 +0000
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
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

The pull request you sent on Sat, 7 Oct 2023 09:18:53 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.6-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b036cda9d5240e07383c83418ad2885f38d9ded4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
