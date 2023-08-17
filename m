Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65DC77F2AC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349251AbjHQJCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349199AbjHQJCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:02:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD04E7C;
        Thu, 17 Aug 2023 02:02:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3A7865849;
        Thu, 17 Aug 2023 09:02:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A173C433C8;
        Thu, 17 Aug 2023 09:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692262965;
        bh=2K0mOvdLVYot4yM2dbRCrhM+ezmv+6+DN71qkUag0og=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=XRnK8pKBGSDOnJbIMy3dt8DFANMEG3t7HTyLROzBvNUwpFfvJ2G5XzWBBHXVkPzlS
         2UN48JgGZSj4DjV+XvoZxNO7672fiJ2hq+dm+xmORb3+4rOjoChW92aMZxD5oh5S0X
         I6BL85ln2uaL7REddJ05zcPhtrpjeeQVKqXqfZp+0b4197EN0TFZGj4hxOm6ebSebF
         zAYayVSUSpYF1EjAkNzljdecvu8kt45hIJ1ajCoWeEOWyiOQ+pGtDnPq2jsGUBZ3w5
         DaVOsCWcuwkgLULYUJxjjGB+I2kh90U3TT6wrk7OFHBmnBANysGaU3/aiOJ/8MFtmT
         1bCQfVCuq+fMA==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Varshini Rajendran <varshini.rajendran@microchip.com>
In-Reply-To: <20230728102515.265971-1-varshini.rajendran@microchip.com>
References: <20230728102515.265971-1-varshini.rajendran@microchip.com>
Subject: Re: (subset) [PATCH v3 14/50] dt-bindings: mfd: at91: Add SAM9X7
 compatible string
Message-Id: <169226296284.927813.7139064617270404641.b4-ty@kernel.org>
Date:   Thu, 17 Aug 2023 10:02:42 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jul 2023 15:55:15 +0530, Varshini Rajendran wrote:
> Document sam9x7 DT for flexcom.
> 
> 

Applied, thanks!

[14/50] dt-bindings: mfd: at91: Add SAM9X7 compatible string
        commit: 8d86ce06e75827b94fcad3a0c2121bbf8e907718

--
Lee Jones [李琼斯]

