Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E94772E9C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 21:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjHGTZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 15:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjHGTZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 15:25:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA4E1715;
        Mon,  7 Aug 2023 12:25:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1C4262189;
        Mon,  7 Aug 2023 19:25:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E4C3C433C8;
        Mon,  7 Aug 2023 19:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691436310;
        bh=HBhmn9HKnS8/O4AzZaFEuYjZPHI6Gi65ywDrGFhu+O0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iSgi+eNKKTdMVpyW4QT8CWFt2D/ck3D8JFsVcpRQZt8qC3K8iW0GNCQ74ZjKY3T1x
         RXHFscGL/uKRCEYjTWZAIS8fOSWf7o3y8HJgai22AzGjxiPMVyOpfd7F/b0NcRD1DP
         Y81MHqQ/P+pWUDVfZ/VRfbQSmf3so9ouxkxbnj73Ra0LZdZtG6OzzRAwtreCoIk2MJ
         24kI+jifaiY98fTAlm4iRCFGDM/V23pCUMCBi8RT5oWkSNVMkMwcPDAfbgi0pB6qcg
         ubCVJkTca1I6BDmxeBqCoCLxOm2hRMnmqerH3nGEXqRfboWZ92AwjHsfs9tdm8VDUN
         NfDqeClA+N67w==
Date:   Mon, 7 Aug 2023 12:25:08 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc:     nicolas.ferre@microchip.com, conor.dooley@microchip.com,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, maz@kernel.org, srinivas.kandagatla@linaro.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        sre@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org,
        alsa-devel@alsa-project.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: update Claudiu Beznea's email address
Message-ID: <20230807122508.403c1972@kernel.org>
In-Reply-To: <20230804050007.235799-1-claudiu.beznea@tuxon.dev>
References: <20230804050007.235799-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  4 Aug 2023 08:00:07 +0300 Claudiu Beznea wrote:
> Update MAINTAINERS entries with a valid email address as the Microchip
> one is no longer valid.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

Thanks for updating the email!

A bit of a cross-tree change. Is there anyone in particular that you'd
expect to apply it? If nobody speaks up we can pick it up in networking
and send to Linus on Thu.
