Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3E27B2541
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 20:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbjI1S2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 14:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbjI1S2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 14:28:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330E611F;
        Thu, 28 Sep 2023 11:28:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D0102C433CA;
        Thu, 28 Sep 2023 18:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695925679;
        bh=8xsvnY8JPtCd+wzpLD4rkb9A2HNxE21H+WH9fdnT7Z8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ipYO14THivLOwUSRyPZzJs6ZJCD2+kD7Og3a7RBrA60k0iYyXhnV2m/QcBOk8Bx6K
         CnTdxIMEBc8GT5YJkCAVwpJ8azEJbtvLmxcYedQW3IQ3VBm40q8EnyydM6CfRng6ah
         8MtYT6pAc27C21hsl6xGkSxaL7buCwWl3x2ok8RjnwLH7yw76ND7Q483hT3aubRICC
         ddwqYjZDl0WkhmAxBDRCgW2sHVitqtPFt2yzhR7xPFCS6OIxzNbJMPYlXOjCGsIeIk
         YH/jq3cd4aJCRAtfS6dwkSLWPS66T/MyMPY/taWxMPKxzggC+7HCORRDyAE5SnkvvV
         getNrtXJFNFKw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BBCBCE29AFE;
        Thu, 28 Sep 2023 18:27:59 +0000 (UTC)
Subject: Re: [GIT PULL] MIPS fixes for v6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZRUzwtxcT7lD6CCv@alpha.franken.de>
References: <ZRUzwtxcT7lD6CCv@alpha.franken.de>
X-PR-Tracked-List-Id: <linux-mips.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZRUzwtxcT7lD6CCv@alpha.franken.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips-fixes_6.6_1
X-PR-Tracked-Commit-Id: ef8f8f04a0b25e8f294b24350e8463a8d6a9ba0b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 52a6d9b53ea1dd0d20a65532dfb0ab02b1cb452c
Message-Id: <169592567976.30580.2810596274553247845.pr-tracker-bot@kernel.org>
Date:   Thu, 28 Sep 2023 18:27:59 +0000
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     torvalds@linux-foundation.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 28 Sep 2023 10:05:22 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips-fixes_6.6_1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/52a6d9b53ea1dd0d20a65532dfb0ab02b1cb452c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
