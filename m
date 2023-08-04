Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3328E76FCF7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 11:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjHDJNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 05:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjHDJNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 05:13:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8103D61BF
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 02:10:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7A2C61F6F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 09:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 15612C433C8;
        Fri,  4 Aug 2023 09:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691140222;
        bh=ElrTr0KImreqshMP4TKsA/38QJgKf1pDIAjqzXeEBnc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=AS/C1L/lErzkSX8TSf7vKA/PVXhpZ7bzm5HDC2ILi0kOEHjdQHkhhtRW7eWYXQoL2
         g2uZiGndTFXx1PfS8AtsRUQXFfxVjezevZdcvueNAuGtwTwm8wyrRf3H29qNd4U3ie
         mDk7szWkOEwLefVCN4w6RM4S4dYShONzuWcClUsPuxGHOoz6emkPJ5wLzkpgfZKDQn
         RPn9uEtH27wkmduTJj7T265adwwx7Tz06g3ERszrVfC1ccXJIQt+l3EpBzspACZygP
         ZtjSRM/k1Vu5CllNZiJ/Q5/xR5X3/BOW+vFVUJMfRGXO8y5zwe6AdIYc4+NB9YTuF1
         NUQHGArCQYDLg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EEF26C43168;
        Fri,  4 Aug 2023 09:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/2] fix at803x wol setting
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169114022197.4386.8349205349314347060.git-patchwork-notify@kernel.org>
Date:   Fri, 04 Aug 2023 09:10:21 +0000
References: <20230802191347.6886-1-leoyang.li@nxp.com>
In-Reply-To: <20230802191347.6886-1-leoyang.li@nxp.com>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, kuba@kernel.org, mail@david-bauer.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed,  2 Aug 2023 14:13:45 -0500 you wrote:
> v3:
>   Break long lines
>   Add back error checking of phy_read
> 
> v4:
>   Disable WoL in 1588 register for AR8031 in probe
> 
> [...]

Here is the summary with links:
  - [v4,1/2] net: phy: at803x: fix the wol setting functions
    https://git.kernel.org/netdev/net/c/e58f30246c35
  - [v4,2/2] net: phy: at803x: remove set/get wol callbacks for AR8032
    https://git.kernel.org/netdev/net/c/d7791cec2304

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


