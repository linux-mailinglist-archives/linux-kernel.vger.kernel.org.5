Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D02680203F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 02:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbjLCBYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 20:24:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbjLCBYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 20:24:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2960129
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 17:24:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7A5B3C433CA;
        Sun,  3 Dec 2023 01:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701566687;
        bh=7f5EVCSsNpss6fTojoWJrhodfKx9QcHWsqI+ABA9A4s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=puaLB16JiOVLpkEtkxk1R40A5mOAGT7Myz97ltBaRGyobyntdG6CZFwZhxg0yWJuT
         gjUMZeAMaYKkElYhVfAtJ61utRI56EI+EdK2iJPTiqKZBDYB8KZqqUrZUDYwaUbU7y
         kF29jb8gdSoKMLzQU1FlmXdyf3JIB3fiVS4jBd/EOTPLz1lbXrJ2dDpSACZljEhRwq
         WUGF9QOwfI/XeH6igbw626xIUeUORSqcv5QX2rQli3XltaWd9o6pwHwiHya6MOSkxN
         FlVLut2hGujk59hQhhAz52TVx5TM98Q8E9LpXl0AeYYDqJ6tXMhVv5xxtVGnqINOlh
         Zz0nd/HyYTFXw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 61D0CDFAA84;
        Sun,  3 Dec 2023 01:24:47 +0000 (UTC)
Subject: Re: [GIT PULL] firewire fixes for v6.7-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231202080648.GA34377@workstation.local>
References: <20231202080648.GA34377@workstation.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231202080648.GA34377@workstation.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-fixes-6.7-rc4
X-PR-Tracked-Commit-Id: 891e0eab32a57fca4d36c5162628eb0bcb1f0edf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 55abae438c3cf39f66c3e0cb922c3d915363afb5
Message-Id: <170156668739.5793.14656283857320346829.pr-tracker-bot@kernel.org>
Date:   Sun, 03 Dec 2023 01:24:47 +0000
To:     Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 2 Dec 2023 17:06:48 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-fixes-6.7-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/55abae438c3cf39f66c3e0cb922c3d915363afb5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
