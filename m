Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859187D19B9
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 01:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjJTXz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 19:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJTXzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 19:55:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBA9D51
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 16:55:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D27C433C8;
        Fri, 20 Oct 2023 23:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697846123;
        bh=RdH0R62ubdsvm6yoL5pHnjKkl2MqWF7NGcqJh85kZO0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QED9SpgO5zyForucyabZCmm3rGMTFcpq43GNFNr7Pfr/TLd1C3c4j3oQgEqjYPrGh
         JNaaLYIXFIuvZJdemRvc4+qcNEIpo+GYxFbTaJlSdQHPmJEZe3+rNDSwI2k3cp5tHg
         De0RlWbpRf3bj3FWwKY7sofraW8b/mKPfq0W2UoVuuQ643RdnWdL2iO9sDDbJtm0Ud
         TIFAaMs+LwkoECoi8gk3YUfaRggMoAlSUVwzoX7O22UKvaA5Ay1ccI9659zBNopCFg
         uHUBQxftOhAo2qrEiTcAjPJit32RMBIgStna11dIV53bGV7fW+wheusJ9uvwvE6bCE
         zzanBDJnDMkbQ==
Date:   Fri, 20 Oct 2023 16:55:22 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Heiner Kallweit <hkallweit1@gmail.com>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        netdev@vger.kernel.org,
        Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: Re: [PATCH net-next v3 0/3] fix forced link mode for KSZ886X
 switches
Message-ID: <20231020165522.78aec32c@kernel.org>
In-Reply-To: <20231019111459.1000218-1-o.rempel@pengutronix.de>
References: <20231019111459.1000218-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2023 13:14:57 +0200 Oleksij Rempel wrote:
> Oleksij Rempel (2):
>   net: dsa: microchip: ksz8: Enable MIIM PHY Control reg access
>   net: phy: micrel: Fix forced link mode for KSZ886X switches

Looks applied, thanks!
