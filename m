Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97CD7BC989
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 20:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344097AbjJGSMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 14:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJGSMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 14:12:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35628BA
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 11:12:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4B1EC433CB;
        Sat,  7 Oct 2023 18:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696702354;
        bh=oa4kHR/J+jkn7hFyFKROvjJFBDTHlz90wCnpkm+Hd5A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=eQ/VGGPHnLsbljzF77HhpIAw2ZGB6/Xsy8gQdtjOzaExI109d1YPJ67zYLv5KzLCV
         QAfcIBBSuHBUFq1oJENGUhSoZBEYHoYDHKPsTluylWZwBoi3wtnObbgseY0fzyUkjP
         HDnetSsNHCYvHOez2I3tnwJUyawgM5N8FDLYnRPBy6dZLuwvThDdAOrdCF4wzRCgrQ
         +ymIhRDCTHx/IcFUUMuuvhDuzvdJO2lsY4ep67V2zV7I35qpE7xigwUvYJpUXjDpnp
         IBh2Yy/cvu+1mQZXgNm9EieWZcMtriiof9Mvgb39bQ0THti1aZDSPQNyC0cA5DUla8
         PyD/8c1xNHVdg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A1B1FE632D6;
        Sat,  7 Oct 2023 18:12:34 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree fixes for v6.6, take 2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231006190106.GA143694-robh@kernel.org>
References: <20231006190106.GA143694-robh@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231006190106.GA143694-robh@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.6-2
X-PR-Tracked-Commit-Id: 19007c629c63c76ae0f8adee9dc076bda4788b46
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5e5558f5c9d8caa58a57427cd32f870aec3a69fb
Message-Id: <169670235465.17695.8884013446146011640.pr-tracker-bot@kernel.org>
Date:   Sat, 07 Oct 2023 18:12:34 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 6 Oct 2023 14:01:06 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.6-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5e5558f5c9d8caa58a57427cd32f870aec3a69fb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
