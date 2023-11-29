Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4727FDBE6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235027AbjK2Pr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:47:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235043AbjK2PrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:47:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D880170E
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:47:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3936C433C8;
        Wed, 29 Nov 2023 15:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701272842;
        bh=d3gt2pREE1sy0WhzSvItx8bCjSwa/mbOlEtQRCq9L6k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DvUBnjI50H6IOBbIP4gW3m4Sh6GuvFG2us3wE250WoFZlQ+rxcXOdVYWsH32pAj4x
         K+NyTVdi2uNOTA4vvZezEJLV2IFffQLYX0icV6GZQayqsSV1yG0PxBfTs75KnoPk4+
         sd2NJyZiQ//p1gbYJA1VlGIpoIsDBJlb9ZVaNmrrGK/Y6QUdalovo3X94FtyZDRicN
         QUmAeb9iR/HJtnilyelFqE/j6XwtuoC5oXHMcER+PZgFCJWXRFrvDLwn32JJJgQGgK
         MF3xdd8CvfClbf/+zJ3spBNsc5icOZoZkxtFQbUsafeVL2aFtKyLiLrjccL6Bx73hS
         V+YBl6ff84idw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C129EDFAA81;
        Wed, 29 Nov 2023 15:47:22 +0000 (UTC)
Subject: Re: [GIT PULL] Pin control fixes for v6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdZtVNZFWSUgb4=gUE2mQRb=aT_3=zRv1U71Vsq0Mm34eg@mail.gmail.com>
References: <CACRpkdZtVNZFWSUgb4=gUE2mQRb=aT_3=zRv1U71Vsq0Mm34eg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-gpio.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdZtVNZFWSUgb4=gUE2mQRb=aT_3=zRv1U71Vsq0Mm34eg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v6.7-2
X-PR-Tracked-Commit-Id: 90785ea8158b6923c5d6a024f2b1c076110577b5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3b47bc037bd44f142ac09848e8d3ecccc726be99
Message-Id: <170127284278.10361.6469775362333533374.pr-tracker-bot@kernel.org>
Date:   Wed, 29 Nov 2023 15:47:22 +0000
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Maria Yu <quic_aiquny@quicinc.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Chester Lin <clin@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 29 Nov 2023 13:09:03 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v6.7-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3b47bc037bd44f142ac09848e8d3ecccc726be99

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
