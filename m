Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C2B806B0F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 10:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377280AbjLFJuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 04:50:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377254AbjLFJuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 04:50:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9D8109
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 01:50:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2E84C433C9;
        Wed,  6 Dec 2023 09:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701856224;
        bh=IYirpk9Zuv663jhWbzf8HfLvsoJDvN1k0rophts0q9I=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=cwXPedNz3opDAYq+xJxJX5vFliJiGNkcoW/FuI4Eu/irzT1TJhylZSClp1303uG8K
         kQPtsVJwbzgvtRXW3V5hPt/zN+r91cJQEis9DkeJChu3YulKX6JhTaFtFwoJCfSJNb
         EozKE+WLvtn70OufSSfIy9Lpi7ZeZKmRsl8+e17Fk03jAxtdaTPx0bT6V8o0wjyUxI
         tCKxRJH/6TSVfeX2Fuv4OOLqE+mfnxWVRDegzg8bRZjvxFeQN8EoSvghdMfwyCMd30
         dt7ZboR+t4LO8bzXNOzyO1MZCQp7GrFn72f3N9ID39zvI9DwVvA2B10TBi8Zm5td7t
         y0MpcIDTbOtkQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DC267DD4F1F;
        Wed,  6 Dec 2023 09:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] r8152: add vendor/device ID pair for ASUS USB-C2500
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170185622389.11676.14511333566632987056.git-patchwork-notify@kernel.org>
Date:   Wed, 06 Dec 2023 09:50:23 +0000
References: <20231203011712.6314-1-kelly@hawknetworks.com>
In-Reply-To: <20231203011712.6314-1-kelly@hawknetworks.com>
To:     Kelly Kane <kelly@hawknetworks.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat,  2 Dec 2023 17:17:12 -0800 you wrote:
> The ASUS USB-C2500 is an RTL8156 based 2.5G Ethernet controller.
> 
> Add the vendor and product ID values to the driver. This makes Ethernet
> work with the adapter.
> 
> Signed-off-by: Kelly Kane <kelly@hawknetworks.com>
> 
> [...]

Here is the summary with links:
  - r8152: add vendor/device ID pair for ASUS USB-C2500
    https://git.kernel.org/netdev/net/c/7037d95a047c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


