Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85FEB7E0D3E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 03:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345854AbjKDCKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 22:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235581AbjKDCK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 22:10:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18A3D54
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 19:10:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 96BC4C433C7;
        Sat,  4 Nov 2023 02:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699063826;
        bh=uWDvqXMY70eK2LgORMSCL99YgEROtmXqZhegNCFnBbI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HauFGIFnisOpH02CkzEHyHhJl61I2zEWx4UAda0+U1EQw67yYqgIhlShVJZuu8ZZe
         TeaeyKbiwdCG5fbwtPQOxkh2nQmXtChbFsQN5Qv8P5I6sOGytkULcuwEjusNxcRcrd
         vqjmcBt3UhetFeUdZkaMtTyacn0UHlwwmM7HO3ANW/vz3TtWR+T0OSFRTRqBmvmO8y
         VD59yulb+DLzgObPCduLI2VVMvLmzq0RsUf4haJiOLpv6o6TbEqTKkbRkWTfGPPH7+
         Eu/FKCdyhJfeVbbnji6TxVF5sKgbH1hsfkjirMTkQFitLaUZeDVqjid7jK47PToAG3
         dZj2VVQNUZ9fw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8480CEAB08A;
        Sat,  4 Nov 2023 02:10:26 +0000 (UTC)
Subject: Re: [GIT PULL] USB/Thunderbolt changes for 6.7-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZUTiWrNrErlNa4Hk@kroah.com>
References: <ZUTiWrNrErlNa4Hk@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZUTiWrNrErlNa4Hk@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.7-rc1
X-PR-Tracked-Commit-Id: c70793fb7632a153862ee9060e6d48131469a29c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2c40c1c6adab90ee4660caf03722b3a3ec67767b
Message-Id: <169906382653.26291.15101406422947685153.pr-tracker-bot@kernel.org>
Date:   Sat, 04 Nov 2023 02:10:26 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 3 Nov 2023 13:06:50 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2c40c1c6adab90ee4660caf03722b3a3ec67767b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
