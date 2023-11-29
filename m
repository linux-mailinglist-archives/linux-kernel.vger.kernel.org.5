Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4997FD41C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 11:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbjK2K3D convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Nov 2023 05:29:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjK2K3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 05:29:02 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8F91AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 02:29:09 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1r8HoR-0002qK-Tw; Wed, 29 Nov 2023 11:28:59 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1r8HoQ-00CNkv-P8; Wed, 29 Nov 2023 11:28:58 +0100
Received: from pza by lupine with local (Exim 4.96)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1r8HoQ-0004uR-2I;
        Wed, 29 Nov 2023 11:28:58 +0100
Message-ID: <2fd0e3690c94e70a58d21b83694ef5fcff520663.camel@pengutronix.de>
Subject: Re: [PATCH v2 1/4] dt-bindings: reset: Add syscon to nuvoton ma35d1
 system-management node
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Jacky Huang <ychuang570808@gmail.com>, linus.walleij@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, j.neuschaefer@gmx.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ychuang3@nuvoton.com, schung@nuvoton.com
Date:   Wed, 29 Nov 2023 11:28:58 +0100
In-Reply-To: <20231128061118.575847-2-ychuang570808@gmail.com>
References: <20231128061118.575847-1-ychuang570808@gmail.com>
         <20231128061118.575847-2-ychuang570808@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Di, 2023-11-28 at 06:11 +0000, Jacky Huang wrote:
> From: Jacky Huang <ychuang3@nuvoton.com>
> 
> Add a compatible 'syscon' to the system management node since the system
> control registers are mapped by this driver. The other driver must access
> the system control registers through 'regmap' using a phandle that
> references this node.
> 
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

to be applied together with the dts changes.

regards
Philipp
