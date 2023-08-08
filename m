Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5F3774DDE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 00:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbjHHWA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 18:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjHHWAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 18:00:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3DF12D;
        Tue,  8 Aug 2023 15:00:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8359362D8C;
        Tue,  8 Aug 2023 22:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9F24C433C9;
        Tue,  8 Aug 2023 22:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691532021;
        bh=0CjdeW56CS2059Vkt0DNasnDqdrqZiTUPNvFROKH9Ko=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ZFemw6DCXpLlNx2M8biWQnKG3G228tzyxO2dijgeS5BR8kYOhiNBGzBKha5+8d+b2
         H+k1cuGzP7aOdznQujTvJWUvn2gbn5el8wfXv0ckwsOco5A349k4qSpCkdR2l2rDPJ
         /VjtO3ISJJnBU0HNKQG//Cco7C9TWwu0woPCTD18X8jWuxJSRRV+RzWBejgo/u9tTd
         jbq3m4HVzjWmd4F3Pa9xDXTAf89j+F2oyLPA4YKE2BKJwajq/nn22fqOOwpOLhVdS4
         2UaIpasp0qBxfi2P/3Ciw85m047r/IcMGcuaKbF08+sZx2IlAYJIflQoRUIWKIs9l1
         iIzTLi4REA3dA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B9192C395C5;
        Tue,  8 Aug 2023 22:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] MAINTAINERS: update Claudiu Beznea's email address
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169153202174.6931.11202742037860925480.git-patchwork-notify@kernel.org>
Date:   Tue, 08 Aug 2023 22:00:21 +0000
References: <20230804050007.235799-1-claudiu.beznea@tuxon.dev>
In-Reply-To: <20230804050007.235799-1-claudiu.beznea@tuxon.dev>
To:     claudiu beznea <claudiu.beznea@tuxon.dev>
Cc:     nicolas.ferre@microchip.com, conor.dooley@microchip.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, maz@kernel.org,
        srinivas.kandagatla@linaro.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, sre@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-pwm@vger.kernel.org, alsa-devel@alsa-project.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  4 Aug 2023 08:00:07 +0300 you wrote:
> Update MAINTAINERS entries with a valid email address as the Microchip
> one is no longer valid.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> 
> [...]

Here is the summary with links:
  - MAINTAINERS: update Claudiu Beznea's email address
    https://git.kernel.org/netdev/net/c/fa40ea27ede3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


