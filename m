Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA8C7F5AAC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 09:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbjKWI6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 03:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjKWI6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 03:58:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9613992
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 00:58:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13566C433C7;
        Thu, 23 Nov 2023 08:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700729926;
        bh=q2nqQ+Ft1eQOUW2X9fgHDH+zIoCWzHvJ+cSPKg6Yw3M=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=lvd7A4hFcdMNj5XSeCqeJ2MhP6sCi+JAPE3Xhxl5xsJ5vZnefKU5jnWSo/B3Xe8V+
         uWPkaJ6XQ/o9btVX9i4Dv2zfn60ZZidA5YNG5xr3d8XO49SqUC6J0IJ8in69iX2wYt
         GXDZaMGXROxvNAczsR3bFcpl2HDwyUZZB2HZkhsZIGZdaZiAs4tTn8iH/rn96iRxU7
         BfOVuhhbwq3lg/3UMpIV3diMOnoX6y0j4CGlgqOtbtawy1lE/gh2Wme89SgInv+oaX
         QbJvWHnkoBN20G1LIMalkM4M5wEw9ZSr/dRFUILoqDBT7qnLDOqpers90nl40WHxcC
         R2ZZtQS/EIeoQ==
From:   Lee Jones <lee@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231025190619.881090-2-robh@kernel.org>
References: <20231025190619.881090-2-robh@kernel.org>
Subject: Re: (subset) [RESEND PATCH v2] leds: syscon: Support 'reg' in
 addition to 'offset' for register address
Message-Id: <170072992481.1182056.5764147055955802436.b4-ty@kernel.org>
Date:   Thu, 23 Nov 2023 08:58:44 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Oct 2023 14:06:19 -0500, Rob Herring wrote:
> The register-bit-led binding now also supports 'reg' in addition to
> 'offset' for the register address. Add support to the driver to get the
> address from 'reg'.
> 
> 

Applied, thanks!

[1/1] leds: syscon: Support 'reg' in addition to 'offset' for register address
      commit: 9add14f2aa3b7b456098819fb5e5750712db9cc5

--
Lee Jones [李琼斯]

