Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4F77A68C7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 18:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjISQXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 12:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjISQXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 12:23:36 -0400
Received: from core.lopingdog.com (core.lopingdog.com [162.55.228.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A591FA9;
        Tue, 19 Sep 2023 09:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lopingdog.com;
        s=mail; t=1695140606;
        bh=Woe2zlZDrX1NMXrzPvFZV2LgN/Rs7Rh4uAbjBGwpwEE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QicWKvOnsh6s2OGtCxWeCVD2r3WVLRbWQo+7+pJ6n4zFlYleKs7BiQC3wMb4ARFV8
         b5JScBgyEdwiwcLX9F24H9XdTntLnUVnyolpe/94+YNUlHb1f5Zs2c0wVDfIA0JIp0
         y7ZGkY+g2cnyO5KknbRiEf8B7ESXqCTXorU/X09thC/5x18vYZJXe23TrIg1TwkC84
         jjn6BEA+8F1dla+Y62uSWWEWZGcj+dwSaX89ZFgRYpHfmCvQu9iNsN8FbbBoGvuIn5
         FJ5r6WzPO6Vc9dQq5FXuoxNmWoQPaASEXEtdWhugIhDaUpMqCb3QnqtrL7RNbHy+Co
         wL95Qac8om0mg==
Received: from authenticated-user (core.lopingdog.com [162.55.228.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by core.lopingdog.com (Postfix) with ESMTPSA id A4B9744057C;
        Tue, 19 Sep 2023 11:23:22 -0500 (CDT)
Date:   Tue, 19 Sep 2023 11:23:21 -0500
From:   Jay Monkman <jtm@lopingdog.com>
To:     Parthiban.Veerasooran@microchip.com
Cc:     Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
        Michael.Hennerich@analog.com, Ciprian.Regus@analog.com,
        andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        corbet@lwn.net, Steen.Hegelund@microchip.com,
        rdunlap@infradead.org, horms@kernel.org, casper.casan@gmail.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Horatiu.Vultur@microchip.com, Woojung.Huh@microchip.com,
        Nicolas.Ferre@microchip.com, UNGLinuxDriver@microchip.com,
        Thorsten.Kummermehr@microchip.com, ada@thorsis.com
Subject: Re: Fwd: [RFC PATCH net-next 0/6] Add support for OPEN Alliance
 10BASE-T1x MACPHY Serial Interface
Message-ID: <ZQnK+W1a1zmIFzPu@lopingdog.com>
References: <f6858856-53c4-5eb8-ab52-350aab280735@microchip.com>
 <41b6eb40-117c-cdcf-b986-b6f6cf3f21ca@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41b6eb40-117c-cdcf-b986-b6f6cf3f21ca@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>  From my next reply on-wards I will include Michael.Hennerich, Ciprian 
> Regus and Jay Monkman in the "--to" or "--cc" so that we can share our 
> ideas and comments.

Thanks for including me. Can you also include
Piergiorgio Beruto <piergiorgio.beruto@gmail.com>
He is also involved in developing the driver for onsemi's device.


Jay Monkman
